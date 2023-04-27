package tn.bankYam.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Transactions {
    private long tr_seq;
    private long tr_ac_seq;
    private long tr_other_accnum;
    private String tr_other_bank;
    private String tr_type;
    private long tr_amount;
    private long tr_after_balance;
    private String tr_msg;
    private Date tr_date;
    private Accounty accounty;
    private Accounty otherAccount;
}
