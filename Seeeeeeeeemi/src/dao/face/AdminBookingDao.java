package dao.face;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

public interface AdminBookingDao {
	
	/**
	 * 예약정보를 전체 조회
	 * @param conn
	 * @return 전체 예약 정보 리스트 반환
	 */
	public List<Map<String, Object>> selectAll(Connection conn);
	/**
	 * 예약번호에 해당하는 예약정보 삭제
	 * @param conn 
	 * @param bookingno - 예약번호
	 * @return 삭제결과 반환
	 */
	public int delete(Connection conn, int bookingno);

}
