package tn.bankYam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tn.bankYam.dto.*;
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
    public List<Accounty> searchFriend(HashMap<String, Object> hashMap) {
        return friendsMapper.searchFriend(hashMap);
    }

    @Override
    public List<Friend> selectFrList(Membery membery){
        return friendsMapper.selectFrList(membery);
    }

    @Override
    public HashMap<String, Object> forFrReq(long frId, long myId){
        HashMap<String, Object> forFrReqMap = new HashMap<>();
        forFrReqMap.put("frId", frId);
        forFrReqMap.put("myId", myId);
        return forFrReqMap;
    }

    @Override
    public Friendreq checkFrReq(HashMap<String, Object> hashMap){
        return friendsMapper.checkFrReq(hashMap);
    }

    @Override
    public void insertFrReq(HashMap<String, Object> hashMap){
        friendsMapper.insertFrReq(hashMap);
    }

    @Override
    public List<Friendreq> selectReqList(Membery membery){
        return friendsMapper.selectReqList(membery);
    }

    @Override
    public List<Friendreq> selectRecList(Membery membery){
        return friendsMapper.selectRecList(membery);
    }

    @Override
    public List<Blocklist> selectBlList(Membery membery){
        return friendsMapper.selectBlList(membery);
    }
}
