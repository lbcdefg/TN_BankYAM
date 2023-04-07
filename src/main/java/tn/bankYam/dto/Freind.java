package tn.bankYam.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Freind {
    private long f_seq;
    private long f_mb_seq;
    private long f_f_mb_seq;
    private Date f_rdate;
}
