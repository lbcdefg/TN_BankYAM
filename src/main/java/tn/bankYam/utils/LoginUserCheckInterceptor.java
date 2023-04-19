package tn.bankYam.utils;

import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginUserCheckInterceptor implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String requestURI = request.getRequestURI();
		System.out.println("[interceptor] : " + requestURI);
		HttpSession session = request.getSession(false);

//		if(session == null || session.getAttribute(SessionConst.LOGIN_MEMBER) == null) {
		if(session == null || session.getAttribute("membery") == null) {
			// 로그인 되지 않음
			System.out.println("[user미인증 사용자 요청]");

			//로그인으로 redirect
			ScriptUtil.alertAndMovePage(response, "로그인이 필요한 서비스입니다.", "/member/login");
			return false;
		}
		// 로그인 되어있을 떄
		return true;

	}
}
