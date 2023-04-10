package tn.bankYam.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
//TRANSACTIONS TR_AC_SEQ 어카운트랑 연결되어있는데  타은행의 계좌번호를 넣읋수가 없어....
//만약에 당행에서 이체하면 TR_AC_SEQ에 데이터를 넣고 TR_OTHERS_ACCOUNT이걸 비울까?
//만약에 타행에서 이체하면 TR_OTHERS_ACCOUNT이걸 데이터 넣고 TR_AC_SEQ이걸 비우자
//type은 입금, 송금
public class Transactions {
    private long tr_seq;
    private long tr_ac_seq;
    private String tr_bank;
    private String tr_others_account;
    private long tr_amount;
    private long tr_after_balance;
    private String tr_type;
    private String tr_msg;
    private Date tr_date;
}
