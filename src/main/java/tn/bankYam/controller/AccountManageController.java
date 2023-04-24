package tn.bankYam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import tn.bankYam.dto.*;
import tn.bankYam.service.AccountManageService;
import tn.bankYam.utils.SHA256;
import tn.bankYam.utils.ScriptUtil;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("accountM")
public class AccountManageController {

    @Autowired
    private AccountManageService accountManageService;

    @GetMapping("accounts")
    public String accounts(Model model, HttpServletResponse response, HttpSession session, Long ac_seq, String cat){
        //세션 불러오기
        Membery membery = (Membery)session.getAttribute("membery");
        if(membery != null) {   // 나중에 로그인 전용 페이지로 구성하면 해당 if문 없애기
            // 초기 경로로 들어올 때
            try {
                if (ac_seq == null && cat == null) {
                    List<Accounty> acList = accountManageService.selectAcList(membery); // 계좌(사용중, 휴면)
                    List<Accounty> acXList = accountManageService.selectAcXList(membery);   // 계좌(해지, 복구신청)
                    System.out.println("계좌관리 리스트(사용중,휴면)): " + acList); // 체크
                    System.out.println("계좌관리 리스트(해지)): " + acXList); // 체크

                    model.addAttribute("acList", acList);
                    model.addAttribute("acXList", acXList);
                    return "accounts";
                // 주 계좌 변경으로 들어올 때
                }else if (ac_seq != null && cat.equals("acM")) {
                    HashMap<String, Object> forAcMap = accountManageService.forMapIdId(ac_seq, membery.getMb_seq());
                    System.out.println("업데이트용 Map: " + forAcMap); // 체크

                    // 기존 주 계좌 체크
                    List<Accounty> acBeforeMain = accountManageService.checkAcBeforeMain(membery.getMb_seq());
                    System.out.println("원래 주 계좌(1개여야함): " + acBeforeMain); // 체크

                    // 주 계좌가 하나여야 하므로 체크(가입할 때 1개 가입되므로 없거나 2개 이상이면 DB에 문제가 있는 것임!!!)
                    if (acBeforeMain.size() == 1) {

                        // 새로운 주 계좌 체크: 주인 및 계좌 체크(주인의 해당 계좌인게 확실할 때 update가 되어야 함)
                        Accounty acCheck = accountManageService.checkAc(forAcMap);
                        System.out.println("설정할 주 계좌: " + acCheck); // 체크

                        if (acCheck != null) {
                            // 기존 주 계좌가 새롭게 설정할 주 계좌랑 다를 때 이루어져야 함
                            if(acBeforeMain.get(0).getAc_seq() != acCheck.getAc_seq()) {
                                accountManageService.updateAcBeforeMain(acBeforeMain.get(0));
                                accountManageService.updateAcNewMain(acCheck);

                                System.out.println("원래 주 계좌(이젠 부 계좌): " + acBeforeMain.get(0)); // 체크
                                System.out.println("새로운 주 계좌(원래 부 계좌): " + acCheck); // 체크
                                ScriptUtil.alertAndMovePage(response, "주 계좌 설정 완료", "/accountM/accounts");
                            }
                        }
                    }
                }
                ScriptUtil.alertAndBackPage(response, "이상한 경로로 오셨어요.. 절차대로 실행해 주세요!");
                return null;
            } catch(IOException ie){
                return "accounts";
            }
        }
        return "accounts";
    }

    @PostMapping("accounts_nameC")
    public String accounts_nameC(Accounty accounty, HttpServletResponse response, HttpSession session){
        //세션 불러오기
        Membery membery = (Membery)session.getAttribute("membery");

        System.out.println(accounty);   // 체크

        if(membery != null) {   // 나중에 로그인 전용 페이지로 구성하면 해당 if문 없애기
            try {
                accountManageService.updateAcName(accounty);

                ScriptUtil.alertAndMovePage(response, "계좌 별칭 설정 완료", "/accountM/accounts");
            }catch(IOException ie){
                return "accounts";
            }
        }
        return "accounts";
    }

    @PostMapping("accounts_psCheck")
    public @ResponseBody String accounts_psCheck(HttpSession session, long ac_seq, long ac_ps) throws NoSuchAlgorithmException {
        Membery membery = (Membery)session.getAttribute("membery");

        System.out.println("계좌번호: " + ac_seq);
        System.out.println("기존 계좌 비밀번호(입력값): " + ac_ps);

        if(membery != null) {   // 나중에 로그인 전용 페이지로 구성하면 해당 if문 없애기
            // 비밀번호 체크횟수 먼저 확인하기
            Accounty checkAc = accountManageService.checkPs(ac_seq);

            if(checkAc.getAc_pwd_check() == 5){
                return "0";
            }

            // 입력 비밀번호 코드화 및 체크
            String codePs = SHA256.encrypt(ac_ps+"");
            String codeVs = SHA256.encrypt(checkAc.getAc_pwd()+"");

            System.out.println("입력비밀번호 코드: " + codePs);
            System.out.println("DB비밀번호 코드: " + codeVs);

            // 비밀번호 체크
            if(codeVs.equals(codePs)){
                // 비밀번호 맞췄을 때 (비밀번호 체크횟수 초기화 -> 0)
                accountManageService.updateAcPwdCheck(ac_seq);
                return "allow";
            }else{
                // 비밀번호 틀렸을 때(비밀번호 체크횟수 증가 -> 최대5)
                accountManageService.updateAcPwdWrong(ac_seq);
                long result = 5 - (checkAc.getAc_pwd_check() + 1);
                return result+"";
            }
        }
        return "cancel";
    }

    @PostMapping("accounts_psChange")
    public String accounts_psChange(Accounty accounty, HttpServletResponse response, HttpSession session) {
        //세션 불러오기
        Membery membery = (Membery) session.getAttribute("membery");

        System.out.println(accounty);   // 체크
        if (membery != null) {   // 나중에 로그인 전용 페이지로 구성하면 해당 if문 없애기
            try {
                accountManageService.updateAcPs(accounty);

                ScriptUtil.alertAndMovePage(response, "비밀번호 재설정 완료", "/accountM/accounts");
            } catch (IOException ie) {
                return "accounts";
            }
        }
        return "accounts";
    }

    @GetMapping("newAccount")
    public String newAccount(){
        return "newAccount";
    }
}