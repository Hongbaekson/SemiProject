package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.RoomImgReview;
import service.face.MainService;
import service.impl.MainServiceImpl;


@WebServlet("/main")
public class MainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	MainService mainService = new MainServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("메인");
		
//		//--------------------숙소추천------------------------
//		RoomImgReview room = mainService.getParam(req);
//		
//		List<RoomImgReview> list=mainService.getRoom(room);
//		
//		for(RoomImgReview r: list) {
//			System.out.println(r); 
//		}
//		System.out.println("-------------------------------------");
//		System.out.println("접속한동네  ; "+room.getRoomRoadAddress());

		//------------------인기순 숙소-------------------------
		List<RoomImgReview> poplist= mainService.getPopularRoom();
			
				
		//경로server.xml에서 바꿈 
//		req.setAttribute("list", list);
		req.setAttribute("poplist", poplist);
		req.getRequestDispatcher("/WEB-INF/views/main.jsp").forward(req, resp);
	}
	
	
	
}
