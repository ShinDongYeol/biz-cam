package ai.maum.biz.cams.controller;

import ai.maum.biz.cams.dto.UserDTO;
import ai.maum.biz.cams.security.ZRsaSecurity;
import ai.maum.biz.cams.service.CommonSvc;
import ai.maum.biz.cams.service.UserSvc;
import ai.maum.biz.cams.vo.UserVO;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.server.Session;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.security.PrivateKey;

@Controller
public class CommonCtrl {
    @Autowired
    CommonSvc commonSvc;

    @Autowired
    UserSvc userSvc;

    private Logger logger = LoggerFactory.getLogger(CommonCtrl.class);


    @Autowired
    AuthenticationManager authenticationManager;

    @RequestMapping(value="/")
    public String home(Session session){
        return "home";
    }

    @RequestMapping(value="/login", method={RequestMethod.GET, RequestMethod.POST})
    public String doLogin(Session session, Model model){
        return "login/login";
    }


    @RequestMapping("getRSAKeyValue")
    public ModelAndView getRSAKeyValue(HttpServletRequest req, HttpServletResponse res) throws Exception {
        ModelAndView view = new ModelAndView();
        view.setViewName("jsonView");

        try {

            ZRsaSecurity zSecurity = new ZRsaSecurity();
            PrivateKey privateKey = zSecurity.getPrivateKey();

            HttpSession session = req.getSession();

            if(session.getAttribute("_rsaPrivateKey_") !=null) {
                session.removeAttribute("_rsaPrivateKey_");
            }

            session.setAttribute("_rsaPrivateKey_", privateKey);

            String publicKeyModulus = zSecurity.getRsaPublicKeyModulus();
            String publicKeyExponent = zSecurity.getRsaPublicKeyExponent();

            view.addObject("publicKeyModulus", publicKeyModulus);
            view.addObject("publicKeyExponent", publicKeyExponent);

        }catch (Exception e){
            logger.error("error", e.getMessage());
        }

        return view;
    }

    @RequestMapping(value = "/loginajax", method = RequestMethod.POST)
    @ResponseBody
    public ModelMap login(HttpServletRequest request, HttpServletResponse response,
                          @RequestParam(value = "userId") String username,
                          @RequestParam(value = "userKey") String password) {

        ModelMap map = new ModelMap();

        try {

            ZRsaSecurity rsa = new ZRsaSecurity();

            HttpSession session = request.getSession();
            PrivateKey privateKey = (PrivateKey) session.getAttribute("_rsaPrivateKey_");

            String userId = rsa.decryptRSA(privateKey, username);
            String userKey = rsa.decryptRSA(privateKey, password);
            UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(userId, userKey);

            // 로그인
            Authentication auth = authenticationManager.authenticate(token);
            SecurityContext securityContext = SecurityContextHolder.getContext();
            securityContext.setAuthentication(auth);

            UserVO  vo = new UserVO();

            vo.setSch_userId(userId);

            UserDTO dto = userSvc.getUserByName(vo);

            session.removeAttribute("_rsaPrivateKey_"); // 키의 재사용을 막는다. 다만 로그인되기전까지만 유지...
            session.setAttribute("SPRING_SECURITY_CONTEXT", securityContext);
            session.setAttribute("userInfo", dto);

            ObjectMapper mapper = new ObjectMapper();
            String jsonString = mapper.writeValueAsString(dto);
            Cookie userCookie = new Cookie("userInfo", URLEncoder.encode(jsonString, "utf-8"));
            response.addCookie(userCookie);

            map.put("resultCode", 200);
            map.put("resultMsg", "OK");
            map.put("returnUrl", getReturnUrl(request, response));
        } catch (Exception e) {
            map.put("resultCode", 500);
            map.put("resultMsg", e.getMessage());
        }

        return map;
    }


    /**
     * 로그인 하기 전의 요청했던 URL을 알아낸다.
     *
     * @param request
     * @param response
     * @return
     */
    private String getReturnUrl(HttpServletRequest request, HttpServletResponse response) {
        RequestCache requestCache = new HttpSessionRequestCache();
        SavedRequest savedRequest = requestCache.getRequest(request, response);
        if (savedRequest == null) {
            return request.getSession().getServletContext().getContextPath();
        }
        return savedRequest.getRedirectUrl();
    }
}
