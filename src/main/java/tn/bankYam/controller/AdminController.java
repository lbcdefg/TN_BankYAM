package tn.bankYam.controller;


import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import tn.bankYam.dto.Transactions;
import tn.bankYam.service.AccountyService;
import java.io.IOException;
import tn.bankYam.dto.Accounty;
import tn.bankYam.dto.Product;
import tn.bankYam.service.AccountyService;
import tn.bankYam.service.TransactionService;


import java.time.LocalDate;
import java.time.Month;
import java.util.List;

@Controller
@RequestMapping("admin")
public class AdminController {
    @Autowired
    private AccountyService accountyService;
    @Autowired
    private TransactionService transactionService;

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
                account.setAc_balance((long) (account.getAc_balance() * (1 + (account.getProduct().getPd_rate() / 100)/12)));
                List<String> productList = accountyService.findDepositPd();
                for (String product : productList) {
                    if (product.equals(account.getProduct().getPd_name())) {
                        Product pd = accountyService.findDepositPdVal(account.getProduct().getPd_name());
                        account.setAc_pd_seq(pd.getPd_seq());
                        accountyService.interest(account);
                        transactions.setTr_ac_seq(account.getAc_seq());
                        transactions.setTr_other_accnum(1234567891);
                        transactions.setTr_other_bank("뱅크얌");
                        transactions.setTr_type("입금");
                        transactions.setTr_amount((long) (account.getAc_balance() * (account.getProduct().getPd_rate() / 100)/12));
                        transactions.setTr_after_balance((long) (account.getAc_balance() * (1 + (account.getProduct().getPd_rate() / 100)/12)));
                        transactions.setTr_msg("뱅크얌" +nowMM+"월 이자");
                        transactionService.insertTrLog(transactions);
                    }
                }
            }
            }
        return "redirect:/member/profile";
        }
}
