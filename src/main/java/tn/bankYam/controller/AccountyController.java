package tn.bankYam.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import tn.bankYam.dto.Accounty;
import tn.bankYam.dto.Membery;
import tn.bankYam.dto.Transactions;
import tn.bankYam.service.AccountManageService;
import tn.bankYam.service.AccountyService;
import tn.bankYam.service.MemberyService;
import tn.bankYam.service.TransactionService;
import tn.bankYam.utils.SHA256;
import tn.bankYam.utils.ScriptUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
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


    //거래내역 불러오기
    @GetMapping("transactionList")
    public String transactionList(Model model, HttpSession session){
        Membery membery = (Membery)session.getAttribute("membery");
        Accounty accounty = new Accounty();
        accounty.setAc_mb_seq(membery.getMb_seq());
        Transactions transactions = new Transactions();
        transactions.setAccounty(accounty);
        transactions.setTr_type("empty");
        transactions.setTr_other_bank("empty");
        List<Transactions> trList = transactionService.selectTrListS(transactions);
        List<Accounty> accList = accountyService.findAccListByMemberSeqS(membery.getMb_seq());

        model.addAttribute("trList", trList);
        model.addAttribute("accList", accList);
        return "transactionList";
    }
    @GetMapping("trListSearch")
    @ResponseBody
    public List<Transactions> trListSearch(HttpSession session, Model model, Transactions transactions){
        Membery membery = (Membery)session.getAttribute("membery");
        Accounty accounty = new Accounty();
        accounty.setAc_mb_seq(membery.getMb_seq());
        transactions.setAccounty(accounty);
        List<Transactions> trList = transactionService.selectTrListS(transactions);
        return trList;
    }

    //계좌이체 창
    @GetMapping("transfer")
    public String transfer(Model model,HttpSession session, Accounty accounty,HttpServletResponse response, long other_mb_seq) throws IOException {
        Membery membery = (Membery)session.getAttribute("membery");
        List<Accounty> accList = accountyService.selectAccNumS(membery.getMb_seq());

        for(int i = 0; i < accList.size(); i++){
            Accounty accInfo = accountyService.selectAccInfoS(accList.get(i).getAc_seq());
            accList.get(i).setAc_balance(accInfo.getAc_balance());
            accList.get(i).setAc_pwd(accInfo.getAc_pwd());
        }

        if(other_mb_seq > 0){
            List<Accounty> tempAccounty = accountyService.selectAccNumS(other_mb_seq);
            Accounty accounty_list = new Accounty();

            for(Accounty acc: tempAccounty){
                if(acc.getAc_main().equals("주")){
                    accounty_list = acc;
                }
            }

            model.addAttribute("tr_other_accnum", accounty_list.getAc_seq());
        }else{
            model.addAttribute("tr_other_accnum", "");
        }

        model.addAttribute("accList", accList);
        return "transfer";
    }

    @GetMapping("checkBalance")
    @ResponseBody
    public Accounty checkBalance(HttpSession session, long ac_seq){
        Accounty accounty = accountyService.selectAccInfoS(ac_seq);
        return accounty;
    }

    //계좌이체 확인체크
    @PostMapping("transfer_chk")
    public String transferChk(Model model, HttpSession session,HttpServletResponse response, Accounty accounty, Transactions transactions, String ac_pwd) throws IOException, NoSuchAlgorithmException {
        Membery membery = (Membery)session.getAttribute("membery");
        long otherAccNum = transactions.getTr_other_accnum();
        Accounty myAccounty = accountyService.selectAccInfoS(accounty.getAc_seq());
        Accounty otherBankyamInfo = accountyService.selectAccInfoS(otherAccNum);

        //비밀번호 틀린횟수를 먼저 조회
        if (myAccounty.getAc_pwd_check() == 5) {
            ScriptUtil.alertAndClosePage(response, "비밀번호 재설정이 필요한 계좌입니다.");
        }else {
            //암호화 되어있을때랑 되어있지 않을때
            if (accounty.getAc_pwd().equals(myAccounty.getAc_pwd()) || (SHA256.encrypt(accounty.getAc_pwd())).equals(myAccounty.getAc_pwd())){
                transactions.setTr_ac_seq(myAccounty.getAc_seq());
                //상대방이 뱅크얌 계좌주일때
                if (otherBankyamInfo != null) {
                    Membery membery1 = memberyService.findBySeq(otherBankyamInfo.getAc_mb_seq());
                    otherBankyamInfo.setMembery(membery1);
                    transactions.setOtherAccount(otherBankyamInfo);
                    //상대방이 뱅크얌 계좌주가 아닐때
                } else if (!transactions.getTr_other_bank().equals("뱅크얌")) {
                    System.out.println("타행입니다");
                    //상대방의 은행 뱅크얌 선택 후 올바른 계좌번호를 입력하지 않았을 때
                } else if (transactions.getTr_other_bank().equals("뱅크얌") && otherBankyamInfo == null) {
                    ScriptUtil.alertAndBackPage(response, "뱅크얌 계좌가 아닙니다");
                }else if(otherAccNum==0 || otherAccNum<0){
                    ScriptUtil.alertAndBackPage(response, "계좌번호를 다시한번 확인해주세요");
                }
                //유저가 입력한 비밀번호와 db 비밀번호가 다르면 ac_pwd_check +1
            } else {
                accountyService.updateAcPwdWrongS(myAccounty.getAc_seq());
                ScriptUtil.alertAndBackPage(response, "다시 한 번 확인해주세요");
            }
        }

        model.addAttribute("transactions",transactions);
        model.addAttribute("otherAccount", otherBankyamInfo);
        model.addAttribute("membery",membery);
        return "confirmation";
    }

    //계좌이체
    @PostMapping ("transfer_ok")
    public String transferOk(Model model, HttpSession session, String ac_pwd, Transactions transactions){
        Membery membery = (Membery)session.getAttribute("membery");
        HashMap<String, Object> hashMap = new HashMap<String, Object>();
        hashMap.put("tr_ac_seq", transactions.getTr_ac_seq());
        hashMap.put("ac_pwd", ac_pwd);
        hashMap.put("tr_other_bank", transactions.getTr_other_bank());
        hashMap.put("tr_amount", transactions.getTr_amount());
        hashMap.put("tr_other_accnum", transactions.getTr_other_accnum());
        hashMap.put("tr_after_balance", transactions.getTr_after_balance());
        hashMap.put("tr_date", transactions.getTr_date());
        hashMap.put("tr_msg", transactions.getTr_msg());
        Accounty accInfo = accountyService.selectAccInfoS(transactions.getTr_ac_seq());
        long trAcBal = accInfo.getAc_balance() - transactions.getTr_amount();
        hashMap.put("tr_after_balance", trAcBal);
        transactions.setTr_after_balance(trAcBal);

        model.addAttribute("tr_ac_seq", hashMap.get("tr_ac_seq"));
        model.addAttribute("tr_other_bank", hashMap.get("tr_other_bank"));
        model.addAttribute("tr_amount", hashMap.get("tr_amount"));
        model.addAttribute("tr_other_accnum", hashMap.get("tr_other_accnum"));
        model.addAttribute("tr_msg", hashMap.get("tr_msg"));
        model.addAttribute("tr_date", hashMap.get("tr_date"));
        model.addAttribute("tr_after_balance", trAcBal);
        model.addAttribute("transactions",transactions);
        accountyService.transferS(transactions);
        accountyService.getPaidS(transactions);
        return "receipt";
    }

}
