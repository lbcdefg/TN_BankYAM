package tn.bankYam.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Chatcontent {
    private long cc_seq;
    private long cc_cr_seq;
    private long cc_mb_seq;
    private long cc_cf_seq;
    private String cc_content;
    private Date cc_rdate;
    private String cc_rdate_day;
    private String cc_rdate_time;
    private long cc_status_count;

    private Chatroom chatroom;
    private Membery membery;
    private Chatfile chatfile;
}
