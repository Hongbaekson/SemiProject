package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Room;
import dto.RoomImg;
import service.face.HostService;
import service.face.MyRoomService;
import service.impl.HostServiceImpl;
import service.impl.MyRoomServiceImpl;

@WebServlet("/host/roomupdate")
public class MyRoomUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	MyRoomService myRoomService = new MyRoomServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("[test] MyRoomUpdateController [get] 요청");
		
		//전달 파라미터 정보 얻기 - roomno
		Room room = myRoomService.getRoomNo(req);
		
		//숙소정보 가져오기
		Room updateRoom = myRoomService.getRoom(room);
		System.out.println(updateRoom);
		//이미지 파일정보 가져오기
		List<RoomImg> imgList = myRoomService.getRoomImgList(room);
		
		//조회결과 view에 전달
		req.setAttribute("updateRoom", updateRoom);
		req.setAttribute("imgList", imgList);		
		
		req.getRequestDispatcher("/WEB-INF/views/host/update.jsp")
			.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("[test] MyRoomUpdateController [post] 요청");
		
		//==== [test]세션에 유저번호 저장 ====
//		HttpSession session = req.getSession();
//		session.setAttribute("userno", 1001);
		//=============================
		
		//숙소 수정하기
		int roomno = myRoomService.update(req);
		
		//숙소 상세보기로 보내기
		resp.sendRedirect("/host/roomview?roomno="+roomno);
	}
}
