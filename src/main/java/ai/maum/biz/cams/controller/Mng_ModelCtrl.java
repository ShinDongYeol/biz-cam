package ai.maum.biz.cams.controller;

import ai.maum.biz.cams.dto.ModelDTO;
import ai.maum.biz.cams.dto.UserDTO;
import ai.maum.biz.cams.service.ModelSvc;
import ai.maum.biz.cams.utils.CommonUtils;
import ai.maum.biz.cams.vo.ModelVO;
import ai.maum.biz.cams.vo.PagingVO;
import ai.maum.biz.cams.vo.SecureUser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class Mng_ModelCtrl {

    @Autowired
    ModelSvc modelSvc;

    Logger logger = LoggerFactory.getLogger(Mng_ModelCtrl.class);

    @RequestMapping(value = "/modelList")
    public ModelAndView modelList(ModelVO modelVO,
                                  HttpServletRequest req,
                                  HttpServletResponse resp) {
        ModelAndView view = new ModelAndView();
        view.setViewName("/mng_model/modelList");
        PagingVO pagingVO = new PagingVO();

        pagingVO.setTotalCount( modelSvc.modelListCount(modelVO) );              //전체 리스트 수
        pagingVO.setCurrentPage( modelVO.getCurrentPage() );                         //현재 페이시 세팅
        modelVO.setStartRow( pagingVO.getStartRow() );                               //첫 페이지 세팅
        modelVO.setLastRow( pagingVO.getLastRow() );                                 //마지막 페이지 세팅
        modelVO.setPageInitPerPage( pagingVO.getCOUNT_PER_PAGE() );

        List<ModelDTO> modelList = modelSvc.modelList(modelVO);

        view.addObject("modelVO", modelVO);
        view.addObject("list", modelList);
        view.addObject("paging", pagingVO);

        return view;
    }


    @RequestMapping(value = "addModel")
    public ModelAndView addModel( HttpServletRequest req,
                                  HttpServletResponse resp) {

        ModelAndView view = new ModelAndView();
        view.setViewName("/mng_model/modelAdd");

        return view;
    }


    @RequestMapping(value = "createModel")
    public ModelAndView createModel(ModelDTO dto,
                                      HttpServletRequest req,
                                      HttpServletResponse resp) {

        ModelAndView view = new ModelAndView();
        view.setViewName("jsonView");

        int result = 0;
        int resultCode = 0;

        try {
            String userId = CommonUtils.getSignedUserName();
            dto.setCreate_user(userId);

            result = modelSvc.createModel(dto);

            if (result > 0) {
                resultCode = 200;
            } else {
                resultCode = 400;
            }
        }catch (Exception e) {
            logger.error("error", e.getMessage());
        }

        view.addObject("resultCode", resultCode);

        return view;
    }

    @RequestMapping(value="/modifyModel")
    public ModelAndView modifyModel(@RequestParam(name = "modelNum") Integer modelNum,
                                    HttpServletRequest req,
                                    HttpServletResponse resp) {

        ModelAndView view = new ModelAndView();
        view.setViewName("/mng_model/modelModify");

        ModelVO modelVO = new ModelVO();
        modelVO.setModel_ser(modelNum);

        ModelDTO dto = modelSvc.getModel(modelVO);

        view.addObject("model", dto);
        view.addObject("modelVO", modelVO);

        return view;
    }


    @RequestMapping(value = "modifyModelOk")
    public ModelAndView modifyModelOk(ModelDTO dto,
                                      HttpServletRequest req,
                                      HttpServletResponse resp) {

        ModelAndView view = new ModelAndView();
        view.setViewName("jsonView");

        int result = 0;
        int resultCode = 0;

        try {
            String userId = CommonUtils.getSignedUserName();
            dto.setUpdate_user(userId);
            result = modelSvc.updateModel(dto);

            if (result > 0) {
                resultCode = 200;
            } else {
                resultCode = 400;
            }
        }catch (Exception e) {
            logger.error("error", e.getMessage());
        }

        view.addObject("resultCode", resultCode);

        return view;
    }

    @RequestMapping(value = "delModels")
    ModelAndView delModels(@RequestParam(name="delModel") String delModel){
        ModelAndView view = new ModelAndView();
        view.setViewName("jsonView");

        String[] targets = delModel.split(",");
        Map<String, Object> param = new HashMap<>();

        param.put("modelList", targets);
        int result = 0;
        int resultCode = 0;

        try {

            int checkSite = modelSvc.checkUsedSite(param);

            if(checkSite > 0) {
                resultCode = 300;
            }else {

                result = modelSvc.delModels(param);

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
