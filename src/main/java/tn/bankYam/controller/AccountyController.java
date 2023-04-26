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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
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
    public String transfer(Model model, HttpSession session, Accounty accounty, Transactions transactions){
        Membery membery = (Membery)session.getAttribute("membery");
        List<Accounty> accList = accountyService.selectAccNumS(membery.getMb_seq());
        for(int i = 0; i < accList.size(); i++){
            Accounty accInfo = accountyService.selectAccInfoS(accList.get(i).getAc_seq());
            accList.get(i).setAc_balance(accInfo.getAc_balance());
            accList.get(i).setAc_pwd(accInfo.getAc_pwd());
        }

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
    public String transferChk(Model model, HttpSession session, HttpServletRequest request, Transactions transactions, String ac_pwd){
        Membery membery = (Membery)session.getAttribute("membery");
        HashMap<String, Object> hashMap = new HashMap<String, Object>();
        hashMap.put("tr_ac_seq", transactions.getTr_ac_seq());
        hashMap.put("ac_pwd", ac_pwd);
        hashMap.put("tr_other_bank", transactions.getTr_other_bank());
        hashMap.put("tr_amount", transactions.getTr_amount());
        hashMap.put("tr_other_accnum", transactions.getTr_other_accnum());
        hashMap.put("tr_msg", transactions.getTr_msg());
        model.addAttribute("tr_ac_seq", hashMap.put("tr_ac_seq", transactions.getTr_ac_seq()));
        model.addAttribute("tr_other_bank", hashMap.put("tr_other_bank", transactions.getTr_other_bank()));
        model.addAttribute("tr_amount", hashMap.put("tr_amount", transactions.getTr_amount()));
        model.addAttribute("tr_other_accnum", hashMap.put("tr_other_accnum", transactions.getTr_other_accnum()));
        model.addAttribute("tr_msg", hashMap.put("tr_msg", transactions.getTr_msg()));
        model.addAttribute("transactions",transactions);
        return "confirmation";
    }

    //계좌이체
    @PostMapping ("transfer_ok")
    public String transferOk(Model model, HttpSession session, Accounty accounty, String ac_pwd,Transactions transactions){
        Membery membery = (Membery)session.getAttribute("membery");
        HashMap<String, Object> hashMap = new HashMap<String, Object>();
        hashMap.put("tr_seq", transactions.getTr_seq());
        hashMap.put("tr_ac_seq", transactions.getTr_ac_seq());
        hashMap.put("ac_pwd", ac_pwd);
        hashMap.put("tr_other_bank", transactions.getTr_other_bank());
        hashMap.put("tr_amount", transactions.getTr_amount());
        hashMap.put("tr_other_accnum", transactions.getTr_other_accnum());
        hashMap.put("tr_after_balance", transactions.getTr_after_balance());
        hashMap.put("tr_date", transactions.getTr_date());
        hashMap.put("tr_msg", transactions.getTr_msg());
        System.out.println("       tr_seq      "+hashMap.put("tr_seq", transactions.getTr_seq()));
        System.out.println("       tr_after_balance        "+hashMap.put("tr_after_balance", transactions.getTr_after_balance()));


        model.addAttribute("tr_ac_seq", hashMap.put("tr_ac_seq", transactions.getTr_ac_seq()));
        model.addAttribute("tr_other_bank", hashMap.put("tr_other_bank", transactions.getTr_other_bank()));
        model.addAttribute("tr_amount", hashMap.put("tr_amount", transactions.getTr_amount()));
        model.addAttribute("tr_other_accnum", hashMap.put("tr_other_accnum", transactions.getTr_other_accnum()));
        model.addAttribute("tr_msg", hashMap.put("tr_msg", transactions.getTr_msg()));
        model.addAttribute("tr_after_balance",hashMap.put("tr_after_balance", transactions.getTr_after_balance()));
        model.addAttribute("tr_date", hashMap.put("tr_date", transactions.getTr_date()));
        model.addAttribute("transactions",transactions);
        accountyService.transferS(accounty);
        return "receipt";
    }

}
