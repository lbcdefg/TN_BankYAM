package tn.bankYam.controller;


import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import tn.bankYam.dto.Transactions;
import tn.bankYam.service.*;

import java.io.IOException;
import tn.bankYam.dto.Accounty;
import tn.bankYam.dto.Product;
import tn.bankYam.service.AccountyService;


import javax.servlet.http.HttpServletRequest;
import java.sql.Date;
import java.time.LocalDate;
import java.time.Month;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("admin")
public class AdminController {
    @Autowired
    private AccountyService accountyService;
    @Autowired
    private TransactionService transactionService;
    @Autowired
    private RegisterMail registerMail;
    @Autowired
    AccountManageService accountManageService;

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

    public void int_update_ok(Transactions transactions){
        List<Accounty> accountyList = accountyService.findAccounty();
        for(Accounty account: accountyList) {
            String day = account.getAc_udate().toString().substring(account.getAc_udate().toString().lastIndexOf("-") + 1);
            System.out.println(day);
            LocalDate now = LocalDate.now();
            int nowDD = now.getDayOfMonth();
            int nowMM = now.getMonthValue();
            int udateDD = Integer.parseInt(day);
            if(nowDD  == udateDD){
                account.setAc_balance((long) (account.getAc_balance() * (1 + ((account.getProduct().getPd_rate()+account.getProduct().getPd_addrate()) / 100)/12)));
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
                        transactions.setTr_amount((long) (account.getAc_balance() * ((account.getProduct().getPd_rate()+account.getProduct().getPd_addrate()) / 100)/12));
                        transactions.setTr_after_balance((account.getAc_balance()));
                        transactions.setTr_msg("뱅크얌" +nowMM+"월 이자");
                        transactionService.insertTrLog(transactions);
                    }
                }
            }
        }
    }

    // 현재 금리가 이전대비 변동이 있으면 새로운 상품으로 insert, 기존상품 xdate는 오늘로 update
    @GetMapping("rate_update_ok")
    public String rate_update_ok(Model model,Transactions transactions) throws Exception {
        Float rate = crawling();
        List<String> list = accountyService.findDepositPd();

        for(String pd_name:list){
            Product product = accountyService.findDepositPdVal(pd_name);
            float oldRate = product.getPd_rate();
            System.out.println("rate: " + rate + ", oldRate : " + oldRate);
            if(rate != oldRate){
                accountyService.updatePdXdate(product);
                Product newProduct = product;
                // 적금이면 현재금리의 50% 추가적용
                newProduct.setPd_rate(rate);
                if(newProduct.getPd_type().equals("적금")){
                    newProduct.setPd_addrate((float)(rate*0.5) + product.getPd_addrate());
                }
                accountyService.insertPd(newProduct);
            }
        }
        int_update_ok(transactions);

        savingEndMail();

        savingEndGiveInt(transactions);

        model.addAttribute("rate",rate);
        return "redirect:/member/profile";
    }

    @GetMapping("product_option")
    public String product_option(@RequestParam("pd_type") String pd_type, Model model) {
        String selectResult = pd_type;
        if (selectResult.equals("전체")) {
            List<Product> productList = accountyService.findPdByPdname();
            List<String> pdSelectList = accountyService.findPdtype();
            model.addAttribute("productList", productList);
            model.addAttribute("pdSelectList", pdSelectList);
            return "profile";
        } else {
            List<Product> selectList = accountyService.findPdByPdtype(selectResult);
            List<String> pdSelectList = accountyService.findPdtype();
            model.addAttribute("pdSelectList", pdSelectList);
            model.addAttribute("productList", selectList);
            return "profile";
        }
    }

    // admin profile에서 product 추가
    @PostMapping("addProduct_ok")
    public String addProduct_ok(Product product){
        float rate = crawling();
        float addrate;
        if(product.getPd_type().equals("적금")){
            addrate = (float)(crawling()*0.5) + product.getPd_addrate();
        }else{
            addrate = product.getPd_addrate();
        }
        product.setPd_rate(rate);
        product.setPd_addrate(addrate);
        product.setPd_del("X");
        accountyService.insertPd(product);
        return "redirect:/member/profile";
    }

    @GetMapping("delete_pd_ok")
    public String delete_pd_ok(@RequestParam("pd_seq") long pd_seq, Product product){
        product.setPd_seq(pd_seq);
        accountyService.updatePdXdate(product);
        return "redirect:/member/profile";
    }

    // admin profile에서 product 추가시 중복체크 ajax
    @GetMapping("/pd_nameCheck")
    @ResponseBody
    boolean pd_nameCheck(HttpServletRequest request){
        String pd_name = request.getParameter("pd_name");
        String pd_type = request.getParameter("pd_type");
        List<String> pd_nameList;

        if(pd_type.equals("예금")){
            // 예금일때 현재 판매중인 상품 목록
            pd_nameList = accountyService.findDepositPd();
        }else{
            // 적금일때 현재 판매중인 상품 목록
            pd_nameList = accountyService.findSavingPd();
        }

        // form에서 입력된 pd_name과 현재 판매중인 상품 중 이름이 동일한 것이 있다면 return true
        if(pd_nameList.size()!=0){
            for(String name:pd_nameList){
                if(name.equals(pd_name)){
                    return true;
                }
            }
        }
        return false;
    }

    // 만기일 도래시 회원 메일로 통보메일 보내기
    public void savingEndMail() throws Exception{
        List<Accounty> savingList = accountyService.findSavingAcc();
        if(savingList.size()>0){
            for(Accounty accounty : savingList){
                // 만기일도래 적금계좌 주인의 주계좌 찾기
                //System.out.println("savingEnd()의 accounty : " + accounty);
                Accounty mainAcc = accountyService.findMainAcc(accounty.getAc_mb_seq());
                // 적금만기알림 메일 보내기( 적금계좌와 주계좌를 파라미터로 넣고 보냄 )
                registerMail.savingEnd(accounty, mainAcc);
            }
        }
    }
    public void savingEndGiveInt(Transactions transactions){
        List<Accounty> savingList = accountyService.findSavingAcc();
        for(Accounty account: savingList){
            Accounty mainAcc = accountyService.findMainOnlyAcc(account.getAc_mb_seq());
            long savingAccInt = (long) (account.getAc_balance() * (1 + ((account.getProduct().getPd_rate() + account.getProduct().getPd_addrate()))/100));
            mainAcc.setAc_balance(mainAcc.getAc_balance()+savingAccInt);
            accountyService.interestSavingAcc(mainAcc);
            transactions.setTr_ac_seq(mainAcc.getAc_seq());
            transactions.setTr_other_accnum(account.getAc_seq());
            transactions.setTr_other_bank(account.getAc_name());
            transactions.setTr_type("입금");
            transactions.setTr_amount(savingAccInt);
            transactions.setTr_after_balance(mainAcc.getAc_balance());
            transactions.setTr_msg("적금만기");
            transactionService.insertTrLog(transactions);
            accountManageService.deleteAc(account.getAc_seq());
        }
    }
}
