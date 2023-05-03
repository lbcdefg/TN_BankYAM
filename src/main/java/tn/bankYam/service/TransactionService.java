package tn.bankYam.service;

import tn.bankYam.dto.Membery;
import tn.bankYam.dto.Transactions;

import java.util.List;

public interface TransactionService {
    void insertTrLog(Transactions transactions);
    List<Transactions> selectTrListS(Transactions transactions);

    void selectTestS(long tr_ac_seq);

    // Transactions update를 위한 Transactions set 기능 no mapper
    Transactions setTransactions(long tr_ac_seq, long tr_other_accnum, String tr_other_bank, String tr_type, long tr_ammount, long tr_after_balance, String tr_msg);
}
