package tn.bankYam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tn.bankYam.dto.Accounty;
import tn.bankYam.dto.Membery;
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
    public List<Accounty> selecAccDetailS(Membery membery) {
        return mapper.selecAccDetail(membery);
    }

    @Override
    public List<Accounty> selectAccNumS(long ac_seq) {
        return mapper.selectAccNum(ac_seq);
    }

    @Override
    public Accounty selectAccInfoS(long ac_seq) {
        return mapper.selectAccInfo(ac_seq);
    }
    // 뱅크얌 -> 뱅크얌으로 입금받을 때
    @Override
    public void getPaidS(Transactions transactions) {
        if(transactions.getTr_other_bank().equals("뱅크얌")) {
            mapper.getPaid(transactions);
            transactions.setTr_type("입금");
            transactions.setTr_after_balance(mapper.selectAccInfo(transactions.getTr_other_accnum()).getAc_balance());
            //내계좌
            long tempMyAcc = transactions.getTr_ac_seq();
            //상대방계좌
            long tempOtherAcc = transactions.getTr_other_accnum();
            transactions.setTr_ac_seq(tempOtherAcc);
            transactions.setTr_other_accnum(tempMyAcc);
            transactionsMapper.insertTrLog(transactions);
        }
    }

    //뱅크얌 -> 뱅크얌 송금할 때
    @Override
    public void transferS(Transactions transactions) {
        if (transactions.getTr_after_balance() >= 0) {
            mapper.transfer(transactions);
            transactions.setTr_type("송금");
            transactionsMapper.insertTrLog(transactions);
        } else {
            System.out.println("잔액이 부족합니다.");
        }
    }

    @Override
    public void updateAcPwdCheckS(long ac_seq) {
        mapper.updateAcPwdCheck(ac_seq);
    }

    @Override
    public void updateAcPwdWrongS(long ac_seq) {
        mapper.updateAcPwdWrong(ac_seq);
    }

    @Override
    public List<Accounty> selectOtherAccNumS(long ac_seq) {
        System.out.println("selectOtherAccNumS:"+mapper.selectOtherAccNum(ac_seq));
        return mapper.selectOtherAccNum(ac_seq);
    }

    @Override
    public List<Accounty> findAccByMemberId(long ac_mb_seq) {
        System.out.println( "findAccByMemberId:"+mapper.findAccByMemberId(ac_mb_seq));
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
    public void interest(Accounty accounty) {
        mapper.interest(accounty);
    }
    
    @Override
    public void insertPd(Product product){ mapper.insertPd(product);}
    
    @Override
    public void updatePdXdate(Product product){ mapper.updatePdXdate(product);}

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

    @Override
    public List<String> findSavingPd(){
        return mapper.findSavingPd();
    }
    @Override
    public List<Accounty> findSavingAcc() {
        return mapper.findSavingAcc();
    }
    @Override
    public Accounty findMainAcc(long mb_seq){ return mapper.findMainAcc(mb_seq);}

    @Override
    public Accounty findMainOnlyAcc(long ac_mb_seq) {
        return mapper.findMainOnlyAcc(ac_mb_seq);
    }

    @Override
    public void interestSavingAcc(Accounty accounty) {
        mapper.interestSavingAcc(accounty);
    }

    @Override
    public List<Accounty> findAccListByMemberSeqS(long ac_mb_seq) {
        return mapper.findAccListByMemberSeq(ac_mb_seq);
    }

}
