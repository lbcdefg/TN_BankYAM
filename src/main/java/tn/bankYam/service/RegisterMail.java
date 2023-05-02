package tn.bankYam.service;

import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import tn.bankYam.dto.Accounty;

@Service
public class RegisterMail{

    @Autowired
    JavaMailSender emailsender; // Bean 등록해둔 MailConfig 를 emailsender 라는 이름으로 autowired

    private String ePw; // 인증번호

    // 메일 내용 작성

    public MimeMessage createMessage(String to) throws MessagingException, UnsupportedEncodingException {
//		System.out.println("보내는 대상 : " + to);
//		System.out.println("인증 번호 : " + ePw);

        MimeMessage message = emailsender.createMimeMessage();

        message.addRecipients(RecipientType.TO, to);// 보내는 대상
        message.setSubject("BankYam 본인확인 이메일 인증");// 제목

        String msgg = "";
        msgg += "<div style='margin:100px;'>";
        msgg += "<h1> 안녕하세요</h1>";
        msgg += "<h1> SNS형 뱅킹서비스 BankYam 입니다</h1>";
        msgg += "<br>";
        msgg += "<p>창으로 돌아가 아래 코드를 입력해주세요<p>";
        msgg += "<br>";
        msgg += "<p>이미 모두의 은행, 지금은 뱅크얌. Thank You! <p>";
        msgg += "<br>";
        msgg += "<div align='center' style='border:1px solid black; font-family:verdana';>";
        msgg += "<h3 style='color:blue;'>본인 인증 코드입니다.</h3>";
        msgg += "<div style='font-size:130%'>";
        msgg += "CODE : <strong>";
        msgg += ePw + "</strong><div><br/> "; // 메일에 인증번호 넣기
        msgg += "</div>";
        message.setText(msgg, "utf-8", "html");// 내용, charset 타입, subtype
        // 보내는 사람의 이메일 주소, 보내는 사람 이름
        message.setFrom(new InternetAddress("bbaannkkyyaamm______@naver.com", "BankYam_Admin"));// 보내는 사람

        return message;
    }

    // 랜덤 인증 코드 전송

    public String createKey() {
        StringBuffer key = new StringBuffer();
        Random rnd = new Random();

        for (int i = 0; i < 8; i++) { // 인증코드 8자리
            int index = rnd.nextInt(3); // 0~2 까지 랜덤, rnd 값에 따라서 아래 switch 문이 실행됨

            switch (index) {
                case 0:
                    key.append((char) ((int) (rnd.nextInt(26)) + 97));
                    // a~z (ex. 1+97=98 => (char)98 = 'b')
                    break;
                case 1:
                    key.append((char) ((int) (rnd.nextInt(26)) + 65));
                    // A~Z
                    break;
                case 2:
                    key.append((rnd.nextInt(10)));
                    // 0~9
                    break;
            }
        }
        return key.toString();
    }

    // 메일 발송
    // sendSimpleMessage 의 매개변수로 들어온 to 는 곧 이메일 주소가 되고,
    // MimeMessage 객체 안에 내가 전송할 메일의 내용을 담는다.
    // 그리고 bean 으로 등록해둔 javaMail 객체를 사용해서 이메일 send!!

    public String sendSimpleMessage(String to) throws Exception {

        ePw = createKey(); // 랜덤 인증번호 생성

        MimeMessage message = createMessage(to); // 메일 발송
        try {// 예외처리
            emailsender.send(message);
        } catch (MailException es) {
            es.printStackTrace();
            throw new IllegalArgumentException();
        }
        return ePw; // 메일로 보냈던 인증 코드를 서버로 반환
    }

    //방식은 위와 동일, 내용은 적금 만기해지알림
    public MimeMessage savingEndMessage(Accounty accounty, Accounty mainAcc) throws MessagingException, UnsupportedEncodingException {
        MimeMessage message = emailsender.createMimeMessage();
        DecimalFormat df = new DecimalFormat("###,###");
        long accAmount = (long)(accounty.getAc_balance()*((accounty.getProduct().getPd_rate()+accounty.getProduct().getPd_addrate())/100+1));
        String moneyVal = df.format(accAmount);

        message.addRecipients(RecipientType.TO, accounty.getMembery().getMb_email());
        message.setSubject("BankYam 적금상품 만기해지 알림");

        String msgg = "";
        msgg += "<div style='margin:100px;'>";
        msgg += "<h1> 안녕하세요</h1>";
        msgg += "<h1> SNS형 뱅킹서비스 BankYam 입니다</h1>";
        msgg += "<br>";
        msgg += "<p>귀하의 적금상품 [ " + accounty.getAc_name() +" ]의 만기일이 도래하여 해지되었음을 알려드립니다<p>";
        msgg += "<br>";
        msgg += "<p> 총 "  + moneyVal +" 원의 금액이 <p>";
        msgg += "<br>";
        msgg += "<p>귀하의 주계좌인 [ " + mainAcc.getAc_seq() +" ] 계좌로 입금되었습니다<p>";
        msgg += "<br>";
        msgg += "<p>이용해 주셔서 감사합니다<p>";
        msgg += "<br>";
        msgg += "<p>이미 모두의 은행, 지금은 뱅크얌. Thank You! <p>";
        msgg += "</div>";
        message.setText(msgg, "utf-8", "html");

        message.setFrom(new InternetAddress("bbaannkkyyaamm______@naver.com", "BankYam_Admin"));
        return message;
    }

    public void savingEnd(Accounty accounty, Accounty mainAcc) throws Exception {
        MimeMessage message = savingEndMessage(accounty, mainAcc);
        try {
            emailsender.send(message);
        } catch (MailException es) {
            es.printStackTrace();
            throw new IllegalArgumentException();
        }
    }
}
