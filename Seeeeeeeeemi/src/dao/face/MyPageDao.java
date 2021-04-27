package dao.face;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import dto.Booking;
import dto.User;
import util.MyPageBookingPaging;
import util.MyPageBookmarkPaging;
import util.MyPageReviewPaging;

public interface MyPageDao {

	/**
	 * DB에서 UserInfo 가져오기
	 * @param userno 
	 * 
	 * @return
	 */
	public User selectUserInfo(User userid);

	/**
	 * user정보를 DB에 update
	 * 
	 * @param user
	 * @return
	 */
	public int updateUser(Connection conn, User user);

	/**
	 * DB에 있는 비밀번호와 전달파라미터 비밀번호와 비교
	 * 
	 * @return
	 */
	public boolean chkPw(String curpw, int userno);

	/**
	 * UserPw를 DB에 update
	 * 
	 */
	public int updateUserPw(int userno, String newpw, Connection conn);

	/**
	 * 예약정보 조회
	 * 
	 * @param conn
	 * @return
	 */
	public List<Map<String, Object>> selectBookingInfo(int userno);
	
	/**
	 * 예약정보 조회
	 *	페이징 처리 추가
	 * 
	 * @param paging - 페이징 정보 객체
	 * @return List<Map<String, Object> - 예약 전체 조회 결과 리스트
	 */
	public List<Map<String, Object>> selectBookingInfo(Connection connection, MyPageBookingPaging paging, int userno);

	/**
	 * booking_status update (예약 취소)
	 * 
	 * @param booking
	 * @param conn
	 * @return
	 */
	public int cancelBooking(Booking booking, Connection conn);

	/**
	 * 리뷰정보 조회
	 * 
	 * @param userno
	 * @return
	 */
	public List<Map<String, Object>> selectReviewList(int userno);
	
	/**
	 * 리뷰정보 조회
	 *	페이징 처리 추가
	 * 
	 * @param paging - 페이징 정보 객체
	 * @return List<Map<String, Object> - 리뷰 전체 조회 결과 리스트
	 */
	public List<Map<String, Object>> selectReview(Connection connection, MyPageReviewPaging paging, int userno);
	
	/**
	 * 북마크정보 조회
	 * 
	 * @param userno
	 * @return
	 */
	public List<Map<String, Object>> selectBookmarkList(int userno);

	/**
	 * 북마크정보 조회
	 * 페이징 처리 추가
	 * 
	 * @param userno
	 * @return
	 */
	public List<Map<String, Object>> selectBookmark(Connection connection, MyPageBookmarkPaging paging, int userno);
	
	/**
	 * DB에서 북마크 삭제
	 * 
	 * @param bookmarkno
	 * @param conn
	 * @return
	 */
	public int deleteBookmarkBybookmarkno(int bookmarkno, Connection conn);

	/**
	 * 총 예약 수 조회 
	 *
	 * @param connection
	 * @return 총 예약 수
	 */
	public int selectBookingCntAll(Connection conn, int userno);
	
	/**
	 * 총 리뷰 수 조회
	 * 
	 * @param connection
	 * @return 총 리뷰 수
	 */
	public int selectReviewCntAll(Connection connection, int userno);

	/**
	 * 총 리뷰 수 조회
	 * 
	 * @param connection
	 * @return 총 리뷰 수
	 */
	public int selectBookmarkCntAll(Connection connection, int userno);

	public Map<String, Object> selectBookingDetail(Connection conn, int userno, int roomno);


	

}
