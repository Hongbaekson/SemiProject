package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import common.JDBCTemplate;
import dao.face.ReviewDao;
import dto.Review;
import dto.Room;
import web.util.ReviewPaging;

public class ReviewDaoImpl implements ReviewDao {
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	@Override
	public int insertReview(Connection conn, Review reviewParam) {
		
		
		//쿼리 작성 
		String sql ="";
		sql += "INSERT INTO review (re_no, user_no, room_no, re_content,  re_star,re_date)";
		sql += " VALUES(REVIEW_SEQ.NEXTVAL,? ,? ,?, ?, ? )";
		
		
		 
		int res = -1;
		
		try {
			ps= conn.prepareStatement(sql);
		
			ps.setInt(1, reviewParam.getUserNo());
			ps.setInt(2, reviewParam.getRoomNo());
			ps.setString(3, reviewParam.getReContent());
			ps.setString(4, reviewParam.getReStar());
			ps.setDate(5, reviewParam.getReDate());
			
			
			res=ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(ps);
			
			
		}
		
		
		return res;
	}
	
	   @Override
	   public List<Review> selectReviewByRoom(Connection conn, Room room){
	      
	      String sql = "SELECT * FROM REVIEW WHERE room_no = ?";
	      
	      List<Review> reviewList = new ArrayList<>();
	      Review review = null;
	      
	      try {
	         ps = conn.prepareStatement(sql);
	         
	         ps.setInt(1, room.getRoomNo());
	         
	         rs = ps.executeQuery();
	         while(rs.next()) {
	            review = new Review();
	               
	            review.setReNo(rs.getInt("re_no"));
	            review.setUserNo(rs.getInt("user_no"));
	            review.setRoomNo(rs.getInt("room_no"));
	            review.setReContent(rs.getString("re_content"));
	            review.setReDate(rs.getDate("re_date"));
	            review.setReStar(rs.getString("re_star"));
	            
	            reviewList.add(review);
	         }
	      } catch (SQLException e) {
	         e.printStackTrace();
	      } finally {
	         JDBCTemplate.close(rs);
	         JDBCTemplate.close(ps);
	      }
	      
	      return reviewList;
	      
	   }
	   
	   @Override
	   public List<Review> selectReviewByRoom(Connection conn, Room room, ReviewPaging paging){
	      
			String sql="";
			sql+="select * from (";
			sql+=" select rownum rnum, B.* from(";
			sql+="   select * from REVIEW ";
			sql+="		 where room_no = ? ORDER BY rownum DESC";
			sql+=" 		)B";
			sql+=" )where rnum between ? and ? ";
			
			
	      
	      List<Review> reviewList = new ArrayList<>();
	      Review review = null;
	      
	      try {
	         ps = conn.prepareStatement(sql);
	         
	         ps.setInt(1, room.getRoomNo());
	         ps.setInt(2, paging.getStartNo());
			 ps.setInt(3, paging.getEndNo());
			 System.out.println(sql);
	         rs = ps.executeQuery();
	         while(rs.next()) {
	            review = new Review();
	               
	            review.setReNo(rs.getInt("re_no"));
	            review.setUserNo(rs.getInt("user_no"));
	            review.setRoomNo(rs.getInt("room_no"));
	            review.setReContent(rs.getString("re_content"));
	            review.setReDate(rs.getDate("re_date"));
	            review.setReStar(rs.getString("re_star"));
	            
	            reviewList.add(review);
	         }
	      } catch (SQLException e) {
	         e.printStackTrace();
	      } finally {
	         JDBCTemplate.close(rs);
	         JDBCTemplate.close(ps);
	      }
	      
	      return reviewList;
	   }
	   
	   @Override
		public int selectCntRow(Connection conn, int roomNo) {
			String sql="select count(*) cnt from review WHERE room_no = " + roomNo;
			
			int cnt=0;
			try {
				System.out.println("리뷰 카운트 sql: " + sql);
				ps = conn.prepareStatement(sql);
				rs = ps.executeQuery();
				while(rs.next()) {
					cnt =rs.getInt(1);
				}
					
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				JDBCTemplate.close(rs);
				JDBCTemplate.close(ps);
			}
			return cnt;
		}
	
	

}
