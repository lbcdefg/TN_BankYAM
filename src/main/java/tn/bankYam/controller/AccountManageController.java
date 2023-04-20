package tn.bankYam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import tn.bankYam.dto.*;
import tn.bankYam.service.AccountManageService;
import tn.bankYam.utils.ScriptUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
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
                    List<Accounty> acList = accountManageService.selectAcList(membery);
                    System.out.println(acList); // 체크

                    model.addAttribute("acList", acList);

                // 주 계좌 변경으로 들어올 때
                }else if (ac_seq != null && cat.equals("acM")) {
                    // 기존 주 계좌 체크
                    List<Accounty> acBeforeMain = accountManageService.checkAcBeforeMain(membery.getMb_seq());
                    System.out.println(acBeforeMain); // 체크

                    // 주 계좌가 하나여야 하므로 체크(가입할 때 1개 가입되므로 없거나 2개 이상이면 DB에 문제가 있는 것임!!!)
                    if (acBeforeMain.size() == 1) {

                        // 주인 및 계좌 체크
                        HashMap<String, Object> forAcMap = accountManageService.forMapIdId(ac_seq, membery.getMb_seq());
                        Accounty acCheck = accountManageService.checkAc(forAcMap);
                        System.out.println(acCheck); // 체크

                        if (acCheck != null) {

                        }
                    }
                }
                ScriptUtil.alertAndBackPage(response, "이상한 경로로 오셨어요.. 절차대로 실행해 주세요!");
                return null;
            } catch(IOException ie){
                return "redirect:accounts";
            }
        }
        return "redirect:accounts";
    }
}
