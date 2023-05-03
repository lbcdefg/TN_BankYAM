package tn.bankYam.service;

import org.springframework.web.multipart.MultipartFile;
import tn.bankYam.dto.Membery;

import java.io.IOException;
import java.util.HashMap;

public interface MemberyService {
	Membery findByEmailS(String mb_email);
	Membery findBySeq(Long mb_seq);
	void editProfile(Membery membery);
	void joinMembery(Membery membery);
	void updateImagepath(MultipartFile file, Membery membery) throws IOException;
	Membery findByPhone(String phone);
	void editPwd(HashMap<String, String> map);
	void deleteMember(long mb_seq);
}
