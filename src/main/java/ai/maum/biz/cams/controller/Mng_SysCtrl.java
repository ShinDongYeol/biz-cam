package ai.maum.biz.cams.controller;

import ai.maum.biz.cams.dto.SttServerStatus;
import ai.maum.biz.cams.service.CommonSvc;
import ai.maum.biz.cams.service.ManagerSvc;
import ai.maum.biz.cams.utils.CommonUtils;
import ai.maum.biz.cams.vo.FrontMngVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class Mng_SysCtrl {
    @Autowired
    CommonSvc commonSvc;

    @Autowired
    ManagerSvc mngSvc;

    CommonUtils commonUtils = CommonUtils.getInstance();

    @RequestMapping(value="svrMnt", method={RequestMethod.GET, RequestMethod.POST})
    public String getSvrMntList(FrontMngVO frontMngVO, Model model, HttpSession session){
        //차후 session 값에서 가져올 값.
        frontMngVO.setSite_ser("1");


        //서버 모니터링 리스트 select. 검색조건 X, paging X.
        List<SttServerStatus> svrList = mngSvc.getSvrList(frontMngVO);

        model.addAttribute("svrList", svrList);

        return "/mng_sys/svrMonitoring";
    }
}
