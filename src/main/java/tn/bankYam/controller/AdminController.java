package tn.bankYam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import tn.bankYam.dto.Accounty;
import tn.bankYam.dto.Product;
import tn.bankYam.service.AccountyService;

import java.util.List;

@Controller
@RequestMapping("admin")
public class AdminController {
    @Autowired
    AccountyService accountyService;

    @GetMapping("ad_update_ok")
    public String ad_update_ok(){
        List<Accounty> accountyList = accountyService.findAccounty();
        Product recentPd = accountyService.recentPd();
        System.out.println(recentPd);
        for(Accounty account: accountyList) {
            String day = account.getAc_udate().toString().substring(account.getAc_udate().toString().lastIndexOf("-") + 1);
            System.out.println(day);
        }
        return "redirect:/member/profile";
    }
}
