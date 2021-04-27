package service.impl;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import common.JDBCTemplate;
import dao.face.ReviewDao;
import dao.impl.ReviewDaoImpl;
import dto.Review;
import dto.Room;
import service.face.ReviewService;
import web.util.ReviewPaging;

public class ReviewServiceImpl implements ReviewService {
	private ReviewDao reviewDao = new ReviewDaoImpl();
	
	Connection conn = JDBCTemplate.getConnection();
	Room room = new Room();
	
	@Override
	public Review review(HttpServletRequest req) {
		
		try {
			req.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		
		
		//객체 생성 
		Review review = new Review();
		
		
		
		
		// 리뷰 입력 현재시간 사용 
//		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
//		Date time  = new Date();
//		
//		String time1 = format1.format(time);
//		
//		java.sql.Date date = java.sql.Date.valueOf(time1);
//		
//		System.out.println(time1);
		
		
//		String timeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
		
		
		java.util.Date utilDate = new java.util.Date();
		
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
		
		
		//Room객체로부터 getRoomno 메소드 호출 
		int roomno = room.getRoomNo();
		
		
		review.setReContent(req.getParameter("reContent"));
		review.setReDate(sqlDate);
		//로그인 되어있는 userno가져오기 
//	    review.setUsersno((Integer)req.getSession().getAttribute("userno"));
	    review.setUserNo(1);	 //임 시 
	    review.setReStar("5"); //임시 파라미터
	    review.setRoomNo(roomno);
		
		
		
		return review;
	}

	@Override
	public void addReview(Review reviewParam) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		if( reviewDao.insertReview(conn, reviewParam) > 0 ) {
			
			JDBCTemplate.commit(conn);
			
		}else {
			
			JDBCTemplate.rollback(conn);
			
		}
		
	}
	
	@Override
	public List<Review> selectReviewByRoom(Room room){
        
        System.out.println("Reviewservice:" + room.getRoomNo());
        List<Review> ReviewList = reviewDao.selectReviewByRoom(conn, room);
        
        return ReviewList;      
   }
	
	@Override
	public List<Review> selectReviewByRoom(Room room, ReviewPaging paging){
        
        List<Review> ReviewList = reviewDao.selectReviewByRoom(conn, room, paging);
        
        return ReviewList;      
   }
	
	@Override
	public ReviewPaging getPaging(HttpServletRequest req, int roomNo) {
		//전달파라미터 curPage 파싱

		String param = req.getParameter("curpage");
		int curPage = 0;
		if(param != null && !"".equals(param)) {
			curPage = Integer.parseInt(param);
		}
		
		//Board 테이블의 총 게시글 수를 조회한다
		int totalCount = reviewDao.selectCntRow(JDBCTemplate.getConnection(), roomNo);

		//Paging객체 생성
		ReviewPaging paging = new ReviewPaging(totalCount, curPage);
		
		return paging;
	}
}




