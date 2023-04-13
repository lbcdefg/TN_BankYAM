package tn.bankYam.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Blocklist {
    private long bl_seq;
    private long bl_mb_seq;
    private long bl_bl_mb_seq;
    private Date bl_rdate;
    private Membery membery;
}
