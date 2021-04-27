package service.impl;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import common.JDBCTemplate;
import dao.face.MyPageDao;
import dao.impl.MyPageDaoImpl;
import dto.Booking;
import dto.User;
import service.face.MyPageService;
import util.MyPageBookingPaging;
import util.MyPageBookmarkPaging;
import util.MyPageReviewPaging;

public class MyPageServiceImpl implements MyPageService {

	MyPageDao myPageDao = new MyPageDaoImpl();
	

	@Override
	public User getUserid(HttpServletRequest req) {
		
		//로그인 세션에서 userid을 받아온다.
		String userid = (String)req.getSession().getAttribute("userid");
		
		User user = new User();
		
		user.setUserId(userid);
		
		return user;
	}


	@Override
	public User getUser(User userid) {
		
		User userInfo = myPageDao.selectUserInfo(userid);
		
		return userInfo;
	}


	@Override
	public User getParam(HttpServletRequest req) {
		
		User user = new User();
		
		String name = req.getParameter("username");
		String nick = req.getParameter("usernick");
		String email = req.getParameter("useremail1") + "@" + req.getParameter("useremail2");
		String phone = req.getParameter("userphone");
		String birth = req.getParameter("userbirth");
		String gender = req.getParameter("usergender");
		
		user.setUserName(name);
		user.setUserNick(nick);
		user.setUserEmail(email);
		user.setUserPhone(phone);
		user.setUserBithdate(birth);
		user.setUserGender(gender);
		
		return user;
	}


	@Override
	public void updateUser(HttpServletRequest req, User user) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		String id = (String) req.getSession().getAttribute("userid");
		user.setUserId(id);
		
		System.out.println(user);
		
