package dao.face;

import java.sql.Connection;

import dto.Restaurant;
import dto.Restaurantimg;

public interface AdminRestaurantBoardDao {
	
	
	
	/**
	 * userno에 해당하는 열 삭제, 성공시 1반환 
	 * @param conn
	 * @param user
	 * @return
	 */
	int delete(Connection conn, Restaurant restaurant);
	
	/**
	 * 글을 삽입한다 
	 * @param conn
	 * @param board
	 * @return
	 */
	int writeRestaurant(Connection conn, Restaurant restaurant);
	
	/**
	 * 등록할 다음 레스토랑 넘버 가져오기
	 * @param conn
	 * @return
	 */
	int selectNextResNo(Connection conn);
	
	/**
	 * 이미지 삽입
	 * @param conn
	 * @param restaurantimg
	 * @return
	 */
	public int insertimg(Connection conn, Restaurantimg restaurantimg);
	
	
}
