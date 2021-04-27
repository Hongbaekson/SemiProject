package service.impl;

import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import common.JDBCTemplate;
import dao.face.AdminsDao;
import dao.impl.AdminsDaoImpl;
import dto.Board;
import dto.Review;
import dto.RoomImgReview;
import dto.User;
import service.face.AdminsService;

public class AdminsServiceImpl implements AdminsService {
	
	AdminsDao adminsDao = new AdminsDaoImpl();
	
	@Override
	public User getParamNo(HttpServletRequest req) {
		User user = new User();
		user.setUserNo( Integer.parseInt( req.getParameter("userno") )); 
		return user;
	}
	
	@Override
	public Boolean delete(User user) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int res = adminsDao.delete(conn, user);
		if(res>0) {
			JDBCTemplate.commit(conn);
			return true;
		}else {
			JDBCTemplate.rollback(conn);
			return false;
		}
	}
	
	@Override
	public User getInfo(HttpServletRequest req) {
		User user = new User();
		user.setUserId(req.getParameter("uid"));
		user.setUserName(req.getParameter("uname"));
		user.setUserNick(req.getParameter("unick"));
		user.setUserPw(req.getParameter("upw"));
		user.setUserGender(req.getParameter("ugender"));
		user.setUserBithdate(req.getParameter("ubirth"));
		user.setUserEmail(req.getParameter("uemail"));
		user.setUserPhone(req.getParameter("uphone"));
		user.setUserGrade(Integer.parseInt(req.getParameter("ugrade")));
		return user;
	}
	
	@Override
	public int insert(User user) {
		Connection conn = JDBCTemplate.getConnection();
		
		int res = adminsDao.insert(conn, user);
		if(res>0) {
			System.out.println("삽입성공");
			JDBCTemplate.commit(conn);
		}else {
			System.out.println("삽입실패");
			JDBCTemplate.rollback(conn);
		}
		
		return res;
	}
	
	@Override
	public void writeNotice(Board board) {
		Connection conn=JDBCTemplate.getConnection();
		int res = adminsDao.writeNotice(conn, board);
		
		if(res>0) {
			System.out.println("공지작성성공");
			JDBCTemplate.commit(conn);
		}else {
			System.out.println("공지작성실패");
			JDBCTemplate.rollback(conn);
		}
		
		
	}
	@Override
	public List<RoomImgReview> getAllReview() {
		return adminsDao.selectReview(JDBCTemplate.getConnection());
	}
	
	@Override
	public Review getParamReview(HttpServletRequest req) {
		Review review = new Review();
		review.setReNo( Integer.parseInt(req.getParameter("reviewno")));
		return review;
	}
	@Override
	public int deleteReview(Review review) {
		Connection conn = JDBCTemplate.getConnection();
		int res = adminsDao.deleteByReviewno(conn, review);
		if(res>0) {
			JDBCTemplate.commit(conn);
		}else {			
			JDBCTemplate.rollback(conn);
		}
		return res;
	}
	
}	
