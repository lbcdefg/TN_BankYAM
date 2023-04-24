package tn.bankYam.controller;


import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import tn.bankYam.service.AccountyService;
import java.io.IOException;
import tn.bankYam.dto.Accounty;
import tn.bankYam.dto.Product;
import tn.bankYam.service.AccountyService;


import java.util.List;

@Controller
@RequestMapping("admin")
public class AdminController {
    @Autowired
    private AccountyService accountyService;

    @GetMapping("test")
    public String crawling(){
        String URL = "http://www.bok.or.kr/portal/main/main.do";
        Document doc;
        try{
            doc = Jsoup.connect(URL).get();
            Elements elem = doc.select(".ctype1");
            String[] str = elem.text().split(" ");
            String rate = str[0].substring(0,4);
            System.out.println("최종금리: " + rate);
            List<String> list = accountyService.findDepositPd();
            for(String pd_name:list){
                System.out.println("pd_name : " + pd_name);
                System.out.println("product: " + accountyService.findDepositPdVal(pd_name));
            }
        }catch(IOException e){
            e.printStackTrace();
        }
        return "profile";
  }
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
