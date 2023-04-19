package tn.bankYam.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Chatroom {
    private long cr_seq;
    private String cr_name;
    private Date cr_rdate;
    private Date cr_udate;
    private long status_count;

    private Chatcontent chatcontent;
    private List<Membery> memberyList;
}
