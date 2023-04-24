package tn.bankYam.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Chatstatus {
    private long cs_cc_seq;
    private long cs_mb_seq;
    private Date cs_read;

    private Membery membery;
    private Chatcontent chatcontent;
}
