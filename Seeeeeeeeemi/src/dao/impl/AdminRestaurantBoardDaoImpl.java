package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import common.JDBCTemplate;
import dao.face.AdminRestaurantBoardDao;
import dto.Restaurant;
import dto.Restaurantimg;

public class AdminRestaurantBoardDaoImpl implements AdminRestaurantBoardDao {
	
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	
	@Override
	public int delete(Connection conn, Restaurant restaurant) {
		
		String sql="";
		sql+="delete from restaurant";
		sql+= " where res_no=?";
		
		
		int res=-1;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, restaurant.getResNo());
			res = ps.executeUpdate();

		} catch (SQLException e) {			
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		return res; 
		
	}
	

	@Override
	public int writeRestaurant(Connection conn, Restaurant restaurant) {
		System.out.println("룸 호출");
		System.out.println(restaurant);
		//삽입 쿼리
		String sql = "";
		sql += "INSERT INTO RESTAURANT ( RES_NO, filter_no, region_no, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)";
		sql += " VALUES(restaurant_seq.nextval, ?, ?, ?, ?, ?, ?, ?)"; 
				
				int res =-1;
				
				try {
					
					System.out.println("여기는?");
					ps=conn.prepareStatement(sql);
				//	ps.setString(1, restaurant.getResMainimg());
				//	ps.setInt(1, restaurant.getResNo()); //여기 없애나여? 헷갈려요..아 넵
					ps.setInt(1, restaurant.getFilterNo());
					ps.setInt(2, restaurant.getRegionNo());
					ps.setString(3, restaurant.getResName());
					ps.setString(4, restaurant.getResPhone());
					ps.setString(5, restaurant.getResTime());
					ps.setString(6, restaurant.getResParking());
					ps.setString(7, restaurant.getResRoad());
					
					res=ps.executeUpdate(); 
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}finally {
					JDBCTemplate.close(ps);
				}
				return res;
			}


	@Override
	public int insertimg(Connection conn, Restaurantimg restaurantimg) {
		String sql = "";
		sql += "INSERT INTO restaurantimg(res_imgno, restaurant_no, res_filename)";
		sql += " values (restaurantimg_seq.nextval, ?, ?)";		
		
		int res = -1;
		
		try {
			ps=conn.prepareStatement(sql);
		//	ps.setInt(1, restaurantimg.getResimgNo());
			ps.setInt(1, restaurantimg.getRestaurantNo());
			ps.setString(2, restaurantimg.getResFilename());
			
			res=ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}


	@Override
	public int selectNextResNo(Connection conn) {
		String sql = "SELECT restaurant_seq.nextval as next FROM dual";
		
		int resno= 0;
		
		try {
			ps = conn.prepareStatement(sql);
			
			rs = ps.executeQuery();
			if(rs.next()) {
				resno = rs.getInt("next");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return resno;
		
		
		
	}
}
