package tn.bankYam.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import tn.bankYam.dto.Accounty;
import tn.bankYam.dto.Product;

import java.util.HashMap;
import java.util.List;

@Mapper
@Repository
public interface AccountyMapper {
    List<Accounty> selectAccNum(long ac_seq);
    Accounty selectAccInfo(long ac_seq);
    void transfer(Accounty accounty);
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
    List<Product> findPdByPdname();
    List<String> findPdtype();
    List<Product> findPdByPdtype(String pd_type);
}
