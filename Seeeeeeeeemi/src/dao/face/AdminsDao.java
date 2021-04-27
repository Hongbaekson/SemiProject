package dao.face;

import java.sql.Connection;
import java.util.List;

import dto.Board;
import dto.Review;
import dto.RoomImgReview;
import dto.User;

public interface AdminsDao {
	/**
	 * userno에 해당하는 열 삭제, 성공시 1반환 
	 * @param conn
	 * @param user
	 * @return
	 */
	int delete(Connection conn, User user);
	/**
	 * insert
	 * @param conn
	 * @param user
	 * @return
	 */
	int insert(Connection conn, User user);
	/**
	 * 글을 삽입한다 
	 * @param conn
	 * @param board
	 * @return
	 */
	int writeNotice(Connection conn, Board board);
	/**
	 * 리뷰를 조회한다 
	 * @param connection
	 * @return
	 */
	List<RoomImgReview> selectReview(Connection connection);
	/**
	 * 리뷰넘버로 리뷰를 삭제한다 
	 * @param conn
	 * @param review
	 * @return
	 */
	int deleteByReviewno(Connection conn, Review review);

}
