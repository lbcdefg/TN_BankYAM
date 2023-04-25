package tn.bankYam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import tn.bankYam.dto.Accounty;
import tn.bankYam.dto.Product;
import tn.bankYam.mapper.AccountyMapper;

import java.util.HashMap;
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
    public Accounty selectAccInfoS(long ac_seq) {
        return mapper.selectAccInfo(ac_seq);
    }

    @Override
    public void transferS(Accounty accounty) {
        if(selectAccNumS(accounty.getAc_seq())!=null){
            mapper.transfer(accounty);
        }else {
            System.out.println("존재하지 않는 계좌입니다.");
            selectAccNumS(accounty.getAc_seq());
        }
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
    public void insertAcc(HashMap<String, Object> map){
        mapper.insertAcc(map);
    }
    @Override
    public List<String> findDepositPd(){
        return mapper.findDepositPd();
    }
    @Override
    public Product findDepositPdVal(String pd_name){
        return mapper.findDepositPdVal(pd_name);
    }

    @Override
    public List<Accounty> findAccounty() {
        return mapper.findAccounty();
    }

    @Override
    public Product recentPd() {
        return mapper.findRecentPd();
    }
    @Override
    public void insertPd(Product product){ mapper.insertPd(product);}
    @Override
    public void updatePdXdate(Product product){ mapper.updatePdXdate(product);}
}
