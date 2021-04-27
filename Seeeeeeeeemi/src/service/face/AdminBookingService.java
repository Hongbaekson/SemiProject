package service.face;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface AdminBookingService {
	
	/**
	 *예약 정보 전체 조회  
	 * @return 예약 리스트 반환
	 */
	public List<Map<String, Object>> getList();
	
	/**
	 * 예약 정보 삭제
	 * @param req
	 */
	public void delete(HttpServletRequest req);

}
