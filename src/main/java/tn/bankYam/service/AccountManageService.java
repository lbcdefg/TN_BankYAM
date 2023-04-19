package tn.bankYam.service;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import tn.bankYam.dto.Accounty;
import tn.bankYam.dto.Membery;

import java.util.HashMap;
import java.util.List;

public interface AccountManageService {

    List<Accounty> selectAcList(Membery membery);

    HashMap<String, Object> forMapIdId(long acId, long myId);

    List<Accounty> checkAcBeforeMain(long mb_seq);

    Accounty checkAc(HashMap<String, Object> hashMap);
}
