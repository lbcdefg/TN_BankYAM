package tn.bankYam.service;

import tn.bankYam.dto.Accounty;
import tn.bankYam.dto.Product;

import java.util.HashMap;
import java.util.List;

public interface AccountyService {
    List<Accounty> selectAccNumS(long ac_seq);
    Accounty selectAccInfoS(long ac_seq);
    void transferS(Accounty accounty);
    List<Accounty> findAccByMemberId(long ac_mb_seq);
    Product findPdBySeq(long seq);
    void insertAcc(HashMap<String, Object> map);
    List<String> findDepositPd();
    Product findDepositPdVal(String pd_name);
    List<Accounty> findAccounty();
    Product recentPd();
    void interest(Accounty accounty);
    void insertPd(Product product);
    void updatePdXdate(Product product);
    List<Product> test(HashMap<String,Object> map);
}
