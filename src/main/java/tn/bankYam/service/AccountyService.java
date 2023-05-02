package tn.bankYam.service;

import tn.bankYam.dto.Accounty;
import tn.bankYam.dto.Membery;
import tn.bankYam.dto.Product;
import tn.bankYam.dto.Transactions;

import java.util.HashMap;
import java.util.List;

public interface AccountyService {
    List<Accounty> selecAccDetailS(Membery membery);
    List<Accounty> selectAccNumS(long ac_seq);
    Accounty selectAccInfoS(long ac_seq);
    void getPaidS(Transactions transactions);
    void transferS(Transactions transactions);
    void  updateAcPwdCheckS(long ac_seq);
    void updateAcPwdWrongS(long ac_seq);
    List<Accounty>selectOtherAccNumS(long ac_seq);
    List<Accounty> findAccByMemberId(long ac_mb_seq);
    Product findPdBySeq(long seq);
    void insertAcc(HashMap<String, Object> map);
    List<String> findDepositPd();
    Product findDepositPdVal(String pd_name);
    List<Accounty> findAccounty();
    void interest(Accounty accounty);
    void insertPd(Product product);
    void updatePdXdate(Product product);
    List<Product> findPdByPdname();
    List<String> findPdtype();
    List<Product> findPdByPdtype(String pd_type);
    List<String> findSavingPd();
    List<Accounty> findSavingAcc();
    Accounty findMainAcc(long mb_seq);
    Accounty findMainOnlyAcc(long ac_mb_seq);
    void interestSavingAcc(Accounty accounty);
    List<Accounty> findAccListByMemberSeqS(long ac_mb_seq);
}
