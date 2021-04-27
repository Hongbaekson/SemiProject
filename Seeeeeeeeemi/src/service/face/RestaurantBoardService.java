package service.face;



import java.util.List;


import javax.servlet.http.HttpServletRequest;

import dto.Restaurant;
import dto.Restaurantimg;
import web.util.Paging;



public interface RestaurantBoardService {
	
	/**
	 * 게시글 전체 조회 (페이징 없음)
	 * 
	 * @return List<Board> - 게시글 전체 조회 결과 리스트
	 */
	public List<Restaurant> getList();
	
	/**
	 * 페이징 객체 생성
	 * 
	 * 요청파라미터 curPage를 구한다
	 * Board 테이블과 curPage 값을 이용하여 Paging객체를 생성한다
	 * 
	 * @param req - curPage정보를 담고 있는 요청정보 객체
	 * @return 페이징 계산이 완료된 Paging 객체
	 */
	public Paging getPaging(HttpServletRequest req);
	
	/**
	 * 게시글 전체 조회
	 * 	페이징 처리 추가
	 * 
	 * @param paging - 페이징 정보 객체
	 * @return List<Restaurant> - 게시글 전체 조회 결과 리스트
	 */
	public List<Restaurant> getList(Paging paging);
	
	/**
	 * 요청파라미터 얻기
	 * 
	 * @param req - 요청정보객체
	 * @return Board - 전달파라미터 boardno를 포함한 객체
	 */
	public Restaurant getRestaurantno(HttpServletRequest req);

	
	/**
	 * 주어진 Restaurantno를 이용하여 게시글을 조회한다
	 * 조회된 게시글의 조회수를 1 증가시킨다
	 * 
	 * @param boardno - Restaurantno를 가지고 있는 객체
	 * @return Restaurant - 조회된 게시글
	 */
	public Restaurant view(Restaurant Restaurantno);
	
	/**
	 * 검색된 게시글만 조회
	 * @param req
	 * @return
	 */
	public Restaurant getsearchBoardBySearchno(HttpServletRequest req);
	
	//public Restaurant getsearchno(Restaurant filterno, Restaurant regionno);
	
	/**
	 * 게시글 작성, 입력 게시글 내용을 db에 저장!! 첨부파일도 함께 업로드 가능하도록 처리하기 
	 * 
	 * @param req
	 */
	public void write(HttpServletRequest req);
	
	/**
	 * 첨부파일의 정보 얻기
	 *  
	 * @param viewBoard - 첨부파일 포함된 게시글 번호
	 * @return BoardFile - 첨부파일 정보 객체
	 */
	public Restaurantimg viewFile(Restaurant viewrestaurantimg);
	
	/**
	 * 게시글 삭제
	 * 
	 * @param restaurant - 삭제할 게시글 번호를 가진 객체
	 */
	public void delete(Restaurant restaurant);
	
	/*
	 * 파라미터 처리
	 */
	public Restaurant getres(HttpServletRequest req);
	
	/**
	 * 이미지 리스트 번호 파라미터 처리
	 * @param req
	 * @return
	 */
	public int getresno(HttpServletRequest req);
}

