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
    Accounty checkAccnum(long ac_seq);
    Accounty checkPwd(String ac_pwd);
    String checkStatus(String ac_status);
    int checkPd(long ac_pd_seq);
    boolean transfer(Accounty accounty);
    List<Accounty> findAccByMemberId(long ac_mb_seq);
    Product findPdBySeq(long seq);
    void insertAcc(HashMap<String, Object> map);
}
