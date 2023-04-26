package tn.bankYam.service;

import tn.bankYam.dto.Accounty;
import tn.bankYam.dto.Membery;
import tn.bankYam.dto.Product;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;

public interface AccountManageService {

    List<Accounty> selectAcList(Membery membery);

    List<Accounty> selectAcXList(Membery membery);

    HashMap<String, Object> forMapIdId(long acId, long myId);

    List<Accounty> checkAcBeforeMain(long mb_seq);

    Accounty checkAc(HashMap<String, Object> hashMap);

    void updateAcNewMain(Accounty accounty);

    void updateAcBeforeMain(Accounty accounty);

    void updateAcName(Accounty accounty);

    Accounty checkPs(long ac_seq);

    void updateAcPwdCheck(long ac_seq);

    void updateAcPwdWrong(long ac_seq);

    void updateAcPs(Accounty accounty);

    // 이자일 용 리스트 만들기
    List<Object> getDMY();

    List<Accounty> myAllAcBySeq(long mb_seq);

    // 상품 이름들 리스트 만들기
    List<Product> forRecentPdList();

    // 계좌별칭 용 리스트 만들기
    List<String> forAcNames(List<Accounty> allAc, String pdName);

    // 날짜 재편집
    Date modifyData(String dateStr);

    void insertAc(Accounty accounty);
}
