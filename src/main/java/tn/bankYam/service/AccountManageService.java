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

    // Mybatis 넣어줄 맵 만들기(계좌Seq, 내Seq) no mapper
    HashMap<String, Object> forMapIdId(long ac_seq, long mb_seq);

    List<Accounty> checkAcBeforeMain(long mb_seq);

    Accounty checkAc(HashMap<String, Object> hashMap);

    void updateAcNewMain(Accounty accounty);

    void updateAcBeforeMain(Accounty accounty);

    void updateAcName(Accounty accounty);

    Accounty checkAcOnly(long ac_seq);

    // Mybatis 넣어줄 맵 만들기(계좌Seq, 계좌상태) no mapper
    HashMap<String, Object> forMapIdSt(long ac_seq, String status);

    void updateAcStatus(HashMap<String, Object> hashMap);

    void updateAcPwdCheck(long ac_seq);

    void updateAcPwdWrong(long ac_seq);

    void updateAcPs(Accounty accounty);

    // 이자일 용 리스트 만들기 no mapper
    List<Object> getDMY();

    List<Accounty> myAllAcBySeq(long mb_seq);

    // 가장 최근 금리 적용된 예금상품 이름들 가져올 리스트 no mapper
    List<Product> forRecentPdList();

    // 가장 최근 금리 적용된 적금상품 이름들 가져올 리스트 no mapper
    List<Product> forRecentPdList2();

    // Select된 상품 이름 받아서 (새 별칭명 + 기존 별칭명들) 담은 리스트 no mapper
    List<String> forAcNames(List<Accounty> allAc, String pdName);

    // 날짜 재편집(<String>yyyy-(m)m-(d)d -> <sql.Date>yyyy-mm-dd) no mapper
    Date modifyData(String dateStr);

    void insertAc(Accounty accounty);

    // Mybatis 넣어줄 맵 만들기(계좌Seq, 금액) no mapper
    HashMap<String, Object> forMapIdL(long ac_seq, Long amount);

    void updateAcBalance(HashMap<String, Object> hashMap);

    void deleteAc(long ac_seq);
}
