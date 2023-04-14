package tn.bankYam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import tn.bankYam.dto.*;
import tn.bankYam.service.FriendsService;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("friend")
public class FriendController {

    @Autowired
    private FriendsService friendsService;

    @GetMapping("friends")
    public String friends(Model model, HttpSession session, String content){
        //세션 불러오기
        Membery membery = (Membery)session.getAttribute("membery");
        if(membery != null) {   // 나중에 로그인 전용 페이지로 구성하면 해당 if문 없애기
            if(content.equals("list")){
                System.out.println("친구목록 뽑기");  //체크
                List<Friend> frList = friendsService.selectFrList(membery);
                List<Blocklist> frBlocklist = friendsService.selectBlList(membery);
                System.out.println("친구목록: " + frList);  //체크
                model.addAttribute("frList", frList);
                model.addAttribute("frBlocklist", frBlocklist);
            }else if(content.equals("req")){
                System.out.println("요청목록 뽑기");  //체크
                List<Friendreq> frReqList = friendsService.selectReqList(membery);  // 요청목록
                List<Friendreq> frRecList = friendsService.selectRecList(membery);  // 받은목록
                System.out.println("친구요청목록: " + frReqList);  //체크
                System.out.println("친구받은목록: " + frRecList);  //체크
                model.addAttribute("frReqList", frReqList);
                model.addAttribute("frRecList", frRecList);
            }else if(content.equals("block")){
                System.out.println("차단목록 뽑기");  //체크
                List<Blocklist> frBlocklist = friendsService.selectBlList(membery);
                System.out.println("친구차단목록: " + frBlocklist);     //체크
                model.addAttribute("frBlocklist", frBlocklist);
            }
        }
        model.addAttribute("content", content);
        return "friends";
    }

