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
import web.util.Paging;

@WebServlet("/board/list")
public class BoardListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	BoardService boardService = new BoardServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		Paging paging = boardService.getPaging(req);
		
		//게시글 모두 불러오기
		List<Board> list= boardService.getList(paging);
		
		req.setAttribute("list", list);
		req.setAttribute("paging", paging);
		
				
		req.getRequestDispatcher("/WEB-INF/views/board/list.jsp").forward(req, resp);
	} 
}
