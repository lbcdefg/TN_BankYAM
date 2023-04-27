package tn.bankYam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tn.bankYam.dto.Accounty;
import tn.bankYam.dto.Product;
import tn.bankYam.dto.Transactions;
import tn.bankYam.mapper.AccountyMapper;
import tn.bankYam.mapper.TransactionsMapper;

import java.util.HashMap;
import java.util.List;

@Service
public class AccountyServiceImpl implements AccountyService{
    @Autowired
    AccountyMapper mapper;
    @Autowired
    TransactionsMapper transactionsMapper;

    @Override
    public List<Accounty> selectAccNumS(long ac_seq) {
        return mapper.selectAccNum(ac_seq);
    }

    @Override
    public Accounty selectAccInfoS(long ac_seq) {
        return mapper.selectAccInfo(ac_seq);
    }

    @Override
    public void transferPlusS(Transactions transactions) {
        if(!transactions.getTr_other_bank().equals("뱅크얌")) {
            transactions.setTr_type("입금");
            transactions.setTr_after_balance(0);
            //long tempMyAcc = transactions.getTr_ac_seq();
            //long tempOtherAcc = transactions.getTr_other_accnum();
            //transactions.setTr_ac_seq(tempOtherAcc);
            //transactions.setTr_other_accnum(tempMyAcc);
            //transactionsMapper.insertTrLog(transactions);
        }else{
            mapper.transferPlus(transactions);
            transactions.setTr_type("입금");
            transactions.setTr_after_balance(mapper.selectAccInfo(transactions.getTr_other_accnum()).getAc_balance());
            long tempMyAcc = transactions.getTr_ac_seq();
            long tempOtherAcc = transactions.getTr_other_accnum();
            transactions.setTr_ac_seq(tempOtherAcc);
            transactions.setTr_other_accnum(tempMyAcc);
            transactionsMapper.insertTrLog(transactions);
        }
    }

    @Override
    public void transferMinusS(Transactions transactions) {
        if (transactions.getTr_after_balance() >= 0) {
            mapper.transferMinus(transactions);

            transactions.setTr_type("송금");

            transactionsMapper.insertTrLog(transactions);

        } else {
            System.out.println("잔액이 부족합니다.");
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
    public void interest(Accounty accounty) {
        mapper.interest(accounty);
    }
    
    @Override
    public void insertPd(Product product){ mapper.insertPd(product);}
    
    @Override
    public void updatePdXdate(Product product){ mapper.updatePdXdate(product);}

    @Override
    public List<Product> test(HashMap<String,Object> map){ return mapper.test(map);}

    @Override
    public List<Product> findPdByPdname() {
        return mapper.findPdByPdname();
    }

    @Override
    public List<String> findPdtype() {
        return mapper.findPdtype();
    }

    @Override
    public List<Product> findPdByPdtype(String pd_type) {
        return mapper.findPdByPdtype(pd_type);
    }

}
