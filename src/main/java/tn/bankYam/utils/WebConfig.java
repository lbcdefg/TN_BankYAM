package tn.bankYam.utils;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.socket.server.standard.ServerEndpointExporter;

@Component
@Configuration
public class WebConfig implements WebMvcConfigurer {
	String urls[] = {

			"/",
			"/member/login", "/member/login_ok",
			"/cate/**", "/js/**",
			"/css/**","/img/**",
			"/member/join", "/member/join_ok", "/member/join/mailCheck", "/member/join/mailConfirm",
			"/member/findID", "/member/findID/phoneCheck", "/member/findPW", "/member/editPwd",


			"/map", "/subsidiary", "/introduce", "/products","/terms",

			"/error"};
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new LoginUserCheckInterceptor()) //LoginAdminCheckInterceptor 등록
				.order(1)
				.addPathPatterns("/**")
				.excludePathPatterns(urls);
	}
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/static/**")
				.addResourceLocations("classpath:/static/");
	}


	@Bean
	public ServerEndpointExporter serverEndpointExporter() {
		return new ServerEndpointExporter();
	}

}
