package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Room;
import service.face.MyRoomService;
import service.impl.MyRoomServiceImpl;

@WebServlet("/host/roomdelete")
public class MyRoomDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	MyRoomService myRoomService = new MyRoomServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("[test]MyRoomDeleteController [get] 요청");
		
		//요청 파라미터 -> Room 번호
		Room room = myRoomService.getRoomNo(req);
		
		myRoomService.delete(req, room);
		
		//숙소 리스트 페이지로 리다이렉트
		resp.sendRedirect("/host/roomlist");
	}
}
