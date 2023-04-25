package tn.bankYam.service;

import tn.bankYam.dto.Membery;
import tn.bankYam.dto.Transactions;

import java.util.List;

public interface TransactionService {
    void insertTrLog(Transactions transactions);
    List<Transactions> selectTrListS(Membery membery);
}
