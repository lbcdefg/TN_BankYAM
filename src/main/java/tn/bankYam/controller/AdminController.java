package tn.bankYam.controller;


import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import tn.bankYam.dto.Transactions;
import tn.bankYam.service.AccountyService;
import java.io.IOException;
import tn.bankYam.dto.Accounty;
import tn.bankYam.dto.Product;
import tn.bankYam.service.AccountyService;
import tn.bankYam.service.TransactionService;


import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;
import java.time.Month;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("admin")
public class AdminController {
    @Autowired
    private AccountyService accountyService;
    @Autowired
    private TransactionService transactionService;

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
    @GetMapping("int_update_ok")
    public String int_update_ok(Transactions transactions){
        List<Accounty> accountyList = accountyService.findAccounty();
        Product recentPd = accountyService.recentPd();
        for(Accounty account: accountyList) {
            String day = account.getAc_udate().toString().substring(account.getAc_udate().toString().lastIndexOf("-") + 1);
            System.out.println(day);
            LocalDate now = LocalDate.now();
            int nowDD = now.getDayOfMonth();
            int nowMM = now.getMonthValue();
            int udateDD = Integer.parseInt(day);
            if(nowDD  == udateDD){
                account.setAc_balance((long) (account.getAc_balance() * (1 + (account.getProduct().getPd_rate()+account.getProduct().getPd_addrate() / 100)/12)));
                List<String> productList = accountyService.findDepositPd();
                for (String product : productList) {
                    if (product.equals(account.getProduct().getPd_name())) {
                        Product pd = accountyService.findDepositPdVal(account.getProduct().getPd_name()+account.getProduct().getPd_addrate());
                        account.setAc_pd_seq(pd.getPd_seq());
                        accountyService.interest(account);
                        transactions.setTr_ac_seq(account.getAc_seq());
                        transactions.setTr_other_accnum(1234567891);
                        transactions.setTr_other_bank("뱅크얌");
                        transactions.setTr_type("입금");
                        transactions.setTr_amount((long) (account.getAc_balance() * (account.getProduct().getPd_rate()+account.getProduct().getPd_addrate() / 100)/12));
                        transactions.setTr_after_balance((long) (account.getAc_balance() * (1 + (account.getProduct().getPd_rate()+account.getProduct().getPd_addrate() / 100)/12)));
                        transactions.setTr_msg("뱅크얌" +nowMM+"월 이자");
                        transactionService.insertTrLog(transactions);
                    }
                }
            }
        }
        return "redirect:/member/profile";
    }


    @GetMapping("rate_update_ok")
    public String rate_update_ok(Model model){
        Float rate = crawling();
        System.out.println("최종금리: " + rate);
        List<String> list = accountyService.findDepositPd();

        for(String pd_name:list){
            Product product = accountyService.findDepositPdVal(pd_name);
            //System.out.println("pd_name : " + pd_name);
            float oldRate = product.getPd_rate();
            System.out.println("rate: " + rate + ", oldRate : " + oldRate);
            if(rate != oldRate){
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

    @GetMapping("test2")
    @ResponseBody
    public String test2(HttpServletRequest request){
        String pd_type = request.getParameter("type").trim();
        return accountyService.test(typeMap(pd_type)).toString();
    }

    public HashMap<String, Object> typeMap(String pd_type){
        System.out.println("타입맵에서 pd_type : " + pd_type);
        HashMap<String, Object> hashMap = new HashMap<>();
        if(pd_type.length() != 0) {
            hashMap.put("pd_type", pd_type);
        }else{
            hashMap.put("pd_type", null);
        }
        return hashMap;
    }
}
