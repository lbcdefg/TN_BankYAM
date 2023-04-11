package tn.bankYam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tn.bankYam.dto.Membery;
import tn.bankYam.mapper.FriendsMapper;

@Service
public class FriendsServiceImpl implements FriendsService{

    @Autowired
    FriendsMapper friendsMapper;
    @Override
    public Membery searchFriend(String searchFrWord) {
        return friendsMapper.searchFriend(searchFrWord);
    }
}
