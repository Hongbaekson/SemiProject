package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Board;
import service.face.BoardService;
import service.impl.BoardServiceImpl;

@WebServlet("/admin/board/list")
public class AdminBoardListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	BoardService boardService = new BoardServiceImpl();
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
				
		List<Board> list= boardService.getList();
		
		
		req.setAttribute("list", list);
		
		req.getRequestDispatcher("/WEB-INF/views/admin/boardlist.jsp").forward(req, resp);
	}
	
	
	
	
}