		if(myPageDao.updateUser(conn, user) > 0) {
			JDBCTemplate.commit(conn);
//			System.out.println("커밋 완료");
		} else {
			JDBCTemplate.rollback(conn);
//			System.out.println("커밋 실패");
		}
		
	}


	@Override
	public boolean chkPw(HttpServletRequest req) {

		//현재 로그인된 userno를 가져온다.
		int userno = (int) req.getSession().getAttribute("userno");
		String curpw = req.getParameter("curpw");
		
		boolean chk = myPageDao.chkPw(curpw, userno);
		
		return chk;
		
	}


	@Override
	public void updateUserPw(HttpServletRequest req) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int userno = (int) req.getSession().getAttribute("userno");
		String newpw = req.getParameter("newpw");
		System.out.println(newpw);
		
		if( myPageDao.updateUserPw(userno, newpw, conn) > 0 ) {
			JDBCTemplate.commit(conn);
			System.out.println("커밋 완료");
		} else {
			JDBCTemplate.rollback(conn);
			System.out.println("커밋 실패");
		}
		
	}


	@Override
	public List<Map<String, Object>> getBookingInfo(HttpServletRequest req) {
		
		int userno = (int) req.getSession().getAttribute("userno");
		
		List<Map<String, Object>> bookingList = myPageDao.selectBookingInfo(userno);
		
		return bookingList;
	}
	
	@Override
	public List<Map<String, Object>> getBookingInfo(HttpServletRequest req, MyPageBookingPaging paging) {
		
		int userno = (int) req.getSession().getAttribute("userno");
		
		return myPageDao.selectBookingInfo(JDBCTemplate.getConnection(), paging, userno);
	}

	
	@Override
	public MyPageBookingPaging getBookingPaging(HttpServletRequest req) {
		String param = req.getParameter("curPage");
		int curPage = 0;
		if(param != null && !"".equals(param)) {
			curPage = Integer.parseInt(param);
		}
		
		//booking 테이블의 총 게시글 수를 조회한다
		int totalCount = myPageDao.selectBookingCntAll(JDBCTemplate.getConnection(), (int)req.getSession().getAttribute("userno"));

		//Paging객체 생성
		MyPageBookingPaging paging = new MyPageBookingPaging(totalCount, curPage);
		
		return paging;
	}


	@Override
	public Booking getBookingByUserno(int userno, int bookingno) {

		Booking booking = new Booking();
		
		booking.setusersNo(userno);
		booking.setBookingNo(bookingno);
		
		return booking;
	}


	@Override
	public void cancelBooking(Booking booking) {

		Connection conn = JDBCTemplate.getConnection();
		
		if( myPageDao.cancelBooking(booking, conn) > 0 ) {
			JDBCTemplate.commit(conn);
			System.out.println("커밋 완료");
		} else {
			JDBCTemplate.rollback(conn);
			System.out.println("커밋 실패");
		}
		
	}


	@Override
	public List<Map<String, Object>> getReview(HttpServletRequest req) {
		
		int userno = (int) req.getSession().getAttribute("userno");
		
		List<Map<String, Object>> reviewList = myPageDao.selectReviewList(userno);
		
		return reviewList;
	}
	
	@Override
	public List<Map<String, Object>> getReview(HttpServletRequest req, MyPageReviewPaging paging) {
		
		int userno = (int) req.getSession().getAttribute("userno");
		
		return myPageDao.selectReview(JDBCTemplate.getConnection(), paging, userno);
	}
	
	@Override
	public MyPageReviewPaging getReviewPaging(HttpServletRequest req) {
		String param = req.getParameter("curPage");
		int curPage = 0;
		if(param != null && !"".equals(param)) {
			curPage = Integer.parseInt(param);
		}
		
		//review 테이블의 총 게시글 수를 조회한다
		int totalCount = myPageDao.selectReviewCntAll(JDBCTemplate.getConnection(), (int)req.getSession().getAttribute("userno"));

		//MyPaging객체 생성
		MyPageReviewPaging paging = new MyPageReviewPaging(totalCount, curPage);
		
		return paging;
	}


	@Override
	public List<Map<String, Object>> getBookmark(HttpServletRequest req) {

		int userno = (int) req.getSession().getAttribute("userno");
		
		List<Map<String, Object>> bookmarkList = myPageDao.selectBookmarkList(userno);
		
		return bookmarkList;
	}
	
	@Override
	public List<Map<String, Object>> getBookmark(HttpServletRequest req, MyPageBookmarkPaging paging) {

		int userno = (int) req.getSession().getAttribute("userno");
		
		return myPageDao.selectBookmark(JDBCTemplate.getConnection(), paging, userno);

	}

	@Override
	public MyPageBookmarkPaging getBookmarkPaging(HttpServletRequest req) {
		String param = req.getParameter("curPage");
		int curPage = 0;
		if(param != null && !"".equals(param)) {
			curPage = Integer.parseInt(param);
		}
		
		//review 테이블의 총 게시글 수를 조회한다
		int totalCount = myPageDao.selectBookmarkCntAll(JDBCTemplate.getConnection(), (int)req.getSession().getAttribute("userno"));

		//MyPaging객체 생성
		MyPageBookmarkPaging paging = new MyPageBookmarkPaging(totalCount, curPage);
		
		return paging;
	}

	@Override
	public int getBookmarkNo(HttpServletRequest req) {

		String param = req.getParameter("bookmark_no");
		int bookmarkno = -1;
		
		if(param != null && !"".equals(param)) {
			bookmarkno = Integer.parseInt(param);
		}
		
		return bookmarkno;
	}


	@Override
	public void cancelBookmark(int bookmarkno) {

		Connection conn = JDBCTemplate.getConnection();
		
		if( myPageDao.deleteBookmarkBybookmarkno(bookmarkno, conn) > 0 ) {
			JDBCTemplate.commit(conn);
			System.out.println("북마크 삭제 커밋 완료");
		} else {
			JDBCTemplate.rollback(conn);
			System.out.println("북마크 삭제 커밋 실패");
		}
		
	}

	public Map<String, Object> getBookingDetail(int userno, int roomno) {
		
		return myPageDao.selectBookingDetail(JDBCTemplate.getConnection(), userno, roomno);
		
	}
	
	@Override
	public int getParamRoomno(HttpServletRequest req) {
		
		String param = req.getParameter("roomno");
		int roomno = 0;
		if( param != null && !"".equals(param) ) {
			roomno = Integer.parseInt(param);
		}
		
		return roomno;
	}

}
