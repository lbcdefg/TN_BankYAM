package tn.bankYam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import tn.bankYam.service.AccountyService;
import tn.bankYam.service.MemberyService;
import tn.bankYam.service.TransactionService;

@Controller
@RequestMapping("account")
public class AccountyController {
    @Autowired
    private MemberyService memberyService;
    @Autowired
    AccountyService accountyService;
    @Autowired
    TransactionService transactionService;

    //거래내역리스트 불러오기
    @GetMapping("transactionList")
    public String transactionList(Model model){
//        model.addAttribute("transactionList");
        return "transactionList";
    }
    //계좌이체
    @GetMapping("transfer")
    public String transfer(Model model){
        return "transfer";
    }

}
