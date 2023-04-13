package tn.bankYam.service;

import tn.bankYam.dto.Accounty;

public interface AccountyService {
    boolean checkAccnumS(long ac_seq);
    boolean checkPwdS(long ac_pwd);

    boolean checkStatusS(String ac_status);

    boolean checkPdS(long ac_pd_seq);
    boolean updateS(Accounty accounty);
}
