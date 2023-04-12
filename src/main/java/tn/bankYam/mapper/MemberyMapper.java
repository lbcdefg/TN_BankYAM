package tn.bankYam.mapper;

import org.apache.ibatis.annotations.Mapper;
import tn.bankYam.dto.Membery;

@Mapper
public interface MemberyMapper {
	Membery findByEmail(String mb_email);
}
