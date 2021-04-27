package service.face;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dto.Room;
import dto.RoomFacilityMapping;
import dto.RoomImg;
import web.util.Paging;

public interface MyRoomService {
	
	/**
	 * 세션의 회원번호를 이용하여 내가 등록한 숙소 리스트 얻기
	 * @param req - 회원번호 알기 위한 정보
	 * @return 등록한 숙소 리스트
	 */
	public List<Room> getRoomList(HttpServletRequest req);
	/**
	 * 세션의 회원번호를 이용하여 내가 등록한 숙소 리스트 얻기
	 * @param req - 회원번호 알기 위한 정보
	 * @return 등록한 숙소 리스트
	 */
	public List<Room> getRoomList(HttpServletRequest req, int userno);
	/**
	 * request에서 roomNo 정보를 가진 Room 객체 얻기
	 * @param req
	 * @return 요청파라미터의 roomNo를 가진 Room 객체 반환
	 */
	public Room getRoomNo(HttpServletRequest req);
	/**
	 * 숙소번호를 가진 Room객체를 이용하여 전체 정보를 가진 Room 객체 얻기
	 * @param room - 숙소번호만 있는 객체
	 * @return 전체 정보를 가진 Room 객체
	 */
	public Room getRoom(Room room);
	/**
	 * 숙소번호를 이용하여 숙소의 이미지 정보 리스트 얻기
	 * @param room - 숙소번호만 있는 객체
	 * @return 숙소 이미지 정보 리스트
	 */
	public List<RoomImg> getRoomImgList(Room room);
	/**
	 * 숙소번호를 이용하여 숙소의 편의시설매핑 정보 리스트 얻기
	 * @param room - 숙소번호만 있는 객체
	 * @return 숙소편의시설매핑 정보를 문자열 리스트로 반환
	 */
	public List<String> getRoomFacList(Room room);
	/**
	 * 등록한 숙소를 삭제
	 * @param room - 숙소번호만 있는 객체
	 */
	public void delete(HttpServletRequest req, Room room);
	/**
	 * 숙소 정보 수정 => 편의시설정보는 삭제후 삽입, 이미지는 없으면 그대로, 업로드 파일이 있으면 원래 정보 삭제 후 삽입
	 * 나머지 정보는 업데이트
	 * @param req
	 * @return 수정된 숙소 번호 반환
	 */
	public int update(HttpServletRequest req);
	  /** ============추가===========
	    * 숙소 정보로 숙소 검색
	    * @param location
	    * @param checkIn
	    * @param checkOut
	    * @param adults
	    * @param kids
	    */ 
	   public List<Room> searchRoom(HttpServletRequest req, int guests, String location);
	   public List<Room> searchRoom(HttpServletRequest req, int guests, String location, Paging paging);
	   public Paging getPaging(HttpServletRequest req, String location, int guests);
	   

}
