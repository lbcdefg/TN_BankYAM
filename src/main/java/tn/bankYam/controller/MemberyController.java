package tn.bankYam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import tn.bankYam.dto.Membery;
import tn.bankYam.service.MemberyService;
import tn.bankYam.utils.SHA256;
import tn.bankYam.utils.ScriptUtil;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;

@Controller
@RequestMapping("member")
public class MemberyController {

	@Autowired
	private MemberyService memberyService;

	@GetMapping("login")
	public String login(){
		return "login";
	}
	@PostMapping("login_ok")
	public String loginOk(Membery loginInfo, HttpServletResponse response, HttpSession session){
		System.out.println(loginInfo);
		Membery membery = memberyService.findByEmailS(loginInfo.getMb_email());
		try {
			if (membery == null) {
				ScriptUtil.alertAndBackPage(response, "이메일이 존재하지 않습니다.");
			} else {
				//암호화 되어있을때랑 되어있지 않을때
				if(loginInfo.getMb_pwd().equals(membery.getMb_pwd()) || (SHA256.encrypt(loginInfo.getMb_pwd())).equals(membery.getMb_pwd())){
					session.setAttribute("membery", membery);
					ScriptUtil.alertAndMovePage(response, "로그인 완료", "/");
				}else {
					ScriptUtil.alertAndBackPage(response, "비밀번호가 일치하지 않습니다.");
				}
			}
			return null;
		}catch(IOException ie){
			return "redirect:/";
		}catch(NoSuchAlgorithmException nsae){
			return "redirect:/";
		}
	}
	@GetMapping("logout_ok")
	public String logoutOk(Membery loginInfo, HttpServletResponse response, HttpSession session){
		if(session.getAttribute("membery") != null){
			session.invalidate();
		}
		return "redirect:/";
	}
	@GetMapping("join")
	public String join(){
		return "join";
	}

	@GetMapping("update")
	public String update(){
		return "member/update";
	}

	@GetMapping("profile")
	public String profile(){
		return "profile";
	}

	@GetMapping("findID")
	public String findid(){
		return "findID";
	}
}
