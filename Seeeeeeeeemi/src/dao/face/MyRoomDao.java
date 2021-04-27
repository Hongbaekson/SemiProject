package dao.face;

import java.sql.Connection;
import java.util.List;

import dto.Room;
import dto.RoomFacilityMapping;
import dto.RoomImg;
import dto.User;
import web.util.Paging;

public interface MyRoomDao {
	/**
	 * 회원번호로 등록한 숙소 리스트 조회
	 * @param conn
	 * @param user - 회원번호가 담긴 DTO
	 * @return 등록한 숙소리스트 반환
	 */
	public List<Room> selectAll(Connection conn);
	/**
	 * 회원번호로 등록한 숙소 리스트 조회
	 * @param conn
	 * @param user - 회원번호가 담긴 DTO
	 * @return 등록한 숙소리스트 반환
	 */
	public List<Room> selectAll(Connection conn, int userno);
	/**
	 * 숙소번호로 등록된 숙소 조회
	 * @param conn
	 * @param room - 숙소번호 담겨있는 Room 객체
	 * @return 등록된 숙소에 대한 DTO
	 */
	public Room selectRoom(Connection conn, Room room);
	/**
	 * 숙소번호로 등록된 숙소 이미지들 조회
	 * @param conn
	 * @param room - 숙소번호 담겨있는 Room 객체
	 * @return 숙소 이미지 리스트
	 */
	public List<RoomImg> selectRoomImg(Connection conn, Room room);
	/**
	 * 숙소번호로 숙소 편의시설 정보 조회
	 * @param conn
	 * @param room - 숙소번호 담겨있는 Room 객체
	 * @return 숙소편의시설매핑 리스트
	 */
	public List<RoomFacilityMapping> selectRoomFac(Connection conn, Room room);
	/**
	 * 숙소번호에 해당하는 숙소 글 삭제
	 * @param conn
	 * @param room - 숙소번호 담겨있는 Room 객체
	 * @return DB 삭제 결과 반환
	 */
	public int deleteRoom(Connection conn, Room room);
	/**
	 * 숙소번호에 해당하는 이미지 파일 정보 삭제
	 * @param conn
	 * @param room - 숙소번호 담겨있는 Room 객체
	 * @return DB 삭제 결과 반환
	 */
	public int deleteRoomImg(Connection conn, Room room);
	/**
	 * 숙소번호에 해당하는 편의시설 정보 삭제
	 * @param conn
	 * @param room - 숙소번호 담겨있는 Room 객체 
	 * @return DB 삭제 결과 반환
	 */
	public int deleteRoomFac(Connection conn, Room room);
	/**
	 * 숙소 정보 수정
	 * @param conn
	 * @param room
	 * @return
	 */
	public int updateRoom(Connection conn, Room room);
	/** ============추가===========
	    * 숙소 정보로 숙소 검색
	    * @param location
	    * @param checkIn
	    * @param checkOut
	    * @param adults
	    * @param kids
	    */ 
	   public List<Room> searchRoom(Connection conn, String location, int guests);
	   public List<Room> searchRoom(Connection conn, String location, int guests, Paging paging);
	   public int selectCntRow(Connection conn, String location, int guests);
	
}
