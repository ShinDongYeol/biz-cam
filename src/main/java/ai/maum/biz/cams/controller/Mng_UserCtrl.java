package ai.maum.biz.cams.controller;

import ai.maum.biz.cams.dto.CommonCodeDTO;
import ai.maum.biz.cams.dto.MinutesSiteDTO;
import ai.maum.biz.cams.dto.UserDTO;
import ai.maum.biz.cams.service.CommonSvc;
import ai.maum.biz.cams.service.UserSvc;
import ai.maum.biz.cams.utils.CommonUtils;
import ai.maum.biz.cams.vo.PagingVO;
import ai.maum.biz.cams.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class Mng_UserCtrl {
    @Autowired
    CommonSvc commonSvc;

    @Autowired
    UserSvc userSvc;

    @Autowired
    BCryptPasswordEncoder bCryptPasswordEncoder;
    private CommonUtils commonUtils = CommonUtils.getInstance();

    //사용자 관리 리스트
    @RequestMapping(value="/userList", method={RequestMethod.GET, RequestMethod.POST})
    public String getUserList(Model model, UserVO userVO){
        //페이징을 위해서 쿼리 포함 전체 카운팅
        PagingVO pagingVO = new PagingVO();
        pagingVO.setTotalCount( userSvc.getUserListAllCount(userVO) );              //전체 리스트 수
        pagingVO.setCurrentPage( userVO.getCurrentPage() );                         //현재 페이시 세팅
        userVO.setStartRow( pagingVO.getStartRow() );                               //첫 페이지 세팅
        userVO.setLastRow( pagingVO.getLastRow() );                                 //마지막 페이지 세팅
        userVO.setPageInitPerPage( pagingVO.getCOUNT_PER_PAGE() );

        // 사용자 리스트
        List<UserDTO> userList = userSvc.getUserList(userVO);

        //select한 유저권한정보
        String userRightTag = commonUtils.checkUserRight(commonSvc.getUserRole(null), "");
        //사이트 리스트 select
        List<MinutesSiteDTO> siteList = commonSvc.getSiteListAll();
        //select한 사이트 리스트 값 select box tag로 변환
        String siteListTag = commonUtils.doSelectBoxTagSiteList(siteList, "");

        model.addAttribute("userRightTag", userRightTag);
        model.addAttribute( "siteListTag", siteListTag);

        model.addAttribute("userVO", userVO);
        model.addAttribute("list", userList);
        model.addAttribute("paging", pagingVO);

        return "/mng_user/userList";
    }

    //사용자 관리.사용자 추가
    @RequestMapping(value="/addUser", method={RequestMethod.GET, RequestMethod.POST})
    public String addUser(Model model, UserVO userVO){
        //COMMON_CODE 테이블에서 가져올 코드 그룹 세팅, select
        HashMap<String, String> codeMap = new HashMap<String, String>();

        //select한 유저권한정보
        String userRightTag = commonUtils.checkUserRight(commonSvc.getUserRole(null), "");
        //사이트 리스트 select
        List<MinutesSiteDTO> siteList = commonSvc.getSiteListAll();
        //select한 사이트 리스트 값 select box tag로 변환
        String siteListTag = commonUtils.doSelectBoxTagSiteList(siteList, "");

        model.addAttribute("userRightTag", userRightTag);
        model.addAttribute( "siteListTag", siteListTag);

        return "/mng_user/userAdd";
    }

    //사용자 관리.사용자 추가 저장
    @RequestMapping(value="/addUserOk", method=RequestMethod.POST)
    @ResponseBody
    public String addUserSave(Model model, UserVO userVO){
        String resultMsg = "200";

        try {
            String securedPass =  null;

            UserDTO oneUser = userSvc.checkUserByName(userVO);

            if(oneUser != null) {
                resultMsg = "400";
            }else {

                if (userVO.getAdd_password() != null && userVO.getAdd_password().length() > 0) {
                    securedPass = bCryptPasswordEncoder.encode(userVO.getAdd_password());
                    userVO.setAdd_password(securedPass);
                }

                userSvc.addUserSave(userVO);
            }
        }catch(Exception ex){
            ex.printStackTrace();
            resultMsg = "300";
            return resultMsg;
        }

        return resultMsg;
    }

    //사용자 관리. 사용자 정보 수정
    @RequestMapping(value="/modifyUser", method={RequestMethod.GET, RequestMethod.POST})
    public String modifyUser(Model model, UserVO userVO){
        UserDTO oneUser = userSvc.getUserInfoByUserSer(userVO);

        //COMMON_CODE 테이블에서 사용자 Role 테이블에서 값을 가져옴.
        String userRightTag = commonUtils.checkUserRight(commonSvc.getUserRole(null), oneUser.getUser_type());

        //사이트 리스트 select. select한 사이트 리스트 값 select box tag로 변환
        List<MinutesSiteDTO> siteList = commonSvc.getSiteListAll();
        String siteListTag = commonUtils.doSelectBoxTagSiteList(siteList, oneUser.getMinutes_site_ser());

        model.addAttribute("userInfo", oneUser);
        model.addAttribute("userVO", userVO);
        model.addAttribute("userRightTag", userRightTag);
        model.addAttribute("siteListTag", siteListTag);

        return "/mng_user/userModify";
    }

    //사용자관리. 사용자 정보 수정 저장
    @RequestMapping(value="/modifyUserOk", method={RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public ModelAndView modifyUserSave(Model model, UserVO userVO){
        ModelAndView view = new ModelAndView();
        view.setViewName("jsonView");
        int result = 0;

        try {
            String securedPass =  null;

            if(userVO.getModi_password() !=null  && userVO.getModi_password().length() > 0) {
                securedPass = bCryptPasswordEncoder.encode(userVO.getModi_password());
                userVO.setModi_password(securedPass);
            }

            result =   userSvc.modifyUserSave(userVO);

            if(result > 0 ) {
                result = 200;
            }else {
                result = 400;
            }
        }catch(Exception ex){
            ex.printStackTrace();
            result = 500;
        }

        view.addObject("resultCode",  result);

        return view;
    }

    //사용자관리. 사용자 정보 수정 저장
    @RequestMapping(value="/delUserOk", method={RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public String delUsers(Model model, @RequestParam(name="delUser") String delUser){
        String resultMsg = null;
        try {

            String[] targets = delUser.split(",");
            Map<String, Object> param = new HashMap<>();

            param.put("userList", targets);

            int result = userSvc.delUsers(param);

            if(result < 0) {
                resultMsg ="500";
            }else{
                resultMsg ="200";
            }

        }catch(Exception ex){
            ex.printStackTrace();

            return resultMsg;
        }

        return resultMsg;
    }
}
