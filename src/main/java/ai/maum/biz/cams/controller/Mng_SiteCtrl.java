package ai.maum.biz.cams.controller;

import ai.maum.biz.cams.dto.MngSiteDTO;
import ai.maum.biz.cams.dto.ModelDTO;
import ai.maum.biz.cams.service.SiteSvc;
import ai.maum.biz.cams.utils.CommonUtils;
import ai.maum.biz.cams.vo.MngSiteVO;
import ai.maum.biz.cams.vo.PagingVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class Mng_SiteCtrl {

    Logger logger = LoggerFactory.getLogger(Mng_SiteCtrl.class);

    @Autowired
    private SiteSvc siteSvc;

    private CommonUtils commonUtils = CommonUtils.getInstance();

    @RequestMapping(value = "siteList")
    public ModelAndView siteList(MngSiteVO mngSiteVO,
                                 HttpServletRequest req,
                                 HttpServletResponse resp) {

        ModelAndView view = new ModelAndView();

        view.setViewName("/mng_site/siteList");
        PagingVO pagingVO = new PagingVO();

        pagingVO.setTotalCount( siteSvc.getSiteListCnt(mngSiteVO) );              //전체 리스트 수
        pagingVO.setCurrentPage( mngSiteVO.getCurrentPage() );                         //현재 페이시 세팅
        mngSiteVO.setStartRow( pagingVO.getStartRow() );                               //첫 페이지 세팅
        mngSiteVO.setLastRow( pagingVO.getLastRow() );                                 //마지막 페이지 세팅
        mngSiteVO.setPageInitPerPage( pagingVO.getCOUNT_PER_PAGE() );

        List<MngSiteDTO> siteList = siteSvc.getSiteList(mngSiteVO);

        view.addObject("siteVO", mngSiteVO);
        view.addObject("list", siteList);
        view.addObject("paging", pagingVO);

        return view;
    }

    @RequestMapping(value = "siteAddView")
    public ModelAndView siteAdd(HttpServletRequest req,
                                HttpServletResponse resp) {

        ModelAndView view = new ModelAndView();
        view.setViewName("/mng_site/siteAdd");

        List<ModelDTO> modelList = siteSvc.getModelbox();
        String modelListTag = commonUtils.doSelectBoxTaModelList(modelList, 0);

        view.addObject("modelListTag", modelListTag);

        return view;
    }

    @RequestMapping(value = "createSite")
    public ModelAndView siteAdd(MngSiteDTO dto,
                                HttpServletRequest req,
                                HttpServletResponse resp) {

        ModelAndView view = new ModelAndView();
        view.setViewName("jsonView");

        String userId = CommonUtils.getSignedUserName();
        dto.setCreate_user(userId);

        int result = 0;
        int resultCode = 0;
        try {
            result = siteSvc.createSite(dto);

            if(result > 0 ) {
                resultCode = 200;
            }else{
                resultCode = 400;
            }

        }catch (Exception e ) {
            logger.error("error ", e.getMessage());
            resultCode = 400;
        }

        view.addObject("resultCode", resultCode);

        return view;
    }

    @RequestMapping(value = "siteModifyView")
    public ModelAndView siteModifyView(@RequestParam int siteNum,
                                HttpServletRequest req,
                                HttpServletResponse resp) {

        ModelAndView view = new ModelAndView();
        view.setViewName("/mng_site/siteModify");
        List<ModelDTO> modelList = siteSvc.getModelbox();
        String modelListTag = commonUtils.doSelectBoxTaModelList(modelList, 0);

        MngSiteVO vo = new MngSiteVO();

        vo.setMinutes_site_ser(siteNum);
        MngSiteDTO dto = siteSvc.getSiteDetail(vo);

        view.addObject("siteVO", dto);
        view.addObject("modelListTag", modelListTag);

        return view;
    }

    @RequestMapping(value = "updateSite")
    public ModelAndView updateSite(MngSiteDTO dto,
                                   HttpServletRequest req,
                                   HttpServletResponse resp) {

        ModelAndView view = new ModelAndView();
        view.setViewName("jsonView");

        String userId = CommonUtils.getSignedUserName();
        dto.setUpdate_user(userId);

        int result =  0;
        int resultCode = 0;

        try{

            result = siteSvc.updateSiteInfo(dto);

            if(result > 0) {
                resultCode = 200;
            }else{
                resultCode = 400;
            }

        }catch (Exception e) {
            logger.error("error ", e.getMessage());
            resultCode = 400;
        }
        view.addObject("resultCode", resultCode);
        return view;
    }

    @RequestMapping(value = "delSites")
    ModelAndView delSites(@RequestParam(name="delSiteSer") String delSiteSer){
        ModelAndView view = new ModelAndView();
        view.setViewName("jsonView");

        String[] targets = delSiteSer.split(",");
        Map<String, Object> param = new HashMap<>();

        param.put("siteList", targets);
        int result = 0;
        int resultCode = 0;

        try {

            int checkUser = siteSvc.checkIncludeUser(param);

            if(checkUser > 0) {
                resultCode = 300;
            }else {

                result = siteSvc.delSites(param);

                if (result > 0) {
                    resultCode = 200;
                } else {
                    resultCode = 400;
                }
            }

        }catch (Exception e) {
            logger.error("error", e.getMessage());
        }

        view.addObject("resultCode", resultCode);

        return view;
    }
}
