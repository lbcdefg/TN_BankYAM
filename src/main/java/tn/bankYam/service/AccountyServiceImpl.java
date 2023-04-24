package tn.bankYam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tn.bankYam.dto.Accounty;
import tn.bankYam.dto.Product;
import tn.bankYam.mapper.AccountyMapper;

import java.util.HashMap;
import java.util.List;

@Service
public class AccountyServiceImpl implements AccountyService{
    @Autowired
    AccountyMapper mapper;

    @Override
    public boolean checkAccnumS(long ac_seq) {
        if(mapper.checkAccnum(ac_seq)!=null){
            System.out.println("");
            return true;
        }else{
            System.out.println("");
            return false;
        }
    }

    @Override
    public boolean checkPwdS(String ac_pwd) {
        if(mapper.checkPwd(ac_pwd) !=null){
            System.out.println("");
            return true;
        }else {
            System.out.println("");
            return false;
        }
    }

    @Override
    public boolean checkStatusS(String ac_status) {
        if(mapper.checkStatus(ac_status)=="사용중"){
            return true;
        }else if(mapper.checkStatus(ac_status)=="해지"){
            System.out.println("");
            return false;
        }else {
            System.out.println("");
            return false;
        }
    }

    @Override
    public boolean checkPdS(long ac_pd_seq) {
        if(mapper.checkPd(ac_pd_seq)==1){
            return true;
        }else{
            System.out.println("");
            return false; 
        }
    }

    @Override
    public boolean transferS(Accounty accounty) {
        if(checkAccnumS(accounty.getAc_seq()) && checkPwdS(accounty.getAc_pwd()) && checkStatusS(accounty.getAc_status())&&checkPdS(accounty.getAc_pd_seq()))
            return mapper.transfer(accounty);
        else {
            return false;
        }
    }

    @Override
    public List<Accounty> findAccByMemberId(long ac_mb_seq) {
        return mapper.findAccByMemberId(ac_mb_seq);
    }

    @Override
    public Product findPdBySeq(long seq){
        return mapper.findPdBySeq(seq);
    }
    @Override
    public void insertAcc(HashMap<String, Object> map){
        mapper.insertAcc(map);
    }
    @Override
    public List<String> findDepositPd(){
        return mapper.findDepositPd();
    }
    @Override
    public Product findDepositPdVal(String pd_name){
        return mapper.findDepositPdVal(pd_name);
    }

    @Override
    public List<Accounty> findAccounty() {
        return mapper.findAccounty();
    }

    @Override
    public Product recentPd() {
        return mapper.findRecentPd();
    }
}
