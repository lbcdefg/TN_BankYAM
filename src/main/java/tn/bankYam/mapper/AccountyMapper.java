package tn.bankYam.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import tn.bankYam.dto.Accounty;
import tn.bankYam.dto.Membery;
import tn.bankYam.dto.Product;
import tn.bankYam.dto.Transactions;

import java.util.HashMap;
import java.util.List;

@Mapper
@Repository
public interface AccountyMapper {
    List<Accounty> selecAccDetail(Membery membery);
    List<Accounty> selectAccNum(long ac_seq);
    Accounty selectAccInfo(long ac_seq);
    void getPaid(Transactions transactions);
    void transfer(Transactions transactions);
    void  updateAcPwdCheck(long ac_seq);
    void updateAcPwdWrong(long ac_seq);
    List<Accounty>selectOtherAccNum(long ac_seq);
    List<Accounty> findAccByMemberId(long ac_mb_seq);
    Product findPdBySeq(long seq);
    void insertAcc(HashMap<String, Object> map);
    List<String> findDepositPd();
    Product findDepositPdVal(String pd_name);
    List<Accounty> findAccounty();
    Product findRecentPd();
    void interest(Accounty accounty);
    void insertPd(Product product);
    void updatePdXdate(Product product);
    List<Product> test(HashMap<String,Object> map);
    List<Product> findPdByPdname();
    List<String> findPdtype();
    List<Product> findPdByPdtype(String pd_type);
    List<String> findSavingPd();
    List<Accounty> findSavingAcc();
    Accounty findMainAcc(long mb_seq);
    Accounty findMainOnlyAcc(long ac_mb_seq);
    void interestSavingAcc(Accounty accounty);
    List<Accounty> findAccListByMemberSeq(long ac_mb_seq);
}
