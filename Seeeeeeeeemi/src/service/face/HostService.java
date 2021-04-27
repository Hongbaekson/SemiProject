package service.face;

import javax.servlet.http.HttpServletRequest;

public interface HostService {
	/**
	 * 호스트 폼 데이터를 DB에 저장
	 * @param req
	 * @return 등록된 숙소번호 반환
	 */
	public int registerForm(HttpServletRequest req);
	
}
