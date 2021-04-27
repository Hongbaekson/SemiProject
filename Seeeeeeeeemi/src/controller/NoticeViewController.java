package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Board;
import service.face.BoardService;
import service.impl.BoardServiceImpl;

@WebServlet("/notice/view")
public class NoticeViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	BoardService boardService = new BoardServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//파라미터처리
		Board board= boardService.getParam(req);
		//상세보기
		Board viewBoard = boardService.getView(board);
		
		req.setAttribute("viewBoard", viewBoard);
		
		req.getRequestDispatcher("/WEB-INF/views/notice/view.jsp").forward(req, resp);
		
	}
	
	
}
