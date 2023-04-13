package tn.bankYam.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import tn.bankYam.dto.Accounty;

@Mapper
@Repository
public interface AccountyMapper {
    Accounty checkAccnum(long ac_seq);
    Accounty checkPwd(long ac_pwd);

    String checkStatus(String ac_status);

    int checkPd(long ac_pd_seq);
    boolean transfer(Accounty accounty);
}
