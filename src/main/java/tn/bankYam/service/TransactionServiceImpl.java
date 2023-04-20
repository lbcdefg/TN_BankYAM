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
    public List<Transactions> selectTrListS(Membery membery) {
        return mapper.selectTrList(membery);
    }
}
