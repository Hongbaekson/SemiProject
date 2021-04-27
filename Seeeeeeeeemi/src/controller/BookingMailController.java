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

import util.BookingMailAuth;

@WebServlet("/booking/mail")
public class BookingMailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		System.out.println("hostEmail : " + req.getParameter("hostEmail"));
		System.out.println("hostName : "+ req.getParameter("hostName"));
		System.out.println("guestEmail : "+ req.getParameter("guestEmail"));
		System.out.println("subject : "+ req.getParameter("subject"));
		System.out.println("content : "+ req.getParameter("content"));


		// FROM
		final String FROM = req.getParameter("hostEmail"); // <<------------------------------수정하세요
		final String FROMNAME = req.getParameter("hostName"); // <<------------------------------수정하세요
		// TO final 
		String TO = req.getParameter("guestEmail"); // <<------------------------------수정하세요

		// 메일 제목
		final String SUBJECT = req.getParameter("subject"); //  <<------------------------------수정하세요

		// 메일 본문
		final String BODY = req.getParameter("content"); //  <<------------------------------수정하세요

		// 인증 객체
		Authenticator auth = new BookingMailAuth("mailboxdlqslek", "dzinjpijicibxsvj"); //  <<------------------------------수정하세요




		// 연결 설정 
		Properties props = System.getProperties();
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "587");

		// 메일 세션 객체 생성
		Session session = Session.getDefaultInstance(props, auth);
		System.out.println("test internetaddress : " + new InternetAddress(FROM, FROMNAME));
		// 메시지 생성
		MimeMessage msg = new MimeMessage(session); 
		try {
//			msg.setFrom(new InternetAddress(FROMNAME + "<"+FROM+">"));
			msg.setFrom(new InternetAddress(FROM, FROMNAME));
			msg.setRecipient(Message.RecipientType.TO, new InternetAddress(TO));
			msg.setSubject(SUBJECT); 
			msg.setContent(BODY, "text/html;charset=utf-8");

			System.out.println("Sending...");

			//메시지 보내기
			Transport.send(msg);

			System.out.println("Email sent!");

		} catch (NoSuchProviderException e) { 
			e.printStackTrace();

		} catch (MessagingException e) { 
			e.printStackTrace();

			System.out.println("The email was not sent.");
			System.out.println("Error message: " + e.getMessage());
			return;
		}

		resp.setContentType("text/html; charset=UTF-8");
		resp.setCharacterEncoding("utf-8");
		resp.getWriter()
		.append("<script>")
		.append("alert('메일이 전송되었습니다.');")
		.append("location.href = '/host/booking?curPage=" + req.getParameter("curPage")+"';")
		.append("</script>");
		//resp.sendRedirect("/host/booking?curPage=" + req.getParameter("curPage"));
	}
}
