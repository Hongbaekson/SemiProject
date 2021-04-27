package service.face;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import util.BookingPaging;

public interface MyRoomBookingService {
	
	/**
	 * 요청 파라미터로 부터 페이징 객체 얻기
	 * @param req
	 * @return paging 객체
	 */
	public BookingPaging getPaging(HttpServletRequest req);
	/**
	 * 호스트의 회원번호와 페이징에 해당하는 예약리스트 조회
	 * @param hostNo - 호스트의 회원번호
	 * @param paging - 페이징 객체
	 * @return view에서 보여줄 정보를 list에 넣어서 반환
	 */
	public List<Map<String, Object>> getList(int hostNo, BookingPaging paging);
	
	/**
	 * 예약상태를 승인(예약승인)/거절(예약취소됨)로 업데이트
	 * @param req - 예약상태, 예약번호가 있다.
	 */
	public void updateStatus(HttpServletRequest req);

}
