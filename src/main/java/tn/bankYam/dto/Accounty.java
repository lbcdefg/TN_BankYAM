package tn.bankYam.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Accounty {
    private long ac_seq;
    private String ac_pwd;
    private long ac_mb_seq;
    private long ac_balance;
    private String ac_name;
    private String ac_main;
    private String ac_status;
    private long ac_pd_seq;
    private Date ac_odate;
    private Date ac_xdate;

    private Membery membery;
}
