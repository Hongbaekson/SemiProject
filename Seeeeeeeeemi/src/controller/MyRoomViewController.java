package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Room;
import dto.RoomImg;
import service.face.MyRoomService;
import service.impl.MyRoomServiceImpl;

@WebServlet("/host/roomview")
public class MyRoomViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	MyRoomService myRoomService = new MyRoomServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("MyRoomViewController [GET] 요청");
		
		HttpSession session = req.getSession();
		if( session.getAttribute("login") == null ) {
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter script = resp.getWriter();
			script.println("<script>");
			script.println("alert('로그인 후 이용해주세요')");
			script.println("location.href='/main'");
			script.println("</script>");
			script.close();
			return;
		}
		Room room = myRoomService.getRoomNo(req);
		
		//숙소 정보 요청
		Room roomView = myRoomService.getRoom(room);
		//없는 숙소번호 처리
		if( roomView == null) {
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter script = resp.getWriter();
			script.println("<script>");
			script.println("alert('숙소가 없습니다.')");
			script.println("location.href='/main'");
			script.println("</script>");
			script.close();
			return;
		}
		//다른 호스트가 접근했을 경우
		if( (Integer)session.getAttribute("usergrade") != 0 ) {
			if( (Integer)session.getAttribute("userno") != roomView.getUserNo()) {
				resp.setContentType("text/html; charset=UTF-8");
				PrintWriter script = resp.getWriter();
				script.println("<script>");
				script.println("alert('잘못된 접근입니다.')");
				script.println("location.href='/host/roomlist'");
				script.println("</script>");
				script.close();
				return;
			}
		}
		
		//숙소 이미지 정보 요청
		List<RoomImg> roomImgList = myRoomService.getRoomImgList(room);
		
		//숙소 편의시설 정보 요청
		List<String> roomFacList = myRoomService.getRoomFacList(room);
		
		for(RoomImg r : roomImgList) {
			System.out.println(r);
		}
		req.setAttribute("roomView", roomView);
		req.setAttribute("roomImgList", roomImgList);
		req.setAttribute("roomFacList", roomFacList);
		req.getRequestDispatcher("/WEB-INF/views/host/roomView.jsp")
			.forward(req, resp);
		
		
	}
}
