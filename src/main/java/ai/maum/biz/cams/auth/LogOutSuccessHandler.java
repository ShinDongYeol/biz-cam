package ai.maum.biz.cams.auth;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 로그아웃 성공 시
 * 핸들러 들어옴.
 * custom 으로 session 에 저장한것들은
 * 여기서 정리하고 logout 처리
 */
@Component("logOutSuccessHandler")
public class LogOutSuccessHandler implements LogoutSuccessHandler {

    Logger logger = LoggerFactory.getLogger(LogOutSuccessHandler.class);


    @Override
    public void onLogoutSuccess(HttpServletRequest request,
                                HttpServletResponse response,
                                Authentication authentication) throws IOException, ServletException {


        HttpSession session = request.getSession();

        logger.info("user logOut");

        if(session.getAttribute("userInfo") != null){
            session.removeAttribute("userInfo");
        }

        Cookie[] cookies = request.getCookies();
        if(cookies != null){
            for (Cookie cookie : cookies) {
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }
        }

        response.setStatus(HttpServletResponse.SC_OK);
        response.sendRedirect("/login");

    }
}

