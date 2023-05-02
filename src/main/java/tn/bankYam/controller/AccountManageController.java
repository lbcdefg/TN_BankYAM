package tn.bankYam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import tn.bankYam.dto.*;
import tn.bankYam.service.AccountManageService;
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
@RequestMapping("accountM")
public class AccountManageController {

    @Autowired
    private AccountManageService accountManageService;

    @Autowired
    private TransactionService transactionService;

    @GetMapping("accounts")
    public String accounts(Model model, HttpServletResponse response, HttpSession session, Long ac_seq, String cat){
        //세션 불러오기
        Membery membery = (Membery)session.getAttribute("membery");
        if(membery != null) {   // 나중에 로그인 전용 페이지로 구성하면 해당 if문 없애기
            // 초기 경로로 들어올 때
            try {
                if (ac_seq == null && cat == null) {
                    List<Accounty> acList = accountManageService.selectAcList(membery); // 계좌(사용중, 휴면)
                    List<Accounty> acXList = accountManageService.selectAcXList(membery);   // 계좌(해지, 복구중)
                    System.out.println("계좌관리 리스트(사용중,휴면)): " + acList); // 체크
                    System.out.println("계좌관리 리스트(해지,복구중)): " + acXList); // 체크

                    model.addAttribute("acList", acList);
                    model.addAttribute("acXList", acXList);
                    return "accounts";
                // 주 계좌 변경으로 들어올 때
                }else if (ac_seq != null && cat.equals("acM")) {
                    HashMap<String, Object> forAcMap = accountManageService.forMapIdId(ac_seq, membery.getMb_seq());
                    System.out.println("업데이트용 Map: " + forAcMap); // 체크

                    // 기존 주 계좌 체크
                    List<Accounty> acBeforeMain = accountManageService.checkAcBeforeMain(membery.getMb_seq());
                    System.out.println("원래 주 계좌(1개여야함): " + acBeforeMain); // 체크

                    // 주 계좌가 하나여야 하므로 체크(가입할 때 1개 가입되므로 없거나 2개 이상이면 DB에 문제가 있는 것임!!!)
                    if (acBeforeMain.size() == 1) {

                        // 새로운 주 계좌 체크: 주인 및 계좌 체크(주인의 해당 계좌인게 확실할 때 update가 되어야 함)
                        Accounty acCheck = accountManageService.checkAc(forAcMap);
                        System.out.println("설정할 주 계좌: " + acCheck); // 체크

                        if (acCheck != null) {
                            // 기존 주 계좌가 새롭게 설정할 주 계좌랑 다를 때 이루어져야 함
                            if(acBeforeMain.get(0).getAc_seq() != acCheck.getAc_seq()) {
                                accountManageService.updateAcBeforeMain(acBeforeMain.get(0));
                                accountManageService.updateAcNewMain(acCheck);

                                System.out.println("원래 주 계좌(이젠 부 계좌): " + acBeforeMain.get(0)); // 체크
                                System.out.println("새로운 주 계좌(원래 부 계좌): " + acCheck); // 체크
                                ScriptUtil.alertAndMovePage(response, "주 계좌 설정 완료", "/accountM/accounts");
                            }
                        }
                    }
                }
                ScriptUtil.alertAndBackPage(response, "이상한 경로로 오셨어요.. 절차대로 실행해 주세요!");
                return null;
            } catch(IOException ie){
                return "accounts";
            }
        }
        return "accounts";
    }

    @PostMapping("accounts_nameC")
    public String accounts_nameC(Accounty accounty, HttpServletResponse response, HttpSession session){
        //세션 불러오기
        Membery membery = (Membery)session.getAttribute("membery");

        System.out.println(accounty);   // 체크

        if(membery != null) {   // 나중에 로그인 전용 페이지로 구성하면 해당 if문 없애기
            try {
                accountManageService.updateAcName(accounty);

                ScriptUtil.alertAndMovePage(response, "계좌 별칭 설정 완료", "/accountM/accounts");
            }catch(IOException ie){
                return "accounts";
            }
        }
        return "accounts";
    }

