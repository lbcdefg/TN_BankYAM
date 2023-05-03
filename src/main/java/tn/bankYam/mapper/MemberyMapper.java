package tn.bankYam.mapper;

import org.apache.ibatis.annotations.Mapper;
import tn.bankYam.dto.Membery;

import java.util.HashMap;

@Mapper
public interface MemberyMapper {
	Membery findByEmail(String mb_email);
	void editProfile(Membery membery);
	void joinMembery(Membery membery);
  Membery findBySeq(Long mb_seq);
	void updateImagepath(Membery membery);
	Membery findByPhone(String phone);
	void editPwd(HashMap<String, String> map);

	void deleteMember(long mb_seq);
}