    //친구 찾기 Ajax
    @PostMapping("friends_searchFr")
    public @ResponseBody Accounty friendsSearch(Accounty accountyFr, HttpSession session, String text){
        // 세션 내정보 불러오기
        Membery membery = (Membery)session.getAttribute("membery");

        // Email 또는 계좌번호로 찾으므로 두가지 경우의 수로 HashMap 구성하기
        HashMap<String, Object> searchFrMap = friendsService.forSearchFrMap(text);

        // 찾은 친구 가져오기(계좌가 여러개 있을 수 있으므로 list로 받기)
        List<Accounty> memberyFrList = friendsService.searchFriend(searchFrMap);
        System.out.println(memberyFrList.size());
        if(memberyFrList.size() > 0) {
            accountyFr = memberyFrList.get(0);
        }
        if(membery != null) {   // 나중에 로그인 전용 페이지로 구성하면 해당 if문 없애기
            // 찾은 친구가 존재하는지 체크
            if(accountyFr.getMembery() != null) {
                // 찾은 친구가 나 자신일 때 체크
                if (membery.getMb_email().equals(accountyFr.getMembery().getMb_email())) {
                    accountyFr.getMembery().setMb_seq(-1);
                    return accountyFr;
                }
                List<Friend> frList = friendsService.selectFrList(membery); // 친구 리스트
                List<Blocklist> frBlocklist = friendsService.selectBlList(membery); // 차단 리스트
                List<Friendreq> frReqList = friendsService.selectReqList(membery);  // 요청목록
                List<Friendreq> frRecList = friendsService.selectRecList(membery);  // 받은목록

                System.out.println("친구목록: " + frList);  //체크
                System.out.println("차단목록: " + frBlocklist);  //체크
                System.out.println("친구요청목록: " + frReqList);  //체크
                System.out.println("친구받은목록: " + frRecList);  //체크

                // 찾은 친구가 이미 내 친구일 때 체크
                if(frList.size() > 0) {
                    for (Friend fr : frList) {
                        System.out.println("찾은 친구: " + accountyFr.getMembery().getMb_seq());  //체크
                        System.out.println("내 친구: " + fr.getF_f_mb_seq());  //체크
                        System.out.println("나: " + fr.getF_mb_seq());  //체크

                        // 찾은 친구가 차단 친구이면서 내 친구일 때 체크
                        if(frBlocklist.size() > 0) {
                            for (Blocklist blockFr : frBlocklist) {
                                System.out.println("내가 차단한 친구: " + blockFr.getMembery().getMb_seq());  //체크

                                if((blockFr.getMembery().getMb_seq() == accountyFr.getMembery().getMb_seq()) && (fr.getF_f_mb_seq() == accountyFr.getMembery().getMb_seq())){
                                    accountyFr.getMembery().setMb_seq(-6);
                                    return accountyFr;
                                }
                            }
                        }

                        if(fr.getF_f_mb_seq() == accountyFr.getMembery().getMb_seq()){
                            accountyFr.getMembery().setMb_seq(-2);
                            return accountyFr;
                        }
                    }
                }

                // 찾은 친구가 요청했거나 받은 상태일 때 체크
                if(frReqList.size() > 0) {
                    for (Friendreq frReq : frReqList) {
                        System.out.println("찾은 친구: " + accountyFr.getMembery().getMb_seq());  //체크
                        System.out.println("내가 친구를 요청한 친구: " + frReq.getMembery().getMb_seq());  //체크

                        if(frReq.getMembery().getMb_seq() == accountyFr.getMembery().getMb_seq()){
                            accountyFr.getMembery().setMb_seq(-3);
                            return accountyFr;
                        }
                    }
                }

                if(frRecList.size() > 0) {
                    for (Friendreq frReq : frRecList) {
                        System.out.println("찾은 친구: " + accountyFr.getMembery().getMb_seq());  //체크
                        System.out.println("나에게 친구를 요청한 친구: " + frReq.getMembery().getMb_seq());  //체크

                        if(frReq.getMembery().getMb_seq() == accountyFr.getMembery().getMb_seq()){
                            accountyFr.getMembery().setMb_seq(-4);
                            return accountyFr;
                        }
                    }
                }

                // 찾은 친구가 단순 차단 친구일 때 체크
                if(frBlocklist.size() > 0) {
                    for (Blocklist blockFr : frBlocklist) {
                        System.out.println("찾은 친구: " + accountyFr.getMembery().getMb_seq());  //체크
                        System.out.println("내가 차단한 친구: " + blockFr.getMembery().getMb_seq());  //체크

                        if(blockFr.getMembery().getMb_seq() == accountyFr.getMembery().getMb_seq()){
                            accountyFr.getMembery().setMb_seq(-5);
                            return accountyFr;
                        }
                    }
                }
            }
        }

        return accountyFr;
    }

    // 친구 추가 요청 Ajax
    @PostMapping("friends_reqFr")
    public @ResponseBody String friendsAdd(Model model, HttpSession session, long frId){
        Membery membery = (Membery)session.getAttribute("membery");

        if(membery != null) {   // 나중에 로그인 전용 페이지로 구성하면 해당 if문 없애기
            long myId = membery.getMb_seq();
            System.out.println("myId: " + myId);
            System.out.println("frId: " + frId);
            HashMap<String, Object> forFrReqMap = friendsService.forMapIdId(frId, myId);
            Friendreq friendreq = friendsService.checkFrReq(forFrReqMap);

            System.out.println(forFrReqMap);
            System.out.println(friendreq);

            // 요청하거나 받은 내용이 없으면 요청 가능!
            if(friendreq == null) {
                System.out.println("있으면 들어오면 안됨!");
                friendsService.insertFrReq(forFrReqMap);
                List<Friendreq> frReqList = friendsService.selectReqList(membery);
                List<Friendreq> frRecList = friendsService.selectRecList(membery);
                model.addAttribute("frReqList", frReqList);
                model.addAttribute("frRecList", frRecList);
                return "정상완료";
            }
        }
        return "취소됨";
    }

    @GetMapping("friends_delFr")
    public String friendsDel(HttpSession session, long frId){
        Membery membery = (Membery)session.getAttribute("membery");

        if(membery != null) {   // 나중에 로그인 전용 페이지로 구성하면 해당 if문 없애기
            long myId = membery.getMb_seq();
            System.out.println("myId: " + myId);
            System.out.println("frId: " + frId);
            HashMap<String, Object> forDelMap = friendsService.forMapIdId(frId, myId);
        }
        return "redirect:friends";
    }
}
