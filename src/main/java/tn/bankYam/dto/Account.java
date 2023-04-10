package tn.bankYam.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Account {
    private long ac_seq;
    private String ac_pwd;
    private long ac_mb_seq;
    private Long ac_balance;
    private String ac_name;
    private String ac_main;
    private String ac_type;
    private String ac_status;
    private float ac_rate;
    private Date ac_odate;
    private Date ac_xdate;
}
