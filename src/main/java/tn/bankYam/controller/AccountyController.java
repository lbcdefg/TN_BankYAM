package tn.bankYam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("account")
public class AccountyController {
    @GetMapping("transactionList")
    public String transactionList(){
        return "transactionList";
    }

    @GetMapping("transfer")
    public String transfer(){
        return "transfer";
    }

}
