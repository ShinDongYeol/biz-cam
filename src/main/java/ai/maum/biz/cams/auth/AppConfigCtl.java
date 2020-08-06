package ai.maum.biz.cams.auth;


import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.util.unit.DataSize;
import org.springframework.util.unit.DataUnit;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import javax.servlet.Filter;
import javax.servlet.MultipartConfigElement;

@Configuration
public class AppConfigCtl implements WebMvcConfigurer {

	// 인코딩
    @Bean
	public Filter characterEncodingFilter() {
		CharacterEncodingFilter encodingFilter = new CharacterEncodingFilter();
		encodingFilter.setEncoding("UTF-8");
		encodingFilter.setForceEncoding(true);
		return encodingFilter;

	}

	// 파일업로드 용량 제한.
	@Bean
    public MultipartConfigElement multipartConfigElement() {
		MultipartConfigFactory factory = new MultipartConfigFactory();
		factory.setMaxFileSize(DataSize.of(100, DataUnit.MEGABYTES));
		factory.setMaxRequestSize(DataSize.of(100, DataUnit.MEGABYTES));
		return factory.createMultipartConfig();
	}

	//멀티파트 리졸버추가..
	@Bean
	public MultipartResolver multipartResolver(){
    	return new StandardServletMultipartResolver();
	}

	//jsonView 추가
	@Bean
	public MappingJackson2JsonView jsonView(){
    	return new MappingJackson2JsonView();
	}



}
