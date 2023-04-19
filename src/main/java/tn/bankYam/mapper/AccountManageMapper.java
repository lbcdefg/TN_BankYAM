package tn.bankYam.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import tn.bankYam.dto.Accounty;
import tn.bankYam.dto.Membery;

import java.util.HashMap;
import java.util.List;

@Mapper
@Repository
public interface AccountManageMapper {
    List<Accounty> selectAcList(Membery membery);

    List<Accounty> checkAcBeforeMain(long mb_seq);

    Accounty checkAc(HashMap<String, Object> hashMap);
}
