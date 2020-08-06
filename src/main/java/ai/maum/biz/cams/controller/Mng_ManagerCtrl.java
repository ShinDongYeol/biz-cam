package ai.maum.biz.cams.controller;

import ai.maum.biz.cams.dto.CommonCodeDTO;
import ai.maum.biz.cams.dto.MinutesEmployeeDTO;
import ai.maum.biz.cams.dto.MinutesSiteDTO;
import ai.maum.biz.cams.service.CommonSvc;
import ai.maum.biz.cams.service.ManagerSvc;
import ai.maum.biz.cams.utils.CommonUtils;
import ai.maum.biz.cams.vo.FrontMngVO;
import ai.maum.biz.cams.vo.PagingVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

@Controller
public class Mng_ManagerCtrl {
    @Autowired
    CommonSvc commonSvc;

    @Autowired
    ManagerSvc mngSvc;

    CommonUtils commonUtils = CommonUtils.getInstance();

    //직원 관리 리스트
    @RequestMapping(value="empList", method={RequestMethod.GET, RequestMethod.POST})
    public String getEmpList(FrontMngVO frontMngVO, Model model, HttpSession session){
        //차후 session 값에서 가져올 값.
        frontMngVO.setSite_ser("1");

        String empPartTag = this.getCommonCode("code_one", "CD003"); //부서코드 값 select
        String empPositionTag = this.getCommonCode("code_one", "CD002"); //직급코드 값 select

        //페이징을 위해서 쿼리 포함 전체 카운팅
        PagingVO pagingVO = new PagingVO();
        pagingVO.setTotalCount( mngSvc.getEmpListAllCount(frontMngVO) );                //전체 리스트 수
        pagingVO.setCurrentPage( frontMngVO.getCurrentPage() );                         //현재 페이시 세팅
        frontMngVO.setStartRow( pagingVO.getStartRow() );                               //첫 페이지 세팅
        frontMngVO.setLastRow( pagingVO.getLastRow() );                                 //마지막 페이지 세팅
        frontMngVO.setPageInitPerPage( pagingVO.getCOUNT_PER_PAGE() );


        // 사용자 리스트
        List<MinutesEmployeeDTO> userList = mngSvc.getEmpList(frontMngVO);

        model.addAttribute("frontMngVO", frontMngVO);
        model.addAttribute("empPartTag", empPartTag);
        model.addAttribute("empPositionTag", empPositionTag);
        model.addAttribute("list", userList);
        model.addAttribute("paging", pagingVO);

        return "/mng_manager/empList";
    }


    //직원 관리.직원 추가 화면
    @RequestMapping(value="empAdd", method={RequestMethod.GET, RequestMethod.POST})
    public String doEmpAdd(FrontMngVO frontMngVO, Model model, HttpSession session){
        //차후 session 값에서 가져올 값.
        frontMngVO.setSite_ser("1");

        String empPartTag = this.getCommonCode("code_one", "CD003"); //부서코드 값 select
        String empPositionTag = this.getCommonCode("code_one", "CD002"); //직급코드 값 select

//        //사이트 리스트 select
//        List<MinutesSiteDTO> siteList = commonSvc.getSiteListAll();
//
//        //select한 사이트 리스트 값 select box tag로 변환
//        String siteListTag = commonUtils.doSelectBoxTagSiteList(siteList, "");


        model.addAttribute("empPartTag", empPartTag);
        model.addAttribute("empPositionTag", empPositionTag);
//        model.addAttribute( "siteListTag", siteListTag);

        return "/mng_manager/empAdd";
    }


    //직원 관리.직원 추가 저장
    @RequestMapping(value="empAddOk", method=RequestMethod.POST)
    @ResponseBody
    public String doEmpAddSave(FrontMngVO frontMngVO, Model model, HttpSession session){
        //차후 session 값에서 가져올 값.
        frontMngVO.setCreate_user("123");

        mngSvc.doEmpAddSave(frontMngVO);

        return "";
    }


    //직원 관리.직원 수정
    @RequestMapping(value="empModify", method={RequestMethod.GET, RequestMethod.POST})
    public String doEmpModify(FrontMngVO frontMngVO, Model model, HttpSession session){
        //차후 session 값에서 가져올 값.
        frontMngVO.setSite_ser("1");

        String empPartTag = this.getCommonCode("code_one", "CD003"); //부서코드 값 select
        String empPositionTag = this.getCommonCode("code_one", "CD002"); //직급코드 값 select

//        //사이트 리스트 select
//        List<MinutesSiteDTO> siteList = commonSvc.getSiteListAll();
//
//        //select한 사이트 리스트 값 select box tag로 변환
//        String siteListTag = commonUtils.doSelectBoxTagSiteList(siteList, "");


        //수정할 1건의 직원 정보 select
        MinutesEmployeeDTO empInfo = mngSvc.getEmpInfoByEmpSer(frontMngVO);

        model.addAttribute( "frontMngVO", frontMngVO);
        model.addAttribute("empPartTag", empPartTag);
        model.addAttribute("empPositionTag", empPositionTag);
//        model.addAttribute( "siteListTag", siteListTag);
        model.addAttribute("empInfo", empInfo);

        return "/mng_manager/empModify";
    }

    //직원 관리. 직원 수정 저장
    @RequestMapping(value="empModifyOk", method=RequestMethod.POST)
    @ResponseBody
    public String doEmpModifySave(FrontMngVO frontMngVO, Model model, HttpSession session){
        //차후 session 값에서 가져올 값.
        frontMngVO.setUpdate_user("123");

        mngSvc.doEmpModifySave(frontMngVO);

        return "";
    }

    private String getCommonCode(String code_type, String code_val) {

        //COMMON_CODE 테이블에서 가져올 코드 그룹 세팅, select
        HashMap<String, String> codeMap = new HashMap<>();
        codeMap.put(code_type, code_val);

        List<CommonCodeDTO> commonCodeList = commonSvc.getCommonCodeListPart(codeMap);

        //select한 코드값 select box tag로 변환
        return commonUtils.doSelectBoxTagUserRight(commonCodeList, "");
    }
}
