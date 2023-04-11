package tn.bankYam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tn.bankYam.mapper.MemberyMapper;

@Service
public class MemberServiceImpl {
	@Autowired
	private MemberyMapper memberyMapper;
}
