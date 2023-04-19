package tn.bankYam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tn.bankYam.dto.Membery;
import tn.bankYam.mapper.MemberyMapper;

@Service
public class MemberServiceImpl implements MemberyService{
	@Autowired
	private MemberyMapper memberyMapper;

	@Override
	public Membery findByEmailS(String mb_email) {
		return memberyMapper.findByEmail(mb_email);
	}

	@Override
	public void editProfile(Membery membery) {
		memberyMapper.editProfile(membery);
	}

	@Override
	public void joinMembery(Membery membery){
		memberyMapper.joinMembery(membery);
	}
}
