package tn.bankYam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import tn.bankYam.dto.Accounty;
import tn.bankYam.dto.Membery;
import tn.bankYam.dto.Transactions;
import tn.bankYam.service.AccountyService;
import tn.bankYam.service.MemberyService;
import tn.bankYam.service.TransactionService;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("account")
public class AccountyController {
    @Autowired
    private MemberyService memberyService;
    @Autowired
    AccountyService accountyService;
    @Autowired
    TransactionService transactionService;


    //거래내역 불러오기
    @GetMapping("transactionList")
    public String transactionList(Model model, HttpSession session){
        Membery membery = (Membery)session.getAttribute("membery");
        List<Transactions> trList = transactionService.selectTrListS(membery);
        model.addAttribute("trList",trList);
        return "transactionList";
    }

    //계좌이체 창
    @GetMapping("transfer")
    public String transfer(Model model, HttpSession session){
        Membery membery = (Membery)session.getAttribute("membery");
        List<Accounty> accList = accountyService.selectAccNumS(membery.getMb_seq());
        //로그인한 계정에 대한 계좌 리스트
        model.addAttribute("accList", accList);
        return "transfer";
    }

    //계좌이체 확인
    @PostMapping("transfer_chk")
    public String transferChk(){
        return "confirmation";
    }

    //계좌이체
    @PostMapping ("transfer_ok")
    public String transferOk(Model model, HttpSession session, Accounty accounty){
        Membery membery = (Membery)session.getAttribute("membery");
        accountyService.transferS(accounty);
        model.addAttribute("transfer");
        return "redirect:profile";
    }

}
