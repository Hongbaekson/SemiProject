package service.face;

import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dto.Room;

public interface AdminRoomService {
	
	
	/**
	 * 모든 숙소 리스트로 가져오기
	 * @return 전체 숙소 리스트
	 */
	public List<Room> getList();
	
	/**
	 * 선택한 숙소 승인하기
	 * @param req
	 */
	public void approve(HttpServletRequest req);
	/**
	 * 선택한 숙소 거절하기
	 * @param req
	 */
	public void refuse(HttpServletRequest req);
	/**
	 * 선택한 숙소 삭제하기
	 * @param req
	 */
	public void delete(HttpServletRequest req);

}
