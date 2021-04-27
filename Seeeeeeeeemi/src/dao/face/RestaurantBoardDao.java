package dao.face;

import java.sql.Connection;





import java.util.List;

import dto.Restaurant;
import dto.Restaurantimg;
import web.util.Paging;




public interface RestaurantBoardDao {
	
	/**
	 * Board테이블 전체 조회 (페이징 없음)
	 * 
	 * @return List<Restaurant - Restaurant테이블 전체 조회 결과 리스트
	 */
	public List<Restaurant> selectAll(Connection conn);
	
	/**
	 * Board테이블 전체 조회
	 *	페이징 처리 추가
	 * 
	 * @param paging - 페이징 정보 객체
	 * @return List<Restaurant> - Restaurant테이블 전체 조회 결과 리스트
	 */
	public List<Restaurant> selectAll(Connection conn, Paging paging);
	
	/**
	 * 총 게시글 수 조회
	 * 
	 * @return 총 게시글 수
	 */
	public int selectCntAll(Connection conn);
	
	/**
	 * 특정 게시글 조회
	 * 
	 * @param Restaurantno - 조회할 Restaurantno를 가진 객체
	 * @return Board - 조회된 결과 객체
	 */
	public Restaurant selectBoardByRestaurantno(Connection conn, Restaurant restaurantno);
	
	/**
	 * 특정 게시글 조회
	 * 
	 * @param Restaurantno - 조회할 Restaurantno를 가진 객체 
	 * @return Board - 조회된 결과 객체
	 */
//	public Restaurant searchBoardBySearchno(Connection conn, String cat, String h_area1);

//	public Restaurant  searchBoardBySearchno(Connection conn, String cat, String h_area1);


	//public Restaurant searchBoardBySearchno(String[] cat, String[] h_area1);

//	public Restaurant searchBoardBySearchno(Connection conn, Restaurant filterno, Restaurant regionno);
	
	/**
	 * 검색 조건에 맞는 맛집 가지고 오기
	 * @param F_no
	 * @param R_no
	 * @return
	 */
	public List<Restaurant> searchBoardBySearchno(int F_no, int R_no);
	
	
	/**
	 * 게시글 입력
	 * 
	 * @param restaurant - 삽입될 게시글 내용
	 */
	public int insert(Connection conn, Restaurant restaurant);

	/**
	 * 다음 게시글 번호 반환
	 *  게시글 테이블과 첨부파일 테이블에 입력될 게시글번호를
	 * 시퀀스를 통해 추출한다
	 * 
	 * @return - 다음 게시글 번호
	 */
	public int selectRestaurantno(Connection conn);

	/**
	 * 첨부파일 입력
	 * 
	 * @param insertimg - 업로드 된 첨부파일 정보 객체
	 */
	public int insertimg(Connection conn, Restaurantimg restaurantimg);

	/**
	 * 첨부파일 조회
	 *  
	 * @param viewBoard - 첨부파일을 조회할 게시글 객체
	 * @return BoardFile - 조회된 첨부파일
	 */
	public Restaurantimg selectImg(Connection conn, Restaurant viewImg);

	
	/**
	 * 게시글 삭제
	 * 
	 * @param board - 삭제할 게시글번호를 담은 객체
	 */
	public int delete(Connection conn, Restaurant restaurant);
	
	/**
	 * 레스토랑번호에 해당하는 이미지 파일 정보 삭제
	 * @param conn
	 * @param restaurant - 식당번호 담긴 객체
	 * @return DB 삭제 결과 반환
	 */
	public int deleteRestaurantImg(Connection conn, Restaurant deleterestaurant);

	
	

	List<Restaurant> deleteboardno(int chBox);
	
	/**
	 * 레스토랑 이미지 리스트를 가지고 온다
	 * @param resno
	 * @return
	 */
	public List<Restaurantimg> selectImgList(int resno);

}
