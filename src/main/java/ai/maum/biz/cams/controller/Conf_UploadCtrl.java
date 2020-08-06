package ai.maum.biz.cams.controller;

import ai.maum.biz.cams.dto.MinutesMeetingRoomDTO;
import ai.maum.biz.cams.dto.MinutesSiteDTO;
import ai.maum.biz.cams.dto.SttMetaDTO;
import ai.maum.biz.cams.service.ConfStatusSvc;
import ai.maum.biz.cams.service.ConfFileUploadSvc;
import ai.maum.biz.cams.utils.CommonUtils;
import ai.maum.biz.cams.utils.ExcelView;
import ai.maum.biz.cams.vo.FrontConfVO;
import ai.maum.biz.cams.vo.FrontFileUpConfVO;
import ai.maum.biz.cams.vo.PagingVO;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class Conf_UploadCtrl {

    @Autowired
    private ConfFileUploadSvc confUploadSvc;

    @Autowired
    ConfStatusSvc confStatusSvc;

    @Autowired
    CommonUtils cUtils;

    @RequestMapping(value="fileUp")
    public String doFileUp(FrontFileUpConfVO frontFileUpConfVO, Model model){


        PagingVO pagingVO = new PagingVO();
        pagingVO.setTotalCount( confUploadSvc.getUploadCount() );
        pagingVO.setCurrentPage( frontFileUpConfVO.getCurrentPage() );
        frontFileUpConfVO.setStartRow( pagingVO.getStartRow() );
        frontFileUpConfVO.setLastRow( pagingVO.getLastRow() );
        frontFileUpConfVO.setPageInitPerPage( pagingVO.getCOUNT_PER_PAGE() );


        List<SttMetaDTO> result = confUploadSvc.getUploadList(frontFileUpConfVO);
        model.addAttribute("result", result);
        model.addAttribute("frontUploadVO", frontFileUpConfVO);
        model.addAttribute("paging", pagingVO);

        return "/conf_upload/fileUp";
    }

    @RequestMapping(value="fileUpOk", method= RequestMethod.POST)
    @ResponseBody
    public String doFileUpSave(List<MultipartFile> files,
                               String[] minutesName,
                               String[] startTime,
                               String[] minutesTopic,
                               String[] confJoinedEmpName,
                               String[] confJoinedEmpId,
                               String[] confJoinedCnt,
                               String[] minutesMeetingroom,
                               String[] minutesMachine,
                               String[] fileName){

        int siteSer = 1;
        String result = "";
        try{
            result = confUploadSvc.uploadAndConvertForMeeting(
                    files,
                    minutesName,
                    startTime,
                    minutesTopic,
                    confJoinedEmpName,
                    confJoinedEmpId,
                    confJoinedCnt,
                    fileName,
                    minutesMeetingroom,
                    minutesMachine,
                    siteSer
            );
        }catch (Exception e){
            result = "FAIL";
        }
        return result;

    }


    @RequestMapping(value="fileSetUpConf", method=RequestMethod.GET)
    public String setUpConf(FrontConfVO frontConfVO, Model model){

        frontConfVO.setSite_ser("1");

        List<MinutesSiteDTO> siteList = confStatusSvc.getSiteListAll();
        // String siteListTag = cUtils.doSelectBoxTagSiteList(siteList, frontConfVO.getSite_ser());

        //List<MinutesMeetingRoomDTO> meetingRoomList = confStatusSvc.getMeetingRoomListBySiteId(frontConfVO);

        model.addAttribute("frontConfVO", frontConfVO);
        //model.addAttribute("meetingRoomList", meetingRoomList);

        return "conf_upload/fileSetUpConf";
    }

}
