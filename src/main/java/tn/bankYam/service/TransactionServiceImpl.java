package tn.bankYam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tn.bankYam.dto.Membery;
import tn.bankYam.dto.Transactions;
import tn.bankYam.mapper.TransactionsMapper;

import java.util.List;

@Service
public class TransactionServiceImpl implements TransactionService{
    @Autowired
    TransactionsMapper mapper;

    @Override
    public void insertTrLog(Transactions transactions) {
        mapper.insertTrLog(transactions);
    }

    @Override
    public List<Transactions> selectTrListS(Transactions transactions) {
        return mapper.selectTrList(transactions);
    }

    @Override
    public void selectTestS(long tr_ac_seq) {
        mapper.selectTest(tr_ac_seq);
    }

    // Transactions update를 위한 Transactions set 기능 no mapper
    @Override
    public Transactions setTransactions(long tr_ac_seq, long tr_other_accnum, String tr_other_bank, String tr_type, long tr_amount, long tr_after_balance, String tr_msg){
        Transactions transactions = new Transactions();
        transactions.setTr_ac_seq(tr_ac_seq);
        transactions.setTr_other_accnum(tr_other_accnum);
        transactions.setTr_other_bank(tr_other_bank);
        transactions.setTr_type(tr_type);
        transactions.setTr_amount(tr_amount);
        transactions.setTr_after_balance(tr_after_balance);
        transactions.setTr_msg(tr_msg);
        return transactions;
    }
}
