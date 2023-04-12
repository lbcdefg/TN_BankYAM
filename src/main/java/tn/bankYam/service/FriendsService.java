package tn.bankYam.service;

import tn.bankYam.dto.Membery;

import java.util.HashMap;

public interface FriendsService {

    HashMap<String, Object> forSearchFrMap(String text);
    Membery searchFriend(HashMap<String, Object> hashMap);
}