    @PostMapping("accounts_psCheck")
    public @ResponseBody String accounts_psCheck(HttpSession session, long ac_seq, long ac_ps) throws NoSuchAlgorithmException {
        Membery membery = (Membery)session.getAttribute("membery");

        System.out.println("계좌번호: " + ac_seq);
        System.out.println("기존 계좌 비밀번호(입력값): " + ac_ps);

        if(membery != null) {   // 나중에 로그인 전용 페이지로 구성하면 해당 if문 없애기
            // 비밀번호 체크횟수 먼저 확인하기
            Accounty checkAc = accountManageService.checkAcOnly(ac_seq);

            if(checkAc.getAc_pwd_check() == 5){
                return "0";
            }

            // 입력 비밀번호 코드화 및 체크
            String codePs = SHA256.encrypt(ac_ps+"");
            String codeVs = SHA256.encrypt(checkAc.getAc_pwd()+"");

            System.out.println("입력비밀번호 코드: " + codePs);
            System.out.println("DB비밀번호 코드: " + codeVs);

            // 비밀번호 체크
            if(codeVs.equals(codePs) || codePs.equals(checkAc.getAc_pwd())){
                // 비밀번호 맞췄을 때 (비밀번호 체크횟수 초기화 -> 0)
                accountManageService.updateAcPwdCheck(ac_seq);
                return "allow";
            }else{
                // 비밀번호 틀렸을 때(비밀번호 체크횟수 증가 -> 최대5)
                accountManageService.updateAcPwdWrong(ac_seq);
                long result = 5 - (checkAc.getAc_pwd_check() + 1);
                return result+"";
            }
        }
        return "cancel";
    }

    @PostMapping("accounts_psChange")
    public String accounts_psChange(Accounty accounty, HttpServletResponse response, HttpSession session) {
        //세션 불러오기
        Membery membery = (Membery) session.getAttribute("membery");

        System.out.println(accounty);   // 체크
        if (membery != null) {   // 나중에 로그인 전용 페이지로 구성하면 해당 if문 없애기
            try {
                accountManageService.updateAcPs(accounty);

                ScriptUtil.alertAndMovePage(response, "비밀번호 재설정 완료", "/accountM/accounts");
            } catch (IOException ie) {
                return "accounts";
            }
        }
        return "accounts";
    }

    @GetMapping("accounts_update")
    public String newAccount(Transactions transactions, HttpSession session, HttpServletResponse response, Long ac_seq, String upCat){
        Membery membery = (Membery)session.getAttribute("membery");

        if(membery != null) {   // 나중에 로그인 전용 페이지로 구성하면 해당 if문 없애기
            try{
                if(ac_seq != null) {
                    Accounty checkAc = accountManageService.checkAcOnly(ac_seq);
                    HashMap<String, Object> forAcSt = accountManageService.forMapIdSt(ac_seq, upCat);
                    if(upCat.equals("복구신청") && checkAc.getAc_status().equals("해지")){
                        accountManageService.updateAcStatus(forAcSt);
                        ScriptUtil.alertAndMovePage(response, "계좌 복구 신청이 완료되었습니다", "/accountM/accounts");
                    }else if(upCat.equals("복구취소") && checkAc.getAc_status().equals("복구중")) {
                        accountManageService.updateAcStatus(forAcSt);
                        ScriptUtil.alertAndMovePage(response, "계좌 복구가 취소되었습니다", "/accountM/accounts");
                    }else if(upCat.equals("휴면신청") && checkAc.getAc_status().equals("사용중")) {
                        accountManageService.updateAcStatus(forAcSt);
                        ScriptUtil.alertAndMovePage(response, "계좌가 휴면상태가 되었습니다", "/accountM/accounts");
                    }else if(upCat.equals("휴면취소") && checkAc.getAc_status().equals("휴면")) {
                        accountManageService.updateAcStatus(forAcSt);
                        ScriptUtil.alertAndMovePage(response, "휴면상태가 취소되었습니다", "/accountM/accounts");
                    }else if(upCat.equals("해지신청") && (checkAc.getAc_status().equals("사용중") || checkAc.getAc_status().equals("휴면"))) {
                        accountManageService.updateAcStatus(forAcSt);
                        ScriptUtil.alertAndMovePage(response, "계좌가 해지되었습니다", "/accountM/accounts");
                    }else if((upCat.equals("삭제") && checkAc.getAc_status().equals("해지")) || (upCat.equals("삭제") && !checkAc.getProduct().getPd_type().equals("예금"))){
                        // 주 계좌 불러오기 앞에서 2개 이상인지(장애상황) 체크하므로 index 0번 바로 사용 가능
                        List<Accounty> acBeforeMain = accountManageService.checkAcBeforeMain(membery.getMb_seq());

                        // 삭제할 계좌의 잔액 확인하기(JS와 더블체크)
                        if(checkAc.getAc_balance() >= 0 ){
                            HashMap<String, Object> forMain = accountManageService.forMapIdL(acBeforeMain.get(0).getAc_seq(), checkAc.getAc_balance());
                            accountManageService.updateAcBalance(forMain);  // 주 계좌에 삭제할 계좌 잔액 추가

                            HashMap<String, Object> forDel = accountManageService.forMapIdL(ac_seq, -(checkAc.getAc_balance()));
                            accountManageService.updateAcBalance(forDel);   // 삭제할 계좌에서 잔액 빼기

                            // 거래 Table에 추가할 내용 세팅 및 업데이트 (삭제할 계좌)
                            Transactions tranDel = transactionService.setTransactions(ac_seq, acBeforeMain.get(0).getAc_seq(),"뱅크얌", "송금",
                                    checkAc.getAc_balance(), (checkAc.getAc_balance()-checkAc.getAc_balance()), membery.getMb_name()+" 보냄");
                            transactionService.insertTrLog(tranDel);

                            // 거래 Table에 추가할 내용 세팅 및 업데이트 (주 계좌)
                            Transactions tranMain = transactionService.setTransactions(acBeforeMain.get(0).getAc_seq(), ac_seq, "뱅크얌", "입금",
                                    checkAc.getAc_balance(), (acBeforeMain.get(0).getAc_balance() + checkAc.getAc_balance()), membery.getMb_name()+" 보냄");
                            transactionService.insertTrLog(tranMain);

                            // 잔액 검증
                            Accounty afterCheckAc = accountManageService.checkAcOnly(ac_seq);
                            if(afterCheckAc.getAc_balance() == 0){
                                accountManageService.deleteAc(ac_seq);

                                ScriptUtil.alertAndMovePage(response, "계좌 삭제가 완료되었습니다", "/accountM/accounts");
                            }else{
                                ScriptUtil.alertAndBackPage(response, "잔액 이동 시 문제 발생!!!");
                            }
                        }else{
                            ScriptUtil.alertAndBackPage(response, "잔액에 문제가 있는데 어떻게 들어오셨죠.. 절차대로 실행해 주세요!");
                        }
                    }else{
                        ScriptUtil.alertAndBackPage(response, "이상한 경로로 오셨어요.. 절차대로 실행해 주세요!");
                    }
                }
            }catch(IOException ie){
                return "accounts";
            }
        }
        return "accounts";
    }

