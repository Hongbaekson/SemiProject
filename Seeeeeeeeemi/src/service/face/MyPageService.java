package service.face;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import dto.Booking;
import dto.User;
import util.MyPageBookingPaging;
import util.MyPageBookmarkPaging;
import util.MyPageReviewPaging;

public interface MyPageService {

	/**
	 * 세션에서 userno을 얻어온다
	 * 
	 * @param req
	 * @return
	 */
	public User getUserid(HttpServletRequest req);

	/**
	 * userno의 개인정보를 DB에서 불러온다
	 * 
	 * @param userid
	 * @return
	 */
	public User getUser(User userid);

	/**
	 * 수정 내용을 전달파라미터로 받는다.
	 * 
	 * @param req
	 */
	public User getParam(HttpServletRequest req);

	/**
	 * 유저 정보 수정
	 * 
	 * @param req
	 * @param user
	 * @return
	 */
	public void updateUser(HttpServletRequest req, User user);

	/** 
	 * DB에 있는 패스워드 체크
	 * 
	 * @param req
	 * @return
	 */
	public boolean chkPw(HttpServletRequest req);

	/**
	 * newpw 파라미터로 updatePw
	 * 
	 * @param req
	 */
	public void updateUserPw(HttpServletRequest req);

	/**
	 * 예약 목록 조회
	 * 
	 */
	public List<Map<String, Object>> getBookingInfo(HttpServletRequest req);
	
	/**
	 * 	예약 목록 조회
	 * 	페이징 처리 추가
	 * 
	 * @param paging - 페이징 정보 객체
	 * @return List<Map<String, Object> - 게시글 전체 조회 결과 리스트
	 */
	public List<Map<String, Object>> getBookingInfo(HttpServletRequest req, MyPageBookingPaging paging);
	
	/**
	 * 페이징 객체 생성
	 * 
	 * 요청파라미터 curPage를 구한다
	 * Board 테이블과 curPage 값을 이용하여 Paging객체를 생성한다
	 * 
	 * @param req - curPage정보를 담고 있는 요청 정보 객체
	 * @return 페이징 계산이 완료된 Paging객체
	 */
	public MyPageBookingPaging getBookingPaging(HttpServletRequest req);
	
	/**
	 * 취소할 예약정보 가져오기
	 * 
	 * @param userno
	 * @return
	 */
	public Booking getBookingByUserno(int userno, int bookingno);

	/**
	 * 예약 취소 후 커밋
	 * 
	 * @param booking
	 * @return
	 */
	public void cancelBooking(Booking booking);

	/**
	 * 리뷰 목록 조회
	 * 
	 * @param req
	 * @return
	 */
	public List<Map<String, Object>> getReview(HttpServletRequest req);

	/**
	 * 	리뷰 목록 조회
	 * 	페이징 처리 추가
	 * 
	 * @param paging - 페이징 정보 객체
	 * @return List<Map<String, Object> - 리뷰 전체 조회 결과 리스트
	 */
	public List<Map<String, Object>> getReview(HttpServletRequest req, MyPageReviewPaging paging);
	
	
	/**
	 * 페이징 객체 생성
	 * 
	 * 요청파라미터 curPage를 구한다
	 * 리뷰와 curPage 값을 이용하여 Paging객체를 생성한다
	 * 
	 * @param req - curPage정보를 담고 있는 요청 정보 객체
	 * @return 페이징 계산이 완료된 MyPageReviewPaging객체
	 */
	public MyPageReviewPaging getReviewPaging(HttpServletRequest req);
	
	/**
	 * 북마크 목록 조회
	 * 
	 * @param req
	 * @return
	 */
	public List<Map<String, Object>> getBookmark(HttpServletRequest req);
	
	/**
	 * 북마크 목록 조회
	 * 페이징 처리 추가
	 * 
	 * @param req
	 * @return
	 */
	public List<Map<String, Object>> getBookmark(HttpServletRequest req, MyPageBookmarkPaging paging);
	
	/**
	 * 페이징 객체 생성
	 * 
	 * 요청파라미터 curPage를 구한다
	 * 북마크와 curPage 값을 이용하여 Paging객체를 생성한다
	 * 
	 * @param req - curPage정보를 담고 있는 요청 정보 객체
	 * @return 페이징 계산이 완료된 MyPageBookmarkPaging객체
	 */
	public MyPageBookmarkPaging getBookmarkPaging(HttpServletRequest req);
	/**
	 * bookmark_no파라미터 전달받기
	 * 
	 * @param req
	 */
	public int getBookmarkNo(HttpServletRequest req);

	/**
	 * 북마크 취소
	 * 
	 * @param bookmarkno
	 */
	public void cancelBookmark(int bookmarkno);


	public Map<String, Object> getBookingDetail(int userno, int roomno);

	public int getParamRoomno(HttpServletRequest req);
	
}
