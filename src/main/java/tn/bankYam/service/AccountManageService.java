package tn.bankYam.service;

import tn.bankYam.dto.Accounty;
import tn.bankYam.dto.Membery;

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

    String checkPs(long ac_seq);
}
