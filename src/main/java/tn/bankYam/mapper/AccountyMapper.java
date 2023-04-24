package tn.bankYam.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import tn.bankYam.dto.Accounty;
import tn.bankYam.dto.Product;

import java.util.List;

@Mapper
@Repository
public interface AccountyMapper {
    List<Accounty> selectAccNum(long ac_seq);
    Accounty selectAccInfo(String ac_pwd);
    void transfer(Accounty accounty);
    List<Accounty> findAccByMemberId(long ac_mb_seq);
    Product findPdBySeq(long seq);
    void insertAcc(Accounty accounty);
}