    @GetMapping("newAccount")
    public String newAccount(Model model, HttpSession session){
        Membery membery = (Membery)session.getAttribute("membery");

        if(membery != null) {   // 나중에 로그인 전용 페이지로 구성하면 해당 if문 없애기
            // 상품 이름들 받아서 뿌려줄 용도
            List<Product> pdNames = accountManageService.forRecentPdList(); // 예금 상품들

            model.addAttribute("pdNames", pdNames);

            // 이자 지급일 만들어줄 데이터들 담긴 리스트
            List<Object> getDMY = accountManageService.getDMY();

            model.addAttribute("nowDay", getDMY.get(0));
            model.addAttribute("day", getDMY.get(1));
            model.addAttribute("monthYear", getDMY.get(2));
        }
        return "newAccount";
    }

    @PostMapping("accounts_pdAjax")
    public @ResponseBody List<String> acNamesList(HttpSession session, String pd_name) {
        Membery membery = (Membery)session.getAttribute("membery");

        if(membery != null) {   // 나중에 로그인 전용 페이지로 구성하면 해당 if문 없애기
            // 내 계좌들 전부 가져올 리스트
            List<Accounty> getAc = accountManageService.myAllAcBySeq(membery.getMb_seq());

            System.out.println(getAc);
            // 계좌 선택 및 계좌 별칭용 리스트
            return accountManageService.forAcNames(getAc, pd_name);
        }
        return null;
    }

    // 신규계좌생성시 상품 종류 선택으로 각기 다른 option 뿌려줄 ajax
    @PostMapping("accounts_pdSelectAjax")
    public @ResponseBody List<Product> pdNamesList(HttpSession session, String catPd) {
        Membery membery = (Membery)session.getAttribute("membery");

        if(membery != null) {   // 나중에 로그인 전용 페이지로 구성하면 해당 if문 없애기
            if(catPd.equals("deposit")){
                List<Product> pdNames = accountManageService.forRecentPdList(); // 예금 상품들
                System.out.println(pdNames);
                return pdNames;
            }else if(catPd.equals("saving")){
                List<Product> pdNames = accountManageService.forRecentPdList2(); // 적금 상품들
                System.out.println(pdNames);
                return pdNames;
            }
        }
        return null;
    }

    @PostMapping("accounts_newAc")
    public String accounts_newAc(Accounty accounty, HttpServletResponse response, HttpSession session, HttpServletRequest request) throws NoSuchAlgorithmException {
        Membery membery = (Membery)session.getAttribute("membery");

        if(membery != null) {   // 나중에 로그인 전용 페이지로 구성하면 해당 if문 없애기
            accounty.setAc_mb_seq(membery.getMb_seq());
            accounty.setAc_pwd(SHA256.encrypt(accounty.getAc_pwd()+""));
            accounty.setAc_pd_seq(Long.parseLong(request.getParameter("ac_pd_seq_dummy")));
            accounty.setAc_udate(accountManageService.modifyData(request.getParameter("ac_udate_dummy")));

            System.out.println(accounty);
            try {
                accountManageService.insertAc(accounty);

                ScriptUtil.alertAndMovePage(response, "새 계좌가 개설되었습니다", "/accountM/accounts");
            }catch(IOException ie){
                return "accounts";
            }
        }
        return "accounts";
    }
}