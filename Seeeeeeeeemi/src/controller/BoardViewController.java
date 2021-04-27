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

@WebServlet("/board/view")
public class BoardViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	BoardService boardService = new BoardServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//파라미터 처리 
		Board board = boardService.getParam(req);
		//boardno가지고 view 가져오기 
		Board viewBoard = boardService.getView(board);
		
		req.setAttribute("viewBoard", viewBoard);
		req.getRequestDispatcher("/WEB-INF/views/board/view.jsp").forward(req, resp);
	}
	
	
}
