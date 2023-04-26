package tn.bankYam.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import tn.bankYam.dto.Accounty;
import tn.bankYam.dto.Membery;

import java.util.HashMap;
import java.util.List;

@Mapper
@Repository
public interface AccountManageMapper {
    List<Accounty> selectAcList(Membery membery);

    List<Accounty> selectAcXList(Membery membery);

    List<Accounty> checkAcBeforeMain(long mb_seq);

    Accounty checkAc(HashMap<String, Object> hashMap);

    void updateAcNewMain(Accounty accounty);

    void updateAcBeforeMain(Accounty accounty);

    void updateAcName(Accounty accounty);

    Accounty checkAcOnly(long ac_seq);

    void updateAcStatus(HashMap<String, Object> hashMap);

    void updateAcPwdCheck(long ac_seq);

    void updateAcPwdWrong(long ac_seq);

    void updateAcPs(Accounty accounty);

    List<Accounty> myAllAcBySeq(long mb_seq);

    void insertAc(Accounty accounty);

    void updateAcBalance(HashMap<String, Object> hashMap);

    void deleteAc(long ac_seq);
}
