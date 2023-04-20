package tn.bankYam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tn.bankYam.dto.Accounty;
import tn.bankYam.dto.Membery;
import tn.bankYam.mapper.AccountManageMapper;

import java.util.HashMap;
import java.util.List;

@Service
public class AccountManageServiceImpl implements AccountManageService{

    @Autowired
    private AccountManageMapper accountManageMapper;

    @Override
    public List<Accounty> selectAcList(Membery membery){
        return accountManageMapper.selectAcList(membery);
    }

    @Override
    public List<Accounty> selectAcXList(Membery membery){
        return accountManageMapper.selectAcXList(membery);
    }

    @Override
    public HashMap<String, Object> forMapIdId(long acId, long myId){
        HashMap<String, Object> forAcMap = new HashMap<>();
        forAcMap.put("acId", acId);
        forAcMap.put("myId", myId);
        return forAcMap;
    }

    @Override
    public List<Accounty> checkAcBeforeMain(long mb_seq){
        return accountManageMapper.checkAcBeforeMain(mb_seq);
    }

    @Override
    public Accounty checkAc(HashMap<String, Object> hashMap){
        return accountManageMapper.checkAc(hashMap);
    }

    @Override
    public void updateAcNewMain(Accounty accounty){
        accountManageMapper.updateAcNewMain(accounty);
    }

    @Override
    public void updateAcBeforeMain(Accounty accounty){
        accountManageMapper.updateAcBeforeMain(accounty);
    }

    @Override
    public void updateAcName(Accounty accounty){
        accountManageMapper.updateAcName(accounty);
    }
}
