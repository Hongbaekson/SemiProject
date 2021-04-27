package controller;

import java.io.IOException;

import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.impl.RestaurantBoardDaoImpl;
import dto.Restaurant;
import dto.Restaurantimg;
import service.face.RestaurantBoardService;
import service.impl.RestaurantBoardServiceImpl;



@WebServlet("/restaurant/detail")
public class RestaurantDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	//restauranteService 객체 생성
	private RestaurantBoardService restaurantService = new RestaurantBoardServiceImpl();
	private RestaurantBoardDaoImpl restaurantDao = new RestaurantBoardDaoImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("디테일 호출");
		
		//전달파라미터 얻기 - resno
				Restaurant Restaurantno = restaurantService.getRestaurantno(req); //이거랑
				int resno = restaurantService.getresno(req);
				
				List<Restaurantimg> resimgList = restaurantDao.selectImgList(resno);  
				
				System.out.println(resimgList);
				//상세보기 결과 조회
				Restaurant viewRestaurant = restaurantService.view(Restaurantno); 
				
				System.out.println(resimgList);
				//조회결과 MODEL값 전달
				req.setAttribute("viewRestaurant", viewRestaurant);
				
				req.setAttribute("resimgList", resimgList);
				
				//VIEW 지정 및 응답 - forward
				req.getRequestDispatcher("/WEB-INF/views/restaurant/detail.jsp")
				.forward(req, resp);
			}
			
		
	}

