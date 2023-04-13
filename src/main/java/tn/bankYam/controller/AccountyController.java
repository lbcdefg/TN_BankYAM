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

    //�ŷ���������Ʈ �ҷ�����
    @GetMapping("transactionList")
    public String transactionList(Model model){
//        model.addAttribute("transactionList");
        return "transactionList";
    }
    //������ü
    @GetMapping("transfer")
    public String transfer(Model model){
        return "transfer";
    }

}
