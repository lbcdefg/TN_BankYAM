package tn.bankYam.service;

import tn.bankYam.dto.*;

import java.util.HashMap;
import java.util.List;

public interface FriendsService {

    HashMap<String, Object> forSearchFrMap(String text);

    List<Accounty> searchFriend(HashMap<String, Object> hashMap);

    List<Friend> selectFrList(Membery membery);

    HashMap<String, Object> forFrReq(long id, long myId);

    Friendreq checkFrReq(HashMap<String, Object> hashMap);

    void insertFrReq(HashMap<String, Object> hashMap);

    List<Friendreq> selectReqList(Membery membery);

    List<Friendreq> selectRecList(Membery membery);

    List<Blocklist> selectBlList(Membery membery);
}
