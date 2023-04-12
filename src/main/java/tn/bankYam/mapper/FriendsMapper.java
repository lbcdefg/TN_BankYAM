package tn.bankYam.mapper;

import org.apache.ibatis.annotations.Mapper;
import tn.bankYam.dto.Membery;

import java.util.HashMap;

@Mapper
public interface FriendsMapper {

    Membery searchFriend(HashMap<String, Object> hashMap);
}
