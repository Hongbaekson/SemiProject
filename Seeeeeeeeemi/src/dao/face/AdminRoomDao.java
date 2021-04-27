package dao.face;

import java.sql.Connection;
import java.util.List;

import dto.Room;

public interface AdminRoomDao {

	/**
	 * 전체 숙소 조회
	 * @param conn
	 * @return 전체 숙소 리스트
	 */
	public List<Room> selectAll(Connection conn);
	
	/**
	 * 숙소승인상태 승인으로 변경
	 * @param updateRoom
	 * @return DB 수행 결과 반환
	 */
	public int updateApprove(Connection conn, Room updateRoom);
	/**
	 * 숙소승인상태 거절로 변경
	 * @param conn
	 * @param updateRoom
	 * @return DB 수행 결과 반환
	 */
	public int updateRefuse(Connection conn, Room updateRoom);
	/**
	 * 숙소 삭제하기
	 * @param conn
	 * @param deleteRoom
	 * @return DB 수행 결과 반환
	 */
	public int updateDelete(Connection conn, Room deleteRoom);
	/**
	 * 숙소주인의 회원번호 조회
	 * @param conn
	 * @param updateRoom - 숙소번호
	 * @return 회원번호 반환
	 */
	public int selectUsernoByRoomno(Connection conn, Room updateRoom);
	/**
	 * 숙소 승인시 회원의 회원등급 변경
	 * @param conn
	 * @param userno - 회원번호
	 * @return DB 수행 결과 반환
	 */
	public int updateUserGrade(Connection conn, int userno);

}
