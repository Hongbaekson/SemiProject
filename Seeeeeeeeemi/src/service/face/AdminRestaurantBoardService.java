package service.face;

import javax.servlet.http.HttpServletRequest;

import dto.Restaurant;

public interface AdminRestaurantBoardService {
	/**
	 * 유저No 파라미터처리 
	 * @param req
	 * @return
	 */
	Restaurant getParamNo(HttpServletRequest req);
	
	/**
	 * 삭제가 되었으면 true반환, 안되었으면 false반환
	 * @param user
	 * @return
	 */
	Boolean delete(Restaurant restaurant);
	
	/**
	 * 공지등록
	 * @param board
	 */
	int writeRestaurant(Restaurant restaurant);
	
	
	/*
	 * 
	 * 첨부파일 포함해 데이터 db 저장
	 */
	public int insertRestaurant(HttpServletRequest req); 


}
