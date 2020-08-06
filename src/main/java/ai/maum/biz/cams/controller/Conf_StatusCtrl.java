package ai.maum.biz.cams.controller;

import ai.maum.biz.cams.dto.*;
import ai.maum.biz.cams.service.ConfStatusSvc;
import ai.maum.biz.cams.utils.CommonUtils;
import ai.maum.biz.cams.vo.FrontConfVO;
import ai.maum.biz.cams.vo.PagingVO;
import com.google.gson.Gson;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.constraints.Min;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class Conf_StatusCtrl {
    @Autowired
    CommonUtils cUtils;

    @Autowired
    ConfStatusSvc confStatusSvc;

    @RequestMapping(value="dashboard", method={RequestMethod.GET, RequestMethod.POST})
    public String dashboard(FrontConfVO frontConfVO, Model model){
        //차후 session 값에서 가져올 값.
        frontConfVO.setSite_ser("1");

        //각 사이트 리스트
        List<MinutesSiteDTO> siteList = confStatusSvc.getSiteListAll();
       // String siteListTag = cUtils.doSelectBoxTagSiteList(siteList, frontConfVO.getSite_ser());

        //사이트 일련번호 기준 미팅룸 리스트
        List<MinutesMeetingRoomDTO> meetingRoomList = confStatusSvc.getMeetingRoomListBySiteId(frontConfVO);

        //회의 현황 리스트 페이징을 위해서 쿼리 포함 전체 카운팅
        PagingVO pagingVO = new PagingVO();
        pagingVO.setTotalCount( confStatusSvc.getSttMetaListTotalCountBySiteId(frontConfVO) );  //전체 리스트 수
        pagingVO.setCurrentPage( frontConfVO.getCurrentPage() );                                //현재 페이시 세팅
        frontConfVO.setStartRow( pagingVO.getStartRow() );                                      //첫 페이지 세팅
        frontConfVO.setLastRow( pagingVO.getLastRow() );                                        //마지막 페이지 세팅
        frontConfVO.setPageInitPerPage( pagingVO.getCOUNT_PER_PAGE() );                         //페이지 당 로우수 세팅

        //회의 현황 리스트
        List<SttMetaDTO> sttMetaDTO = confStatusSvc.getSttMetaListBySiteId(frontConfVO);

        model.addAttribute("siteList", siteList);
 //       model.addAttribute("siteListTag", siteListTag);
        model.addAttribute("mrList", meetingRoomList);
        model.addAttribute("sttMeta", sttMetaDTO);
        model.addAttribute("frontConfVO", frontConfVO);
        model.addAttribute("paging", pagingVO);

        return "conf_status/dashboard";
    }


    //회의 설정 페이지
    @RequestMapping(value="setUpConf", method=RequestMethod.GET)
    public String setUpConf(FrontConfVO frontConfVO, Model model){
        //마이크 리스트
        List<MinutesMicDTO> micList = confStatusSvc.getMicListBySiteIdRoomId(frontConfVO);

        model.addAttribute("micList", micList);
        model.addAttribute("frontConfVO", frontConfVO);

        return "conf_status/setUpConf";
    }

    @RequestMapping(value="searchUser", method=RequestMethod.POST)
    @ResponseBody
    public String searchUser(@RequestParam("part") String part,
                                                @RequestParam("name") String name,
                                                @RequestParam("currentPage") String currentPage,
                                                HttpServletRequest request) {

        List<MinutesEmployeeDTO> list = null;

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("part", part);
        paramMap.put("name", name);

        PagingVO pagingVO = new PagingVO();
        pagingVO.setTotalCount( confStatusSvc.searchUserCnt(paramMap) );      //전체 리스트 수
        pagingVO.setCurrentPage(currentPage);                                //현재 페이시 세팅
        paramMap.put("startRow", pagingVO.getStartRow() );                   //첫 페이지 세팅
        paramMap.put("lastRow", pagingVO.getLastRow() );                    //마지막 페이지 세팅
        paramMap.put("pageInitPerPage",  pagingVO.getCOUNT_PER_PAGE() );   //페이지 당 로우수 세팅

        paramMap.put("currentPage", pagingVO.getCurrentPage()); // 현재 페이지
        list = confStatusSvc.searchUser(paramMap);

        JSONObject obj = new JSONObject();
        obj.put("userData", list);
        obj.put("paging", pagingVO);
        obj.put("pager", pagingVO.getPager());
        obj.put("frontConfVO", paramMap);


        return obj.toString();

    }


    //회의 설정 저장
    @RequestMapping(value="confSetUpSave", method=RequestMethod.POST)
    @ResponseBody
    public String doConfSetUpSave(HttpSession sess, FrontConfVO frontConfVO, Model model){
        //회의 예약 정보를 STT_META에 Insert할 값 설정
        frontConfVO.setMinutes_id( frontConfVO.getSite_ser() + "_" + frontConfVO.getRoom_ser() + "_" + cUtils.getTodate());

        if( StringUtils.isBlank(frontConfVO.getMinutes_type()) ){
            frontConfVO.setMinutes_type( "COM" );
        }
        if( StringUtils.isBlank(frontConfVO.getCreate_user()) ){
//            frontConfVO.setCreate_user( (String)sess.getAttribute("create_user") );
            frontConfVO.setCreate_user("123");      //회원정보 관리 연동 후 삭제
        }

        MinutesMeetingRoomDTO room =confStatusSvc.checkMinutesStatus(frontConfVO);
        Gson gson = new Gson();
        int confSaved = 0;

        if(room.getIng_cnt() == 0 && room.getRes_cnt() == 0 ) {
            confSaved = confStatusSvc.doConfSetUpSave(frontConfVO);
        }

        JSONObject obj = new JSONObject();

        obj.put("confSaved", confSaved);
        obj.put("minutes_id", frontConfVO.getMinutes_id());




        return obj.toString();
    }


    //회의현황.마이크설정 페이지
    @RequestMapping(value="setUpMic", method=RequestMethod.GET)
    public String setUpMic(FrontConfVO frontConfVO, Model model){
        //클릭한 마이크 정보 select
        MinutesMicDTO micListOne = confStatusSvc.getMicListBySiteIdRoomIdMicId(frontConfVO);

        model.addAttribute("frontConfVO", frontConfVO);
        model.addAttribute("micListOne", micListOne);

        return "conf_status/setUpMic";
    }


    //회의현황.마이크 설정 저장 페이지
    @RequestMapping(value="setUpMicSave", method=RequestMethod.POST)
    @ResponseBody
    public String doSetUpMicSave(FrontConfVO frontConfVO, Model model){
//          frontConfVO.setCreate_user( (String)sess.getAttribute("create_user") );
        frontConfVO.setCreate_user("123");      //회원정보 관리 연동 후 삭제

        confStatusSvc.doSetUpMicSave(frontConfVO);

        return "";
    }


    //회의현황.회의 참석자 검색 페이지
    @RequestMapping(value="setJoinEmp", method={RequestMethod.GET, RequestMethod.POST})
    public String setJoinedEmp(FrontConfVO frontConfVO, Model model){
        //차후 session 값에서 가져올 값.
        frontConfVO.setSite_ser("1");

        if( !StringUtils.isBlank(frontConfVO.getSchSel()) && frontConfVO.getSchSel().equals("empNo") ) {
            frontConfVO.setSchField("minutes_employee_ser");
        }else{
            frontConfVO.setSchField( frontConfVO.getSchSel() );
        }

        //직원검색 페이지 페이징을 위해서 쿼리 포함 전체 카운팅
        PagingVO pagingVO = new PagingVO();
        pagingVO.setTotalCount( confStatusSvc.getMinutesUserTotalCount(frontConfVO) );          //전체 리스트 수
        pagingVO.setCurrentPage( frontConfVO.getCurrentPage() );                                //현재 페이시 세팅
        frontConfVO.setStartRow( pagingVO.getStartRow() );                                      //첫 페이지 세팅
        frontConfVO.setLastRow( pagingVO.getLastRow() );                                        //마지막 페이지 세팅
        frontConfVO.setPageInitPerPage( pagingVO.getCOUNT_PER_PAGE() );                         //페이지 당 로우수 세팅

        //직원 리스트. 검색 적용
        List<MinutesEmployeeDTO> userList = confStatusSvc.getMinutesUserAllList(frontConfVO);

        model.addAttribute("paging", pagingVO);
        model.addAttribute("userList", userList);
        model.addAttribute("frontConfVO", frontConfVO);

        return "conf_status/setJoinedEmp";
    }


    //회의현황.상세정보
    @RequestMapping(value="detailView", method={RequestMethod.GET, RequestMethod.POST})
    public String doDetailView(FrontConfVO frontConfVO, Model model){
        //차후 session 값에서 가져올 값.
        frontConfVO.setSite_ser("1");

        PagingVO pagingVO = new PagingVO();
        pagingVO.setTotalCount( confStatusSvc.getDetailViewTotalCount(frontConfVO) );       //전체 리스트 수
        pagingVO.setCurrentPage( frontConfVO.getCurrentPage() );                            //현재 페이시 세팅
        frontConfVO.setStartRow( pagingVO.getStartRow() );                                  //첫 페이지 세팅
        frontConfVO.setLastRow( pagingVO.getLastRow() );                                    //마지막 페이지 세팅
        frontConfVO.setPageInitPerPage( pagingVO.getCOUNT_PER_PAGE() );                     //페이지 당 로우수 세팅

        List<SttMetaDTO> detailList = confStatusSvc.getDetailViewAllList(frontConfVO);

        model.addAttribute("detailViewList", detailList);
        model.addAttribute("paging", pagingVO);
        model.addAttribute("frontConfVO", frontConfVO);

        return "conf_status/detailView";
    }

  /*  @RequestMapping(value = "detailViewData", method = {RequestMethod.POST, RequestMethod.GET})
    public ModelAndView detailViewData(@RequestAttribute FrontConfVO frontConfVO,
                                       HttpServletRequest request,
                                       HttpServletResponse response) {

        ModelAndView view = new ModelAndView();
        view.setViewName("jsonView");

        frontConfVO.setSite_ser("1");

        //회의 결과 리스트 페이징을 위해서 쿼리 포함 전체 카운팅
        PagingVO pagingVO = new PagingVO();
        pagingVO.setTotalCount( confStatusSvc.getDetailViewTotalCount(frontConfVO) );       //전체 리스트 수
        pagingVO.setCurrentPage( frontConfVO.getCurrentPage() );                            //현재 페이시 세팅
        frontConfVO.setStartRow( pagingVO.getStartRow() );                                  //첫 페이지 세팅
        frontConfVO.setLastRow( pagingVO.getLastRow() );                                    //마지막 페이지 세팅
        frontConfVO.setPageInitPerPage( pagingVO.getCOUNT_PER_PAGE() );                     //페이지 당 로우수 세팅

        List<SttMetaDTO> detailList = confStatusSvc.getDetailViewAllList(frontConfVO);

        view.addObject("detailViewList", detailList);
        view.addObject("paging", pagingVO);
        view.addObject("frontConfVO", frontConfVO);

        return view;

    }*/


    //대시보드에서 회의 '시작 / 종료' 버튼 클릭
    @RequestMapping(value="meetingStatusUpdate", method=RequestMethod.POST)
    @ResponseBody
    public String doMeetingStatusUpdate(FrontConfVO frontConfVO, Model model){
        //차후 session 값에서 가져올 값.
        frontConfVO.setUpdate_user("123");

        // '시작'버튼 클릭으로 상태 "회의중"으로 변경, 회의중인 경우 종료로 변경
        if( !StringUtils.isBlank(frontConfVO.getMeetStatus()) ){
            if( frontConfVO.getMeetStatus().equals("1") ) {
                frontConfVO.setRecStatus("P");
                frontConfVO.setMeetStatus("2");                         //업데이트 될 상태값으로 변경. 1:예약이면 2:회의중으로, 2:회의중이면 3:종료로.
                confStatusSvc.doStartMeetingRoomStatus(frontConfVO);
                List<MinutesMicDTO> micList = null;
            }else if( frontConfVO.getMeetStatus().equals("2") ) {
                frontConfVO.setMeetStatus("3");
                confStatusSvc.doEndMeetingRoomStatus(frontConfVO);
                SttMetaDTO sttMetaOne = confStatusSvc.getSttMetaOneByMetaId(frontConfVO);

                if( !StringUtils.isBlank(sttMetaOne.getStart_time()) && !StringUtils.isBlank(sttMetaOne.getEnd_time()) ){
                    frontConfVO.setRecStartTime( sttMetaOne.getStart_time() );
                    frontConfVO.setRecEndTime( sttMetaOne.getEnd_time() );

                    confStatusSvc.doRecTimeUpdate(frontConfVO);
                }
            }
        }

        //마이크 정보 select
        List<MinutesMicDTO> micInfoList = confStatusSvc.getMicInfo(frontConfVO);

        //STT_MEAT에서 rec_start_time_sec select.
        List<String> micList = new ArrayList<String>();
        SttMetaDTO oneForRecTime = confStatusSvc.getSttMetaOne(frontConfVO);

        //UI에 넘기기 위한 값 설정
        micList.add( oneForRecTime.getRec_start_time_sec() );
        micList.add( micInfoList.get(0).getMic_ipaddr() );
        for(MinutesMicDTO one : micInfoList){
            micList.add(one.getMic_port());
        }

        Gson gson = new Gson();

        return gson.toJson(micList);
    }


    //실시간 or 녹음된 회의록 보기 선택
    @RequestMapping(value="sel_script", method={RequestMethod.GET, RequestMethod.POST})
    public String selectScript(FrontConfVO frontConfVO, Model model){
        //차후 session 값에서 가져올 값.
        frontConfVO.setSite_ser("1");

        SttMetaDTO sttMetaOne = confStatusSvc.getSttMetaOne(frontConfVO);

        model.addAttribute("frontConfVO", frontConfVO);
        model.addAttribute("metaOne", sttMetaOne);

        return "conf_status/select_script";
    }


    //실시간 회의록 보기
    @RequestMapping(value="rt_script", method=RequestMethod.POST)
    public String realtime_script(FrontConfVO frontConfVO, Model model){
        SttMetaDTO sttMeta = confStatusSvc.getSttMetaOne(frontConfVO);
        List<SttResultDTO> sttResult = confStatusSvc.getSttResultListByMetaId(frontConfVO);
        List<MinutesMicDTO> micSetInfo = confStatusSvc.getMicSetInfo(frontConfVO);

        model.addAttribute("frontConfVO", frontConfVO);
        model.addAttribute( "sttMeta", sttMeta);
        model.addAttribute("sttResult", sttResult);
        model.addAttribute("micSetInfo", micSetInfo);

        return "conf_status/realtime_script";
    }


    //실시간 회의록 편집
    @RequestMapping(value="rtEdit_script", method=RequestMethod.POST)
    public String realtimeEdit_script(FrontConfVO frontConfVO, Model model){
        SttMetaDTO sttMeta = confStatusSvc.getSttMetaOne(frontConfVO);
        List<SttResultDTO> sttResult = confStatusSvc.getSttResultListByMetaId(frontConfVO);
        List<MinutesMicDTO> micSetInfo = confStatusSvc.getMicSetInfo(frontConfVO);

        model.addAttribute("frontConfVO", frontConfVO);
        model.addAttribute( "sttMeta", sttMeta);
        model.addAttribute("sttResult", sttResult);
        model.addAttribute("micSetInfo", micSetInfo);

        return "conf_editing/realtimeEdit_script";
    }


    //녹음된 회의록 청취용 보기
    @RequestMapping(value="rec_script", method=RequestMethod.POST)
    public String recorded_script(FrontConfVO frontConfVO, Model model){
        SttMetaDTO sttMeta = confStatusSvc.getSttMetaOne(frontConfVO);
        List<SttResultDTO> sttResult = confStatusSvc.getSttResultListByMetaId(frontConfVO);
        List<MinutesMicDTO> micSetInfo = confStatusSvc.getMicSetInfo(frontConfVO);

        model.addAttribute("frontConfVO", frontConfVO);
        model.addAttribute( "sttMeta", sttMeta);
        model.addAttribute("sttResult", sttResult);
        model.addAttribute("micSetInfo", micSetInfo);

        return "conf_status/recorded_script";
    }


    //녹음된 회의록 편집용 보기
    @RequestMapping(value="recEdit_script", method=RequestMethod.POST)
    public String recordedEdit_script(FrontConfVO frontConfVO, Model model){
        SttMetaDTO sttMeta = confStatusSvc.getSttMetaOne(frontConfVO);
        List<SttResultDTO> sttResult = confStatusSvc.getSttResultListByMetaId(frontConfVO);
        List<MinutesMicDTO> micSetInfo = confStatusSvc.getMicSetInfo(frontConfVO);

        model.addAttribute("frontConfVO", frontConfVO);
        model.addAttribute( "sttMeta", sttMeta);
        model.addAttribute("sttResult", sttResult);
        model.addAttribute("micSetInfo", micSetInfo);

        return "conf_editing/recordedEdit_script";
    }


    //실시간, 녹음된 회의록 메모 저장
    @RequestMapping(value="memoSave", method=RequestMethod.POST)
    @ResponseBody
    public String doMemoSave(FrontConfVO frontConfVO, Model model){

        confStatusSvc.doMemoSave(frontConfVO);

        return "";
    }

    //녹음된 회의록 편집용 문장 편집 수정
    @RequestMapping(value="sntncSave", method=RequestMethod.POST)
    @ResponseBody
    public String doSntncSave(FrontConfVO frontConfVO, Model model){

        confStatusSvc.doSntncSave(frontConfVO);

        return frontConfVO.getSntnc_desc();
    }


    //대시보드에서 '취소'버튼 클릭
    @RequestMapping(value="meetingCancel", method=RequestMethod.POST)
    public String doMeetingCancel(FrontConfVO frontConfVO, Model model){
        //delete in STT_META table
        confStatusSvc.doMeetingCancel(frontConfVO);
        confStatusSvc.doMicHistDel(frontConfVO);

        return "redirect:/dashboard";
    }
}
