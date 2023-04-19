package tn.bankYam.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Chatmember {
    private long cm_cr_seq;
    private long cm_mb_seq;

    private Membery membery;
    private Chatroom chatroom;
}
