package tn.bankYam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tn.bankYam.dto.Friend;
import tn.bankYam.dto.Friendreq;
import tn.bankYam.dto.Membery;
import tn.bankYam.mapper.FriendsMapper;

import java.util.HashMap;
import java.util.List;

@Service
public class FriendsServiceImpl implements FriendsService{

    @Autowired
    FriendsMapper friendsMapper;

    @Override
    public HashMap<String, Object> forSearchFrMap(String text){
        HashMap<String, Object> searchFrMap = new HashMap<>();
        if(text.contains("@")) {
            searchFrMap.put("email", text);
            searchFrMap.put("account", "empty");
        }else{
            searchFrMap.put("email", "empty");
            searchFrMap.put("account", text);
        }
        return searchFrMap;
    }

    @Override
    public Membery searchFriend(HashMap<String, Object> hashMap) {
        return friendsMapper.searchFriend(hashMap);
    }

    @Override
    public List<Friend> selectFrList(Membery membery){
        return friendsMapper.selectFrList(membery);
    }

    @Override
    public List<Friendreq> selectReqList(Membery membery){
        return friendsMapper.selectReqList(membery);
    }

    @Override
    public List<Friendreq> selectRecList(Membery membery){
        return friendsMapper.selectRecList(membery);
    }
}
