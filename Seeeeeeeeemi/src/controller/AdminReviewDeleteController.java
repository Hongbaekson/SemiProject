package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Review;
import service.face.AdminsService;
import service.impl.AdminsServiceImpl;


@WebServlet("/admin/review/delete")
public class AdminReviewDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	AdminsService adminsService = new AdminsServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		
		//파라미터 처리
		Review review = adminsService.getParamReview(req);
		int res = adminsService.deleteReview(review);
		if(res>0) {
			out.println("<script>alert('리뷰삭제성공!'); location.href='/admin/review/list'; </script>");
			out.close();
		}else {
			out.print("<script>alert('리뷰삭제실패!!!!'); location.href='/admin/review/list'; </script>");
			out.close();
		}
		
		
		
	}
    

}
