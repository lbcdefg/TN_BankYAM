package tn.bankYam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import tn.bankYam.dto.Friend;
import tn.bankYam.dto.Friendreq;
import tn.bankYam.dto.Membery;
import tn.bankYam.service.FriendsService;
import tn.bankYam.utils.ScriptUtil;

import javax.servlet.http.HttpServletResponse;
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
                System.out.println("친구목록 뽑기");
                List<Friend> frList = friendsService.selectFrList(membery);
                System.out.println(frList);
                model.addAttribute("frList", frList);
            }else if(content.equals("req")){
                System.out.println("요청목록 뽑기");
                List<Friendreq> frReqList = friendsService.selectReqList(membery);
                List<Friendreq> frRecList = friendsService.selectRecList(membery);
                model.addAttribute("frReqList", frReqList);
                model.addAttribute("frRecList", frRecList);
            }
        }
        return "friends";
    }

    //친구 찾기 Ajax
    @PostMapping("friends_searchFr")
    public @ResponseBody Membery friendsSearch(HttpSession session, String text){
        // 세션 내정보 불러오기
        Membery membery = (Membery)session.getAttribute("membery");

        // Email 또는 계좌번호로 찾으므로 두가지 경우의 수로 HashMap 구성하기
        HashMap<String, Object> searchFrMap = friendsService.forSearchFrMap(text);

        // 찾은 친구 가져오기
        Membery memberyFr = friendsService.searchFriend(searchFrMap);

        if(membery != null) {   // 나중에 로그인 전용 페이지로 구성하면 해당 if문 없애기
            // 찾은 친구가 나 자신일 때 체크
            if (membery.getMb_email().equals(memberyFr.getMb_email())) {
                memberyFr.setMb_seq(-1);
                return memberyFr;
            }
        }
        return memberyFr;
    }

    // 친구 추가 Ajax
    @PostMapping("friends_addFr")
    public @ResponseBody List friendsAdd(HttpServletResponse response, HttpSession session, String id){
        return null;
    }
}
