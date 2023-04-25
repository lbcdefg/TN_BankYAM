package tn.bankYam.controller;


import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import tn.bankYam.service.AccountyService;
import java.io.IOException;
import tn.bankYam.dto.Accounty;
import tn.bankYam.dto.Product;


import java.util.List;

@Controller
@RequestMapping("admin")
public class AdminController {
    @Autowired
    private AccountyService accountyService;

    // 한국은행 기준금리 크롤링
    public Float crawling(){
        String URL = "http://www.bok.or.kr/portal/main/main.do";
        Document doc;
        try{
            doc = Jsoup.connect(URL).get();
            Elements elem = doc.select(".ctype1");
            String[] str = elem.text().split(" ");
            Float rate = Float.parseFloat(str[0].substring(0,4));
            return rate;
        }catch(IOException e){
            e.printStackTrace();
        }
        return null;
    }
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

    @GetMapping("rate_update_ok")
    public String rate_update_ok(Model model){
        Float rate = crawling();
        System.out.println("최종금리: " + rate);
        //float rate = 3.8f;
        List<String> list = accountyService.findDepositPd();
        float oldRate = accountyService.findDepositPdVal(list.get(0)).getPd_rate();
        System.out.println("rate: " + rate + ", oldRate : " + oldRate);
        if(rate != oldRate){ //
            for(String pd_name:list){
                //System.out.println("pd_name : " + pd_name);
                Product product = accountyService.findDepositPdVal(pd_name);
                accountyService.updatePdXdate(product);
                Product newProduct = product;
                newProduct.setPd_rate(rate);
                //System.out.println("newProduct : " + newProduct);
                accountyService.insertPd(newProduct);
            }
        }
        model.addAttribute("rate",rate);
        return "profile";
    }
}
