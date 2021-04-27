package controller;

import java.io.IOException;
import java.io.PrintStream;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.face.RestaurantBoardDao;
import dao.impl.RestaurantBoardDaoImpl;
import dto.Restaurant;
import service.face.AdminRestaurantBoardService;
import service.face.RestaurantBoardService;
import service.impl.AdminRestaurantBoardServiceImpl;
import service.impl.RestaurantBoardServiceImpl;


@WebServlet("/admin/restaurantdelete")
public class AdminRestaurantDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private AdminRestaurantBoardService adminRestaurantBoardService = new AdminRestaurantBoardServiceImpl();

	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("델리트호출");
		
	//	String[] chBox = req.getParameterValues("chBox");
		
		String chBox = req.getParameter("resno"); //요거는 아까 체크박스 있었ㅇ르 때 우기님이 저번에
		//알려주신 걸로 한 번 해본 거엿어요...ㅠㅠ지금은 체크박스를 없애서 그냥 주석달았어
		
		System.out.println(chBox);
		
	//	List<Restaurant> deleteList = restaurantDao.deleteboardno(chBox);
		// 서버 재시작하고 뷰 페이지 켜서 삭제 한번 해볼래요?
		//근데 그 저거 코드 받은 분꺼 보니까 
		Restaurant restaurant = adminRestaurantBoardService.getParamNo(req);//여기줄이 에러네요 방금 제가 한것처럼 한줄씩 돌려서 어느부분에서 에러가 나는지 찾을줄 알아야해요
		//넵 넵...코드 가지고 와서 당연히 이건 아닌 줄 알았어요...주의할게욥...ㅠㅠ저거 서비스 쪽으로 다시 봐야하나여???
		adminRestaurantBoardService.delete(restaurant);
		
		
	//	req.setAttribute("restaurantList", deleteList); .....?? dele하는 뷰좀 보여주세요 여기가 어떤작업을 하려다가 주석처리한거에요?
		
		//이거 관리자 게시판 저랑 비슷하게 만드신느 분한테 코드 얻었어요! 그분이 
		
		//목록으로 리다이렉트
		resp.sendRedirect("/admin/restaurantlist");
		
	}

}
