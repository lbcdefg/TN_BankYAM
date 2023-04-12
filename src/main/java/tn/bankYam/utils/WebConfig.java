package tn.bankYam.utils;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Component
public class WebConfig implements WebMvcConfigurer {
	String urls[] = {

			"/",
			"/member/login", "/member/login_ok",
			"/cate/**", "/js/**",
			"/css/**","/img/**",

			"/error"};
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new LoginUserCheckInterceptor()) //LoginAdminCheckInterceptor 등록
				.order(1)
				.addPathPatterns("/**")
				.excludePathPatterns(urls);
	}
}
