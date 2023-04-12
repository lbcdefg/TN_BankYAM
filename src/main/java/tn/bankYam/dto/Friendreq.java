package tn.bankYam.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Friendreq {
    private long fr_seq;
    private long fr_req_mb_seq;
    private long fr_rec_mb_seq;
    private String fr_status;
    private Date fr_rdate;
    private Membery membery;
}
