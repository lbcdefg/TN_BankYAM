package tn.bankYam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import tn.bankYam.dto.Membery;
import tn.bankYam.mapper.MemberyMapper;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@Service
public class MemberServiceImpl implements MemberyService{
	@Value("${file.dir}")
	private String fileDir;
	@Autowired
	private MemberyMapper memberyMapper;

	@Override
	public Membery findByEmailS(String mb_email) {
		return memberyMapper.findByEmail(mb_email);
	}

	@Override
	public Membery findBySeq(Long mb_seq) {
		return memberyMapper.findBySeq(mb_seq);
	}


	@Override
	public void editProfile(Membery membery) {
		memberyMapper.editProfile(membery);
	}

	@Override
	public void joinMembery(Membery membery){
		memberyMapper.joinMembery(membery);
  }
	public void updateImagepath(MultipartFile file, Membery membery) throws IOException {
		String origName = file.getOriginalFilename(); // 원래 파일 이름 추출
		String uuid = UUID.randomUUID().toString(); // 파일 이름으로 쓸 uuid 생성
		String extension = origName.substring(origName.lastIndexOf(".")); // 확장자 추출(ex : .png)
		String savedName = uuid + extension; // uuid와 확장자 결합
		String savedPath = fileDir + savedName; // 파일을 불러올 때 사용할 파일 경로
		System.out.println(savedPath);

		file.transferTo(new File(savedPath));
		membery.setMb_imagepath(savedPath);
		memberyMapper.updateImagepath(membery);
	}
}
