package tn.bankYam.mapper;

import org.apache.ibatis.annotations.Mapper;
import tn.bankYam.dto.Friend;
import tn.bankYam.dto.Friendreq;
import tn.bankYam.dto.Membery;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface FriendsMapper {

    Membery searchFriend(HashMap<String, Object> hashMap);

    List<Friend> selectFrList(Membery membery);

    List<Friendreq> selectReqList(Membery membery);

    List<Friendreq> selectRecList(Membery membery);
}
