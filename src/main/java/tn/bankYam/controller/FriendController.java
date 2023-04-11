package tn.bankYam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import tn.bankYam.dto.Membery;
import tn.bankYam.service.FriendsService;

@Controller
@RequestMapping("friend")
public class FriendController {

    @Autowired
    private FriendsService friendsService;

    @GetMapping("friends")
    public String friends(){
        return "friends";
    }

    @PostMapping("friends_searchFr")
    public @ResponseBody Membery friendsSearch(String text){
        System.out.println(text);
        Membery membery = friendsService.searchFriend(text);
        return membery;
    }
}
