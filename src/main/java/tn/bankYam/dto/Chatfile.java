package tn.bankYam.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Chatfile {
    private long cf_seq;
    private String cf_orgnm;
    private String cf_savednm;
    private String cf_savedpath;
    private long cf_size;
}
