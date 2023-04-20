package tn.bankYam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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


    @GetMapping("transactionList")
    public String transactionList(Model model, Long tr_ac_seq, HttpServletResponse response, HttpSession session){
        Membery membery = (Membery)session.getAttribute("membery");
        if(membery !=null){
            try{
                if(tr_ac_seq==null){
                    List<Transactions> trList = transactionService.selectTrListS(membery);
                    System.out.println(trList);
                    model.addAttribute("trList",trList);
                }
            }catch (Exception e){
                return "profile";
            }
        }
        return "transactionList";
    }

    @GetMapping("transfer")
    public String transfer(Model model){
        return "transfer";
    }

}
