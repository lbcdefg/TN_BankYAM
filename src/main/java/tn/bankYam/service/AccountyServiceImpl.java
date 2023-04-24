package tn.bankYam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import tn.bankYam.dto.Accounty;
import tn.bankYam.dto.Product;
import tn.bankYam.mapper.AccountyMapper;

import java.util.List;

@Service
public class AccountyServiceImpl implements AccountyService{
    @Autowired
    AccountyMapper mapper;

    @Override
    public List<Accounty> selectAccNumS(long ac_seq) {
        return mapper.selectAccNum(ac_seq);
    }

    @Override
    public Accounty selectAccInfoS(String ac_pwd) {
        return mapper.selectAccInfo(ac_pwd);
    }

    @Override
    public void transferS(Accounty accounty) {
        mapper.transfer(accounty);
    }

    @Override
    public List<Accounty> findAccByMemberId(long ac_mb_seq) {
        return mapper.findAccByMemberId(ac_mb_seq);
    }

    @Override
    public Product findPdBySeq(long seq){

        return mapper.findPdBySeq(seq);
    }
    @Override
    public void insertAcc(Accounty accounty){
        mapper.insertAcc(accounty);
    }
}
