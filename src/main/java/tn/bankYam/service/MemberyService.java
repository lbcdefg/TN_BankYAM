package tn.bankYam.service;

import tn.bankYam.dto.Membery;

public interface MemberyService {
	Membery findByEmailS(String mb_email);
	void editProfile(Membery membery);
	void joinMembery(Membery membery);
}
