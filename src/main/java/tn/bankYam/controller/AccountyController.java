package tn.bankYam.controller;

import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import tn.bankYam.dto.Accounty;
import tn.bankYam.dto.Membery;
import tn.bankYam.dto.Transactions;
import tn.bankYam.service.AccountyService;
import tn.bankYam.service.MemberyService;
import tn.bankYam.service.TransactionService;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
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

    public String transfer(Model model, HttpSession session, Accounty accounty){
        Membery membery = (Membery)session.getAttribute("membery");
        List<Accounty> accList = accountyService.selectAccNumS(membery.getMb_seq());

        for(int i = 0; i < accList.size(); i++){
            Accounty accInfo = accountyService.selectAccInfoS(accList.get(i).getAc_seq());
            accList.get(i).setAc_balance(accInfo.getAc_balance());
            accList.get(i).setAc_pwd(accInfo.getAc_pwd());
        }
        System.out.println(accList);

        //로그인한 계정에 대한 계좌 리스트
        model.addAttribute("accList", accList);
        return "transfer";
    }

    @GetMapping("checkBalance")
    @ResponseBody
    public Accounty checkBalance(HttpSession session, long ac_seq){
        Accounty accounty = accountyService.selectAccInfoS(ac_seq);
        return accounty;
    }

    //계좌이체 확인
    @PostMapping("transfer_chk")
    public String transferChk(Model model, HttpSession session){

        return "confirmation";
    }

    //계좌이체
    @PostMapping ("transfer_ok")
    public String transferOk(Model model, HttpSession session, Accounty accounty){
        Membery membery = (Membery)session.getAttribute("membery");
        accountyService.transferS(accounty);
        return "receipt";
    }

}
