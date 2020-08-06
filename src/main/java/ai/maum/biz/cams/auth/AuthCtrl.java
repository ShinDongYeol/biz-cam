package ai.maum.biz.cams.auth;

import ai.maum.biz.cams.service.SecureUserSVC;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.boot.autoconfigure.security.SecurityProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.security.web.context.SecurityContextRepository;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configurable
@EnableWebSecurity
@Order(SecurityProperties.DEFAULT_FILTER_ORDER)
public class AuthCtrl extends WebSecurityConfigurerAdapter {

    @Autowired
    LogOutSuccessHandler logOutSuccessHandler;

    @Autowired
    SecureUserSVC service;


    @Override
    public void configure(WebSecurity web) throws Exception
    {
        web.ignoring().antMatchers(
                "/favicon.ico",
                "/error/**",
                "/webjars/**",
                "/login/**",
                "/loginajax/**",
                "/resources/**",
                "/getRSAKeyValue/**");
//       web.ignoring().antMatchers("/**");
    }

    /*@Override
    protected void configure(HttpSecurity http) throws Exception{
        http.csrf().disable();
        http.headers().frameOptions().disable();
        http.httpBasic();
        http.authorizeRequests()
            .antMatchers("**")
            .permitAll();
    }*/



    @Override
    protected void configure(HttpSecurity http) throws Exception
    {
        http.headers().frameOptions().disable();
        http.csrf().disable()
                .authorizeRequests()
                .antMatchers(
                        "/webjars/**",
                        "/login/**").permitAll()
                .antMatchers(HttpMethod.OPTIONS, "/**").permitAll()
             /*   .antMatchers("/dashmain").hasAnyRole("ADMIN", "CS_AGENT", "OPERATOR", "SERVICE_ADMIN")*/
                .anyRequest().authenticated()
                .and()
                .formLogin()
                .loginProcessingUrl("/loginajax").permitAll()
                .loginPage("/login").permitAll()
                .and()
                .logout().invalidateHttpSession(true)
                .clearAuthentication(true)
                .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
                .logoutSuccessHandler(logOutSuccessHandler).permitAll();


    }

    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception{

    }

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }


    @Bean
    public AuthenticationProvider authProvider()
    {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setUserDetailsService(service);
        provider.setPasswordEncoder(passwordEncoder());
        return provider;
    }

    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

    @Bean
    SecurityContextRepository securityContextRepository(){
        return new HttpSessionSecurityContextRepository();
    }
}

