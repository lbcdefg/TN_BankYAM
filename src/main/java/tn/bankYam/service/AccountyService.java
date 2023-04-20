package tn.bankYam.service;

import tn.bankYam.dto.Accounty;
import tn.bankYam.dto.Product;

import java.util.List;

public interface AccountyService {
    boolean checkAccnumS(long ac_seq);
    boolean checkPwdS(String ac_pwd);

    boolean checkStatusS(String ac_status);

    boolean checkPdS(long ac_pd_seq);
    boolean updateS(Accounty accounty);
    List<Accounty> findAccByMemberId(long ac_mb_seq);
    Product findPdBySeq(long seq);
}
