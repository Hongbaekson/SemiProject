package dao.face;

import java.sql.Connection;

import dto.Room;
import dto.RoomFacilityMapping;
import dto.RoomImg;

public interface HostDao {
	/**
	 * 다음에 넣을 숙소번호를 조회한다.
	 * @param conn - DB 연결 객체
	 * @return 저장될 숙소번호 반환
	 */
	public int selectNextRoomNo(Connection conn);
	/**
	 * 숙소 정보 삽입
	 * @param conn
	 * @param room -숙소정보가 들어있는 DTO
	 * @return 삽입결과 반환
	 */
	public int insertRoom(Connection conn, Room room);
	/**
	 * 숙소 편의시설 정보 삽입
	 * @param conn
	 * @param data - 숙소편의시설매핑 DTO
	 * @return 삽입결과 반환
	 */
	public int insertRoomFac(Connection conn, RoomFacilityMapping data);
	/**
	 * 숙소 이미지 파일 정보 삽입
	 * @param conn
	 * @param data - 숙소이미지파일 DTO
	 * @return 삽입결과 반환
	 */
	public int insertRoomImg(Connection conn, RoomImg data);

}
