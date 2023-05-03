package tn.bankYam.controller;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
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
import tn.bankYam.dto.Product;
import tn.bankYam.service.AccountyService;
import tn.bankYam.service.MemberyService;
import tn.bankYam.service.RegisterMail;
import tn.bankYam.utils.SHA256;
import tn.bankYam.utils.ScriptUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDate;
import java.util.HashMap;
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
	public String profile(HttpSession session, Model model,String pd_type){
		Membery member = (Membery) session.getAttribute("membery");
		Long mb_seq = member.getMb_seq();
		List<Accounty> accountyList = accountyService.findAccByMemberId(mb_seq);
		List<Product> productList = accountyService.findPdByPdname();
		List<String> pdSelectList = accountyService.findPdtype();
		System.out.println("프로필에서 멤버:" + member);
		System.out.println("프로필에서 계좌:" + accountyList);
		model.addAttribute("membery", member);
		model.addAttribute("accountyList", accountyList);
		model.addAttribute("productList", productList);
		model.addAttribute("pdSelectList", pdSelectList);
		return "profile";
	}


	@GetMapping("findID")
	public String findID(){
		return "findMember";
	}
	@GetMapping("findPW")
	public String findPW(){
		return "findMember";
	}
	@GetMapping("findID/phoneCheck")
	@ResponseBody
	Membery phoneCheck(@RequestParam("phone") String phone){
		Membery membery = memberyService.findByPhone(phone);
		System.out.println(membery);
		System.out.println("입력한전화번호: " + phone + ", 회원: " + membery);
		if(membery!=null){
			return membery;
		}
		return null;
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
	Membery mailCheck(@RequestParam("email") String email){
		Membery membery = memberyService.findByEmailS(email);
		System.out.println(membery);
		System.out.println("입력한이메일: " + email + ", 회원: " + membery);
		if(membery!=null){
			return membery;
		}
		return null;
    }
  
	@GetMapping("editProfile")
	public String editProfile(HttpSession session, Model model){
		Membery member = (Membery) session.getAttribute("membery");
		model.addAttribute("membery", member);
		return "editProfile";
	}
	@GetMapping("checkPwd")
	@ResponseBody
	public boolean checkPwd(HttpSession session, @RequestParam("pwd") String pwd) throws NoSuchAlgorithmException{
		Membery member = (Membery) session.getAttribute("membery");
		String pwd2 = member.getMb_pwd();
		if(pwd2.equals(SHA256.encrypt((pwd)))){
			return true;
		}else {
		    return false;
		}
	}
  
	@PostMapping("editProfile_ok")
	public void editProfile_ok(HttpSession session, Membery editInfo,HttpServletResponse response)throws IOException,NoSuchAlgorithmException{
		Membery member = (Membery) session.getAttribute("membery");
		if(member.getMb_pwd().equals(SHA256.encrypt(editInfo.getMb_pwd())) ) {
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

	@PostMapping("join_ok")
	public String joinMember(Membery membery, HttpServletRequest request) throws NoSuchAlgorithmException {
		// view에서 받아온 값 외 신용점수 + 비밀번호 복호화해서 insert 보내기
		membery.setMb_credit(setCredit(membery.getMb_job(),membery.getMb_salary()));
		membery.setMb_pwd(SHA256.encrypt(membery.getMb_pwd()));
		memberyService.joinMembery(membery);

		// 기본계좌 생성하기, Accoounty 여기서 만들어줘서넘김
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		Accounty accounty = new Accounty();
		Membery memberyVal = memberyService.findByEmailS(membery.getMb_email());
		hashMap.put("ac_mb_seq", memberyVal.getMb_seq());
		Product product = accountyService.findPdBySeq(1);
		hashMap.put("membery", memberyVal);
		hashMap.put("ac_pd_seq", product.getPd_seq());
		hashMap.put("ac_name",product.getPd_name());
		hashMap.put("ac_pwd", SHA256.encrypt(request.getParameter("ac_pwd")));
		hashMap.put("ac_udated",request.getParameter("ac_udated"));
		hashMap.put("ac_purpose", request.getParameter("ac_purpose"));

		LocalDate now = LocalDate.now();
		int nowDD = now.getDayOfMonth();
		int udateDD = Integer.parseInt(request.getParameter("ac_udated"));
		// 희망이자지급일자(udateDD)와 현재날짜를 비교해서 1,2 중에 하나 넘겨줌
		if(udateDD< nowDD){
			hashMap.put("addMonths", 2);
		}else{
			hashMap.put("addMonths", 1);
		}
		accountyService.insertAcc(hashMap);
		return "redirect:/";
	}

	public long setCredit(String job,long sal){ //신용점수계산
		int job_score;
		long sal_score = (sal-3000)/100;

		switch(job){
			case "자영업" : job_score = -50; break;
			case "회사원" : job_score = 50; break;
			case "공무원" : job_score = 100; break;
			default: job_score = 0;
		}

		long credit = 650 + job_score + sal_score;
		if(credit > 900){
			return 900;
		}else if(credit < 650){
			return 650;
		}else{
			return credit;
		}
	}

	@PostMapping("editPwd")
	public String editPwd(HttpServletRequest request) throws NoSuchAlgorithmException{
		String mb_email = request.getParameter("mb_email");
		String mb_pwd = SHA256.encrypt(request.getParameter("mb_pwd"));
		HashMap<String, String> hashMap = new HashMap<String, String>();
		hashMap.put("mb_email", mb_email);
		hashMap.put("mb_pwd", mb_pwd);
		memberyService.editPwd(hashMap);
		return "redirect:/";
	}

	@GetMapping("withdraw")
	public String withdraw(HttpSession session){
		Membery member = (Membery) session.getAttribute("membery");
		if(session.getAttribute("membery") != null){
			session.invalidate();
		}
		memberyService.deleteMember(member.getMb_seq());
		return "redirect:/";
	}

	@GetMapping("checkAllBal")
	@ResponseBody
	public String checkAllBal(HttpSession session){
		Membery member = (Membery) session.getAttribute("membery");
		List<Accounty> list = accountyService.findAccByMemberId(member.getMb_seq());
		long balanceSum = 0;
		for(Accounty account : list){
			balanceSum += account.getAc_balance();
		}
		if(balanceSum>0){
			return "false";
		}else{
			return "true";
		}
	}
}
