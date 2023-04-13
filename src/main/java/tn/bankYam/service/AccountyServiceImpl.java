package tn.bankYam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tn.bankYam.dto.Accounty;
import tn.bankYam.mapper.AccountyMapper;

@Service
public class AccountyServiceImpl implements AccountyService{
    @Autowired
    AccountyMapper mapper;

    @Override
    public boolean checkAccnumS(long ac_seq) {
        if(mapper.checkAccnum(ac_seq)!=null){
            System.out.println("존재하는 계좌입니다.");
            return true;
        }else{
            System.out.println("존재하지 않는 계좌입니다.");
            return false;
        }
    }

    @Override
    public boolean checkPwdS(long ac_pwd) {
        if(mapper.checkPwd(ac_pwd) !=null){
            System.out.println("비밀번호가 일치합니다");
            return true;
        }else {
            System.out.println("비밀번호가 일치하지 않습니다");
            return false;
        }
    }

    @Override
    public boolean checkStatusS(String ac_status) {
        if(mapper.checkStatus(ac_status)=="사용중"){
            return true;
        }else if(mapper.checkStatus(ac_status)=="휴면"){
            System.out.println("휴면계좌입니다");
            return false;
        }else {
            System.out.println("해지된 계좌입니다");
            return false;
        }
    }

    @Override
    public boolean checkPdS(long ac_pd_seq) {
        if(mapper.checkPd(ac_pd_seq)==1){
            return true;
        }else{
            System.out.println("예금계좌가 아닙니다");
            return false; 
        }
    }

    @Override
    public boolean updateS(Accounty accounty) {

        mapper.transfer(accounty);
        return false;
    }
}
