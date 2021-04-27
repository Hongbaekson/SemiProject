package dao.face;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import dto.Room;
import util.BookingPaging;

public interface MyRoomBookingDao {
	/**
	 * 숙소번호에 해당하는 예약 수를 조회
	 * @param conn
	 * @param roono - 숙소번호
	 * @return 예약 수
	 */
	public int selectCntByRoomno(Connection conn, int roomno);
	/**
	 * 호스트의 예약을 전체조회 (페이징처리)
	 * @param conn 
	 * @param hostNo - 호스트의 회원번호
	 * @param paging 
	 * @return 예약정보를 담은 리스트
	 */
	public List<Map<String, Object>> selectByPaging(Connection conn, int hostNo, BookingPaging paging);
	/**
	 * 예약상태를 수정
	 * @param conn
	 * @param bookingno - 예약번호
	 * @param bookingStatus - 예약상태
	 * @return 예약 수정 결과
	 */
	public int updateStatus(Connection conn, int bookingno, String bookingStatus);
	/**
	 * 유저가 가진 숙소번호 전체 조회
	 * @param conn
	 * @param hostNo - 회원번호(호스트)
	 * @return 숙소번호 리스트 반환
	 */
	public List<Integer> selectRoomnoByUserno(Connection conn, int hostNo);
	
	/**
	 * 해당 숙소번호의 예약들을 삭제
	 * @param conn
	 * @param room - 해당 숙소 번호
	 * @return 삭제결과 반환
	 */
	//없어도될듯?
	//public int deleteBooking(Connection conn, Room room);

}
