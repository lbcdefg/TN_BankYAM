package tn.bankYam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import tn.bankYam.dto.Accounty;
import org.springframework.web.bind.annotation.*;
import tn.bankYam.dto.Membery;
import tn.bankYam.service.AccountyService;
import tn.bankYam.service.MemberyService;
import tn.bankYam.service.RegisterMail;
import tn.bankYam.utils.SHA256;
import tn.bankYam.utils.ScriptUtil;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

@Controller
@RequestMapping("member")
public class MemberyController {

	@Autowired
	private MemberyService memberyService;
	@Autowired
	private AccountyService accountyService;
	@Autowired
	private RegisterMail registerMail;


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
	public String profile(HttpSession session, Model model){
		Membery member = (Membery) session.getAttribute("membery");
		Long mb_seq = member.getMb_seq();
		List<Accounty> accountyList = accountyService.findAccByMemberId(mb_seq);
		System.out.println(member);
		model.addAttribute("membery", member);
		model.addAttribute("accountyList", accountyList);

		return "profile";

	}

	@GetMapping("findID")
	public String findid(){
		return "findID";
	}

	@PostMapping("/join/mailConfirm")
	@ResponseBody
	String mailConfirm(@RequestParam("email") String email) throws Exception{
		String code = registerMail.sendSimpleMessage(email);
		System.out.println("인증코드: " + code);
		return code;
	}

	@GetMapping("/join/mailCheck")
	@ResponseBody
	String mailCheck(@RequestParam("email") String email){
		Membery membery = memberyService.findByEmailS(email);
		System.out.println("입력한이메일: " + email + ", 회원: " + membery);
		if(membery!=null){
			return "true";
		}
		return "false";
  }
  
	@GetMapping("editProfile")
	public String editProfile(HttpSession session, Model model){
		Membery member = (Membery) session.getAttribute("membery");
		model.addAttribute("membery", member);
		return "editProfile";
	}
  
	@PostMapping("editProfile_ok")
	public void editProfile_ok(HttpSession session, Membery editInfo,HttpServletResponse response)throws IOException{
		Membery member = (Membery) session.getAttribute("membery");
		if(member.getMb_pwd().equals(editInfo.getMb_pwd()) ) {
			editInfo.setMb_seq(member.getMb_seq());
			memberyService.editProfile(editInfo);
			editInfo = memberyService.findByEmailS(editInfo.getMb_email());
			session.setAttribute("membery", editInfo);
			ScriptUtil.alertAndMovePage(response, "프로필변경 완료", "profile");
		}else {
			ScriptUtil.alertAndBackPage(response,"비밀번호가 일치하지 않아요");
		}
	}
	@PostMapping("edit_photo_ok")
	public void edit_photo_ok(HttpSession session, Membery editPhoto, HttpServletResponse response, MultipartFile file) throws IOException{
		Membery member = (Membery) session.getAttribute("membery");
		editPhoto.setMb_seq(member.getMb_seq());
		System.out.println(file.getOriginalFilename());
		memberyService.updateImagepath(file,editPhoto);
		editPhoto = memberyService.findBySeq(editPhoto.getMb_seq());
		session.setAttribute("membery", editPhoto);
		ScriptUtil.alertAndMovePage(response, "프로필사진 변경 완료", "profile");

	}
}
