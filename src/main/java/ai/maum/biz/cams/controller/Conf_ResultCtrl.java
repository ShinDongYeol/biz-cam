package ai.maum.biz.cams.controller;

import ai.maum.biz.cams.dto.MinutesReplaceWordDTO;
import ai.maum.biz.cams.dto.SttMetaDTO;
import ai.maum.biz.cams.service.ConfResultSvc;
import ai.maum.biz.cams.vo.FrontConfVO;
import ai.maum.biz.cams.vo.FrontDicVO;
import ai.maum.biz.cams.vo.PagingVO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@Controller
public class Conf_ResultCtrl {
    @Autowired
    ConfResultSvc confResultSvc;

    //회의 결과 리스트 페이지
    @RequestMapping(value="/confResult", method={RequestMethod.GET, RequestMethod.POST})
    public String confResult(FrontConfVO frontConfVO, Model model){
        //차후 session 값에서 가져올 값.
        frontConfVO.setSite_ser("1");


        //회의 결과 리스트 페이징을 위해서 쿼리 포함 전체 카운팅
        PagingVO pagingVO = new PagingVO();
        pagingVO.setTotalCount( confResultSvc.getConfResultListTotalCount(frontConfVO) );  //전체 리스트 수
        pagingVO.setCurrentPage( frontConfVO.getCurrentPage() );                           //현재 페이시 세팅
        frontConfVO.setStartRow( pagingVO.getStartRow() );                                 //첫 페이지 세팅
        frontConfVO.setLastRow( pagingVO.getLastRow() );                                   //마지막 페이지 세팅
        frontConfVO.setPageInitPerPage( pagingVO.getCOUNT_PER_PAGE() );                    //페이지 당 로우수 세팅

        //회의결과 페이지 전체 리스트 select. 검색 적용.
        List<SttMetaDTO> ResultList = confResultSvc.getConfResultListAll(frontConfVO);

        model.addAttribute("frontConfVO", frontConfVO);
        model.addAttribute("resultList", ResultList);
        model.addAttribute("paging", pagingVO);

        return "/conf_result/confResult";
    }


    //치환 사전 리스트 페이지
    @RequestMapping(value="dicReplace", method={RequestMethod.GET, RequestMethod.POST})
    public String dicReplace(FrontDicVO frontDicVO, Model model){
        //차후 session 값에서 가져올 값.
        frontDicVO.setSite_ser("1");

        //치환사전 리스트 페이징을 위해서 쿼리 포함 전체 카운팅
        PagingVO pagingVO = new PagingVO();
        pagingVO.setTotalCount( confResultSvc.getDicReplaceTotalCount(frontDicVO) );        //전체 리스트 수
        pagingVO.setCurrentPage( frontDicVO.getCurrentPage() );                             //현재 페이시 세팅
        frontDicVO.setStartRow( pagingVO.getStartRow() );                                   //첫 페이지 세팅
        frontDicVO.setLastRow( pagingVO.getLastRow() );                                     //마지막 페이지 세팅
        frontDicVO.setPageInitPerPage( pagingVO.getCOUNT_PER_PAGE() );                      //페이지 당 로우수 세팅

        //치환사전 페이지 전체 리스트 select. 검색 적용.
        List<MinutesReplaceWordDTO> dicList = confResultSvc.getDicReplaceAllList(frontDicVO);

        model.addAttribute("frontDicVO", frontDicVO);
        model.addAttribute("dicList", dicList);
        model.addAttribute("paging", pagingVO);

        return "/conf_result/dicReplace";
    }
}
