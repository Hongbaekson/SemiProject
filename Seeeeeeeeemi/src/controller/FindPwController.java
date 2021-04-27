package controller;

import java.io.IOException;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;
import service.face.UserService;
import service.impl.UserServiceImpl;
import web.util.MailAuth;


@WebServlet("/find/pw")
public class FindPwController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	UserService userService = new UserServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/WEB-INF/views/member/findpw.jsp").forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		

		//파라미터처리
		User user = userService.getNameIdTelParam(req);
		
//		//일치하는 pw를 가져옴 
		User userpw = userService.getPw(user);

		
		//일치하는 행이 있는가 
		boolean isCorrect = userService.getCntPw(user);
		System.out.println(isCorrect);
		
		if(isCorrect) {
			// FROM
			final String FROM = "testk35hj7@gmail.com"; // <<------------------------------수정하세요
			final String FROMNAME = "기보람"; // <<------------------------------수정하세요

			// TO
			final String TO = userpw.getUserEmail(); // <<------------------------------수정하세요

			// 메일 제목
			final String SUBJECT = "비번 보내줌 "; // <<------------------------------수정하세요

			// 메일 본문
//			final String BODY = String.join(
//					"<h1>구글 SMTP Email Test</h1>",
//					"<p>javax.mail을 이용한 구글 smtp 이메일 전송 테스트</p>"
//			); // <<------------------------------수정하세요
			
			//객체
			String userpw2 = "비밀번호는 "+userpw.getUserPw()+"입니다";
			
			// 인증 객체
			Authenticator auth = new MailAuth("testk35hj7@gmail.com","1234!@#$QWER"); // <<------------------------------수정하세요

			
			// 연결 설정
			Properties props = System.getProperties();
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.port", "587");
			
			// 메일 세션 객체 생성
			Session session = Session.getDefaultInstance(props, auth);

			// 메시지 생성
			MimeMessage msg = new MimeMessage(session);
			try {
				msg.setFrom(new InternetAddress(FROM, FROMNAME));
				msg.setRecipient(Message.RecipientType.TO, new InternetAddress(TO));
				msg.setSubject(SUBJECT);
//				msg.setContent(BODY, "text/html;charset=utf-8");
				msg.setContent(userpw2, "text/html;charset=utf-8");
				
				System.out.println("Sending...");

				//메시지 보내기
				Transport.send(msg);
				
				System.out.println("Email sent!");
				req.getRequestDispatcher("/WEB-INF/views/member/findpwComplete.jsp").forward(req, resp);

			} catch (NoSuchProviderException e) {
				e.printStackTrace();
				
			} catch (MessagingException e) {
				e.printStackTrace();
				
				System.out.println("The email was not sent.");
				System.out.println("Error message: " + e.getMessage());
				
			}
			
		}else {
			resp.sendRedirect("/find/pw"); //다시찾기 
		}
		
	}
}
