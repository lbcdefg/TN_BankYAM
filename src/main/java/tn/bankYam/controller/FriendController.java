package tn.bankYam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import tn.bankYam.dto.*;
import tn.bankYam.service.ChatroomService;
import tn.bankYam.service.FriendsService;
import tn.bankYam.utils.ScriptUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("friend")
public class FriendController {

    @Autowired
    private FriendsService friendsService;

    @Autowired
    private ChatroomService chatroomService;

    @GetMapping("friends")
    public String friends(Model model, HttpServletRequest request, HttpSession session, String content){
        String queryString = request.getQueryString();  // 친구추가 후 돌아갈 경로 쿼리
        session.setAttribute("query", queryString); // 쿼리 세션에 담기

        //세션 불러오기
        Membery membery = (Membery)session.getAttribute("membery");
        if(membery != null) {   // 나중에 로그인 전용 페이지로 구성하면 해당 if문 없애기
            if(content.equals("list")){
                System.out.println("친구목록 뽑기");  //체크
                List<Friend> frList = friendsService.selectFrList(membery);
                List<Blocklist> frBlocklist = friendsService.selectBlList(membery);
                System.out.println("친구목록: " + frList);  //체크

                LocalDate localDate = LocalDate.now();  // 오늘 친구된 사람 new 뿌려주기용
                Date nowTime = java.sql.Date.valueOf(localDate);

                model.addAttribute("frList", frList);
                model.addAttribute("frBlocklist", frBlocklist);
                model.addAttribute("nowTime", nowTime);
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
    public @ResponseBody List<Object> friendsSearch(Accounty accountyFr, HttpSession session, String text){
        //ajax로 보내줄 데이터 담을 리스트
        List<Object> forFrAjax = new ArrayList<>();

        // 세션 내정보 불러오기
        Membery membery = (Membery)session.getAttribute("membery");

        // Email 또는 계좌번호로 찾으므로 두가지 경우의 수로 HashMap 구성하기
        HashMap<String, Object> searchFrMap = friendsService.forSearchFrMap(text);
        System.out.println(text);

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
                    forFrAjax.add(accountyFr);
                    forFrAjax.add(-1);
                    return forFrAjax;
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
                                    forFrAjax.add(accountyFr);
                                    forFrAjax.add(-6);
                                    return forFrAjax;
                                }
                            }
                        }

                        if(fr.getF_f_mb_seq() == accountyFr.getMembery().getMb_seq()){
                            forFrAjax.add(accountyFr);
                            forFrAjax.add(-2);
                            return forFrAjax;
                        }
                    }
                }

                // 찾은 친구가 요청했거나 받은 상태일 때 체크
                if(frReqList.size() > 0) {
                    for (Friendreq frReq : frReqList) {
                        System.out.println("찾은 친구: " + accountyFr.getMembery().getMb_seq());  //체크
                        System.out.println("내가 친구를 요청한 친구: " + frReq.getMembery().getMb_seq());  //체크

                        if(frReq.getMembery().getMb_seq() == accountyFr.getMembery().getMb_seq()){
                            forFrAjax.add(accountyFr);
                            forFrAjax.add(-3);
                            return forFrAjax;
                        }
                    }
                }

                if(frRecList.size() > 0) {
                    for (Friendreq frReq : frRecList) {
                        System.out.println("찾은 친구: " + accountyFr.getMembery().getMb_seq());  //체크
                        System.out.println("나에게 친구를 요청한 친구: " + frReq.getMembery().getMb_seq());  //체크

                        if(frReq.getMembery().getMb_seq() == accountyFr.getMembery().getMb_seq()){
                            forFrAjax.add(accountyFr);
                            forFrAjax.add(-4);
                            return forFrAjax;
                        }
                    }
                }

                // 찾은 친구가 단순 차단 친구일 때 체크
                if(frBlocklist.size() > 0) {
                    for (Blocklist blockFr : frBlocklist) {
                        System.out.println("찾은 친구: " + accountyFr.getMembery().getMb_seq());  //체크
                        System.out.println("내가 차단한 친구: " + blockFr.getMembery().getMb_seq());  //체크

                        if(blockFr.getMembery().getMb_seq() == accountyFr.getMembery().getMb_seq()){
                            forFrAjax.add(accountyFr);
                            forFrAjax.add(-5);
                            return forFrAjax;
                        }
                    }
                }
            }
        }

        forFrAjax.add(accountyFr);
        forFrAjax.add(0);
        return forFrAjax;
    }

    // 친구 추가 요청시
    @GetMapping("friends_AddFr")
    public String friendsAdd(HttpServletResponse response, HttpSession session, long frId, String catAdd){
        Membery membery = (Membery)session.getAttribute("membery");
        String query = (String)session.getAttribute("query");

        if(membery != null) {   // 나중에 로그인 전용 페이지로 구성하면 해당 if문 없애기
            long mb_seq = membery.getMb_seq();
            System.out.println("mb_seq: " + mb_seq);    // 체크
            System.out.println("frId: " + frId);    // 체크

            HashMap<String, Object> forAddMap = friendsService.forMapIdId(frId, mb_seq);
            System.out.println(forAddMap);    // 체크
            try {
                if(catAdd.equals("reqAdd")) {
                    // 친구추가 요청 / 이미 요청한게 있는지 체크 필요
                    // 자바스크립트에서도 체크를 하지만 혹시 모르므로..
                    Friendreq friendreq = friendsService.checkFrReq(forAddMap);
                    System.out.println(friendreq);  // 체크

                    // 요청하거나 받은 내용이 없을 때만 요청 가능!
                    if (friendreq == null) {
                        friendsService.insertFrReq(forAddMap);
                        if (query != null) {
                            // 친구관리 창에서 보던 페이지가 있으면 그곳으로 다시 돌아가기
                            ScriptUtil.alertAndMovePage(response, "친구신청 완료", "/friend/friends?" + query);
                        } else {
                            // 친구관리 창에서 보던 페이지가 있었더라도 query session에 안담기는 문제가 발생할 수도 있으므로
                            ScriptUtil.alertAndMovePage(response, "친구신청 완료", "/friend/friends?content=req");
                        }
                    }
                }else if(catAdd.equals("blAdd")) {
                    // 친구차단 / 이미 차단한건지 체크 필요
                    // 자바스크립트에서도 체크를 하지만 혹시 모르므로..
                    Blocklist blocklist = friendsService.checkFrBlock(forAddMap);
                    System.out.println(blocklist);  // 체크

                    // 차단하지 않았을 때만 차단 가능!
                    if (blocklist == null) {
                        friendsService.insertFrBlock(forAddMap);
                        if (query != null) {
                            // 친구관리 창에서 보던 페이지가 있으면 그곳으로 다시 돌아가기
                            ScriptUtil.alertAndMovePage(response, "친구차단 완료", "/friend/friends?" + query);
                        } else {
                            // 친구관리 창에서 보던 페이지가 있었더라도 query session에 안담기는 문제가 발생할 수도 있으므로
                            ScriptUtil.alertAndMovePage(response, "친구차단 완료", "/friend/friends?content=block");
                        }
                    }
                }else if(catAdd.equals("frAdd")) {
                    // 친구수락 / 이미 친구인지 체크 필요
                    // 자바스크립트에서도 체크를 하지만 혹시 모르므로..
                    List<Friend> frList = friendsService.checkFr(forAddMap);
                    System.out.println(frList);  // 체크
                    System.out.println(frList.size());  // 체크

                    // 친구가 아닐 때는 size 0
                    if (frList.size() == 0) {
                        friendsService.insertFrM(forAddMap);    // 나 - 친구 : 친구목록 추가
                        friendsService.insertFrF(forAddMap);    // 친구 - 나 : 친구목록 추가
                        forAddMap.put("catDel", "recDel");
                        friendsService.deleteFrReqRec(forAddMap);   // 친구 받기 목록에서 제거
                        ScriptUtil.alertAndMovePage(response, "친구수락 완료", "/friend/friends?content=req");
                    }
                }
                ScriptUtil.alertAndBackPage(response, "이상한 경로로 오셨어요.. 절차대로 실행해 주세요!");
                return null;
            } catch (IOException ie) {
                return "redirect:friends";
            }
        }
        return "redirect:friends";
    }

    // 친구삭제/요청삭제/받은요청삭제
    @GetMapping("friends_delFr")
    public String friendsDel(HttpServletResponse response, HttpSession session, long frId, String catDel){
        Membery membery = (Membery)session.getAttribute("membery");

        if(membery != null) {   // 나중에 로그인 전용 페이지로 구성하면 해당 if문 없애기
            long mb_seq = membery.getMb_seq();
            System.out.println("mb_seq: " + mb_seq);    //체크
            System.out.println("frId: " + frId);    //체크
            HashMap<String, Object> forDelMap = friendsService.forMapIdId(frId, mb_seq);  // 삭제용 Map
            forDelMap.put("catDel", catDel);    // 요청, 받은 목록 구분해서 삭제하기용
            try {
                if(catDel.equals("frDel")) {
                    // 친구 리스트에 있는 현재 내 친구일 때만 삭제하기
                    List<Friend> frList = friendsService.selectFrList(membery); // 친구 리스트
                    for (Friend fr : frList) {
                        if (fr.getMembery().getMb_seq() == frId) {
                            friendsService.deleteFr(forDelMap);
                            // 친구 삭제시 친구요청 DB에서도 날려주기
                            friendsService.deleteFrReqRec(forDelMap);
                            Chatmember chatmember = chatroomService.checkRoomS(membery.getMb_seq(), fr.getF_f_mb_seq());
                            if(chatmember != null){
                                chatroomService.outChat(membery, chatmember.getCm_cr_seq());
                            }
                            ScriptUtil.alertAndMovePage(response, "친구삭제 완료", "/friend/friends?content=list");
                        }
                    }
                }else if(catDel.equals("reqDel")){
                    // 요청 리스트에 있는 친구일 때만 삭제하기
                    List<Friendreq> frReqList = friendsService.selectReqList(membery);  // 요청목록
                    for (Friendreq frReq : frReqList) {
                        if (frReq.getMembery().getMb_seq() == frId) {
                            friendsService.deleteFrReqRec(forDelMap);
                            ScriptUtil.alertAndMovePage(response, "친구요청 취소 완료", "/friend/friends?content=req");
                        }
                    }
                }else if(catDel.equals("recDel")){
                    // 받은 리스트에 있는 친구일 때만 삭제하기
                    List<Friendreq> frRecList = friendsService.selectRecList(membery);  // 받은목록
                    for (Friendreq frRec : frRecList) {
                        if (frRec.getMembery().getMb_seq() == frId) {
                            friendsService.deleteFrReqRec(forDelMap);
                            ScriptUtil.alertAndMovePage(response, "친구요청 받기 취소 완료", "/friend/friends?content=req");
                        }
                    }
                }else if(catDel.equals("blDel")){
                    // 차단 리스트에 있는 친구일 때만 삭제하기
                    List<Blocklist> frBlocklist = friendsService.selectBlList(membery); // 차단 리스트
                    for (Blocklist frBlock : frBlocklist) {
                        if (frBlock.getMembery().getMb_seq() == frId) {
                            friendsService.deleteFrBlock(forDelMap);
                            ScriptUtil.alertAndMovePage(response, "친구차단 취소 완료", "/friend/friends?content=block");
                        }
                    }
                }

                // 임의의 경로로 접근하는 경우 차단하기
                ScriptUtil.alertAndBackPage(response, "정확한 경로로 실행해주세요..!");
                return null;
            } catch (IOException ie) {
                return "redirect:friends";
            }
        }
        return "redirect:friends";
    }
}
