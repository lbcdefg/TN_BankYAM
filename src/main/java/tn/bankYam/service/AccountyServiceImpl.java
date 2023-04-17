package tn.bankYam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tn.bankYam.dto.Accounty;
import tn.bankYam.mapper.AccountyMapper;

import java.util.List;

@Service
public class AccountyServiceImpl implements AccountyService{
    @Autowired
    AccountyMapper mapper;

    @Override
    public boolean checkAccnumS(long ac_seq) {
        if(mapper.checkAccnum(ac_seq)!=null){
            System.out.println("�����ϴ� �����Դϴ�.");
            return true;
        }else{
            System.out.println("�������� �ʴ� �����Դϴ�.");
            return false;
        }
    }

    @Override
    public boolean checkPwdS(long ac_pwd) {
        if(mapper.checkPwd(ac_pwd) !=null){
            System.out.println("��й�ȣ�� ��ġ�մϴ�");
            return true;
        }else {
            System.out.println("��й�ȣ�� ��ġ���� �ʽ��ϴ�");
            return false;
        }
    }

    @Override
    public boolean checkStatusS(String ac_status) {
        if(mapper.checkStatus(ac_status)=="�����"){
            return true;
        }else if(mapper.checkStatus(ac_status)=="�޸�"){
            System.out.println("�޸�����Դϴ�");
            return false;
        }else {
            System.out.println("������ �����Դϴ�");
            return false;
        }
    }

    @Override
    public boolean checkPdS(long ac_pd_seq) {
        if(mapper.checkPd(ac_pd_seq)==1){
            return true;
        }else{
            System.out.println("���ݰ��°� �ƴմϴ�");
            return false; 
        }
    }

    @Override
    public boolean updateS(Accounty accounty) {

        mapper.transfer(accounty);
        return false;
    }

    @Override
    public List<Accounty> findAccByMemberId(long ac_mb_seq) {
        return mapper.findAccByMemberId(ac_mb_seq);
    }
}
