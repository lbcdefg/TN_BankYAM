package tn.bankYam.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Membery {
    private long mb_seq;
    private String mb_email;
    private String mb_pwd;
    private String mb_name;
    private String mb_addr;
    private String mb_daddr;
    private String mb_phone;
    private String mb_job;
    private long mb_salary;
    private long mb_credit;
    private String mb_imagepath;
    private Date mb_rdate;
    private Date mb_wdate;
}
