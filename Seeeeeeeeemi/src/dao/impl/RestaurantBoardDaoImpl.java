package dao.impl;

import java.sql.Connection;




import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.JDBCTemplate;
import dto.Restaurant;
import dto.Restaurantimg;
import dao.face.RestaurantBoardDao;
import web.util.Paging;


public class RestaurantBoardDaoImpl implements RestaurantBoardDao {

	
	private PreparedStatement ps = null; //SQL수행 객체
	private ResultSet rs = null; //SQL조회 결과 객체
	
		
	@Override
	public List<Restaurant> selectAll(Connection conn) {
		
		//SQL 작성
		String sql = "";
		sql += "SELECT res_no, filter_no, region_no, res_name, res_phone, res_time, res_parking, res_road_address, imgcheck FROM restaurant";
		sql += " ORDER BY res_no DESC";
		
		//결과 저장할 List
		List<Restaurant> restaurantList = new ArrayList<>();
		

		try {
			ps = conn.prepareStatement(sql); //SQL수행 객체
			
			rs = ps.executeQuery(); //SQL 수행 및 결과집합 저장
			
			//조회 결과 처리
			while(rs.next()) {
				Restaurant r = new Restaurant(); //결과값 저장 객체
				
				//결과값 한 행 처리
			//	r.setResMainimg(rs.getString("res_mainimg"));
				r.setResNo( rs.getInt("res_no") );
				r.setFilterNo( rs.getInt("filter_no") );
				r.setRegionNo( rs.getInt("region_no") );
				r.setResName( rs.getString("res_name") );
				r.setResPhone( rs.getString("res_phone") );
				r.setResTime( rs.getString("res_time") );
				r.setResParking(rs.getString("res_parking"));
				r.setResRoad( rs.getString("res_road_address") );
				r.setImgCheck(rs.getInt("imgcheck"));
				
				//리스트에 결과값 저장
				restaurantList.add(r);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//DB객체 닫기
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		//최종 결과 반환
		return restaurantList;
	}


	@Override
	public List<Restaurant> selectAll(Connection conn, Paging paging) {  // 여기있네요! 이거랑 같은 형식이에요
		//SQL 작성 
				String sql = "";
				sql += "SELECT * FROM (";
				sql += " 	SELECT rownum rnum, B.* FROM (";
				sql += " 		SELECT";
				sql += " 			res_no, filter_no, region_no, res_name, res_phone";
				sql += " 			, res_time, res_parking, res_road_address";
				sql += " 		FROM Restaurant";
				sql += " 		ORDER BY res_no DESC"; 
				sql += "	) B";
				sql += " ) Restaurant";
				sql += " WHERE rnum BETWEEN ? AND ?";
				
				//결과 저장할 List
				List<Restaurant> RestaurantList = new ArrayList<>(); //이 리스트 말고 서치레스토랑리스트로...
				
				try {
					ps = conn.prepareStatement(sql); //SQL수행 객체
					
					ps.setInt(1, paging.getStartNo());
					ps.setInt(2, paging.getEndNo());
					
					rs = ps.executeQuery(); //SQL 수행 및 결과집합 저장
					
					//조회 결과 처리
					while(rs.next()) {
						Restaurant r = new Restaurant(); //결과값 저장 객체
						
						//결과값 한 행 처리
					//	r.setResMainimg(rs.getString("res_mainimg"));
						r.setResNo( rs.getInt("res_no") );
						r.setFilterNo( rs.getInt("filter_no") );
						r.setRegionNo( rs.getInt("region_no") );
						r.setResName( rs.getString("res_name") );
						r.setResPhone( rs.getString("res_phone") );
						r.setResTime( rs.getString("res_time") );
						r.setResParking(rs.getString("res_parking"));
						r.setResRoad( rs.getString("res_road_address") );
						
						
						//리스트에 결과값 저장
						RestaurantList.add(r);
					}
					
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					//DB객체 닫기
					JDBCTemplate.close(rs);
					JDBCTemplate.close(ps);
				}
				
				//최종 결과 반환
				return RestaurantList;
			}

	@Override
	public int selectCntAll(Connection conn) {
		String sql = "";
		sql += "SELECT count(*) cnt FROM board";
		
		//총 게시글 수
		int cnt = 0;
		
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				cnt = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return cnt;
	}


	@Override
	public Restaurant selectBoardByRestaurantno(Connection conn, Restaurant restaurantno) {
		//SQL 작성
				String sql = "";
				sql += "SELECT * FROM Restaurant";
				sql += " WHERE res_no = ?";
				
				//결과 저장할 Restaurant객체
				Restaurant viewRestaurant = null;
				
				try {
					ps = conn.prepareStatement(sql); //SQL수행 객체
					
					ps.setInt(1, restaurantno.getResNo()); //조회할 게시글 번호 적용
					
					rs = ps.executeQuery(); //SQL 수행 및 결과집합 저장
					
					//조회 결과 처리
					while(rs.next()) {
						viewRestaurant = new Restaurant(); //결과값 저장 객체
						
				//결과값 한 행 처리
			//	viewRestaurant.setResMainimg(rs.getString("res_mainimg"));
				viewRestaurant.setResNo( rs.getInt("res_no") );
				viewRestaurant.setFilterNo( rs.getInt("filter_no") );
				viewRestaurant.setRegionNo( rs.getInt("region_no") );
				viewRestaurant.setResName( rs.getString("res_name") );
				viewRestaurant.setResPhone( rs.getString("res_phone") );
				viewRestaurant.setResTime( rs.getString("res_time") );
				viewRestaurant.setResParking( rs.getString("res_parking") );
				viewRestaurant.setResRoad( rs.getString("res_road_address") );
				viewRestaurant.setImgCheck(rs.getInt("imgcheck"));	
				
					} 
					
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					//DB객체 닫기
					JDBCTemplate.close(rs);
					JDBCTemplate.close(ps);
				}
				
				System.out.println(viewRestaurant);
				
				//최종 결과 반환
				return viewRestaurant;
			}







//	@Override
//	public Restaurant searchBoardBySearchno(Connection conn, String cat, String h_area1) {
		//SQL 작성
	//	String sql = "";
	//	sql += "SELECT * FROM Restaurant";
	//	sql += " WHERE filter_no=? and region_no=?";
		
		//결과 저장할 Restaurant객체
	//	Restaurant searchRestaurant = null;
		
		
	//	try {
//		ps = conn.prepareStatement(sql); //SQL수행 객체
	//		
//		ps.setString(1, cat);
//		ps.setString(2, h_area1);
			
//		rs = ps.executeQuery(); //SQL 수행 및 결과집합 저장
			
			//조회 결과 처리
//		while(rs.next()) {
//			searchRestaurant = new Restaurant(); //결과값 저장 객체
				
				//결과값 한 행 처리
//		searchRestaurant.setResNo( rs.getInt("res_no") );
//		searchRestaurant.setFilterNo( rs.getInt("filter_no") );
//		searchRestaurant.setRegionNo( rs.getInt("region_no") );
//		searchRestaurant.setResNo( rs.getInt("res_no") );
//		searchRestaurant.setResName( rs.getString("res_name") );
//		searchRestaurant.setResPhone( rs.getString("res_phone") );
//		searchRestaurant.setResTime( rs.getString("res_time") );
//		searchRestaurant.setResParking( rs.getString("res_parking") );
//		searchRestaurant.setResRoad( rs.getString("res_road_address") );
				
//		} 
			
//		} catch (SQLException e) {
//		e.printStackTrace();
//		} finally {
			//DB객체 닫기
//		JDBCTemplate.close(rs);
//		JDBCTemplate.close(ps);
//		}
		
//	System.out.println(searchRestaurant);
		
		//최종 결과 반환
//		return searchRestaurant;
//	}




	public List<Restaurant> searchBoardBySearchno(int F_no, int R_no) {
	      		//SQL 작성
	      
	            Connection conn = JDBCTemplate.getConnection();
	            String sql="";
	            sql = "SELECT * FROM Restaurant WHERE filter_no=? and region_no=?";
	            
	            //결과 저장할 Restaurant객체
	            //Restaurant searchRestaurant = null; //요걸 없애고 리스트를 만들기
	            List<Restaurant> searchRestaurantList = new ArrayList<>(); //리스트 새로 만듦
	            
	            try { //된 건가여?!?!
	               ps = conn.prepareStatement(sql); //SQL수행 객체
	               
	               ps.setInt(1, F_no);
	               ps.setInt(2, R_no);
	               
	               rs = ps.executeQuery(); //SQL 수행 및 결과집합 저장
	               
	               //조회 결과 처리
	               while(rs.next()) { // 지금 보시면 반환값은 객체가 여러개 들어가있는 list의 형태여야함.. 근데 밑에보니까 그냥 객체 하나뿐. 저 객체들을 다 담아둘 리스트 만들기
	            	   Restaurant searchRestaurant = new Restaurant(); 
	                  // 이미 여기에 서치레스토랑이라는 객체 만들어서 필요 정보는 있음
	            	   //그러면 그거를 그냥 리스트에 넣은다음에 반환하면 됨
	                 
	                  
	                  //결과값 한 행 처리
	            	//  searchRestaurant.setResMainimg(rs.getString("res_mainimg"));
	                  searchRestaurant.setResNo( rs.getInt("res_no") );
	                  searchRestaurant.setFilterNo( rs.getInt("filter_no") );
	                  searchRestaurant.setRegionNo( rs.getInt("region_no") );
	                  searchRestaurant.setResNo( rs.getInt("res_no") );
	                  searchRestaurant.setResName( rs.getString("res_name") );
	                  searchRestaurant.setResPhone( rs.getString("res_phone") );
	                  searchRestaurant.setResTime( rs.getString("res_time") );
	                  searchRestaurant.setResRoad( rs.getString("res_road_address") );
	                  searchRestaurant.setImgCheck(rs.getInt("imgcheck"));
	                  
	                  searchRestaurantList.add(searchRestaurant);
	               } 
	               
	            } catch (SQLException e) {
	               e.printStackTrace();
	            } finally {
	               //DB객체 닫기
	               JDBCTemplate.close(rs);
	               JDBCTemplate.close(ps);
	            }
	            
	            
	            
	            //최종 결과 반환
	            return searchRestaurantList; 
	   }


	@Override
	public int delete(Connection conn, Restaurant restaurant) {
		
		//다음 게시글 번호 조회 쿼리
		String sql = "";
		sql += "DELETE restaurant";
		sql += " WHERE RES_NO = ?";
				
		//DB 객체
		PreparedStatement ps = null; 
				
				int res = -1;
				
				try {
					//DB작업
					ps = conn.prepareStatement(sql);
					ps.setInt(1, restaurant.getResNo());

					res = ps.executeUpdate();
					
				} catch (SQLException e) {
					e.printStackTrace();
					
				} finally {
					try {
						//DB객체 닫기
						if(ps!=null)	ps.close();
						
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				
				return res;
			}


	@Override
	public int insert(Connection conn, Restaurant restaurant) {
		
		//번호 조회 쿼리
		String sql = "";
		sql += "INSERT INTO RESTAURANT ( RES_MAINIMG, RES_NO, filter_no, region_no, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS, imgcheck)";
		sql += " VALUES(?, restaurant_seq.nextval, ?, ?, ?, ?, ?, ?, ?,?)";
		
		int res =0;
		
		try {
			ps=conn.prepareStatement(sql);
		//	ps.setString(1, restaurant.getResMainimg());
			ps.setInt(2, restaurant.getResNo());
			ps.setInt(3, restaurant.getFilterNo());
			ps.setInt(4, restaurant.getRegionNo());
			ps.setString(5, restaurant.getResName());
			ps.setString(6, restaurant.getResPhone());
			ps.setString(7, restaurant.getResTime());
			ps.setString(8, restaurant.getResParking());
			ps.setString(9, restaurant.getResRoad());
			ps.setInt(10, restaurant.getImgCheck());
			
			res=ps.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}


	@Override
	public int selectRestaurantno(Connection conn) {
		String sql = "";
		sql += "SELECT restaurant_seq.nextval from dual;";
		
		int restaurantno =0;
		
		try {
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery(); //sql 수행 및 결과집합 저장 
			
			while(rs.next()) {
				
				restaurantno = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			//DB객체 닫기
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
			
		}
		//최종 결과 반환
		return restaurantno;
	}


	@Override
	public int insertimg(Connection conn, Restaurantimg restaurantimg) {
		System.out.println("[test]insertimg() 호출");
		String sql = "";
		sql += "INSERT INTO restaurantimg(res_imgno, restaurant_no, res_filename)";
		sql += " values (restaurantimg_seq.nextval, ?, ?);";		
		
		int res = 0;
		
		try {
			ps=conn.prepareStatement(sql);
			ps.setInt(1, restaurantimg.getResimgNo());
			ps.setInt(2, restaurantimg.getRestaurantNo());
			ps.setString(3, restaurantimg.getResFilename());
			
			res=ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}


	@Override
	public Restaurantimg selectImg(Connection conn, Restaurant viewImg) {
		
		String sql= "";
		sql += "SELECT * FROM restaurantimg";
		sql += " WEHRE restaurant_no?";
		
		Restaurantimg restaurantimg = null;
		
		try {
			ps=conn.prepareStatement(sql);
			
			ps.setInt(1, viewImg.getResNo()); //조회할 레스토랑넘버 적용
			
			rs=ps.executeQuery();
			
			while(rs.next()) {
				restaurantimg = new Restaurantimg();
				
				restaurantimg.setResimgNo(rs.getInt("res_imgno"));
				restaurantimg.setRestaurantNo(rs.getInt("restaurant_no"));
				restaurantimg.setResFilename(rs.getString("res_filename"));
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			//DB객체 닫기
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		//최종 결과 반환
				return restaurantimg;
	}


	@Override
	public int deleteRestaurantImg(Connection conn, Restaurant deleterestaurant) {
		
		String sql= "";
		sql += "DELETE RESTAURANTIMG";
		sql += " WEHRE restaurant_no= ?";
		
		//DB 객체
		PreparedStatement ps = null; 
		int res = -1;
		
		try {
			//DB작업
			ps = conn.prepareStatement(sql);
			ps.setInt(1, deleterestaurant.getResNo());

			res = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			
		} finally {
			try {
				//DB객체 닫기
				if(ps!=null)	ps.close();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return res;
	}


	@Override
	public List<Restaurant> deleteboardno(int chBox) {
	
		Connection conn = JDBCTemplate.getConnection();
		
        String sql="";
        sql += "select * from restaurant ";
		sql += " WHERE RES_NO = ?";
				
		//DB 객체
	//	PreparedStatement ps = null; 
		List<Restaurant> deleteRestaurantList = new ArrayList<>();
				
		 try { //된 건가여?!?!
             ps = conn.prepareStatement(sql); //SQL수행 객체
             
             ps.setInt(1, chBox);
            
             
             rs = ps.executeQuery(); //SQL 수행 및 결과집합 저장
             
             //조회 결과 처리
             while(rs.next()) { // 지금 보시면 반환값은 객체가 여러개 들어가있는 list의 형태여야함.. 근데 밑에보니까 그냥 객체 하나뿐. 저 객체들을 다 담아둘 리스트 만들기
          	  
            	 Restaurant deleteRestaurant = new Restaurant(); 
                // 이미 여기에 서치레스토랑이라는 객체 만들어서 필요 정보는 있음
          	   //그러면 그거를 그냥 리스트에 넣은다음에 반환하면 됨
               
                
                //결과값 한 행 처리
            //	 deleteRestaurant.setResMainimg(rs.getString("res_mainimg"));
            	 deleteRestaurant.setResNo( rs.getInt("res_no") );
            	 deleteRestaurant.setFilterNo( rs.getInt("filter_no") );
            	 deleteRestaurant.setRegionNo( rs.getInt("region_no") );
            	 deleteRestaurant.setResNo( rs.getInt("res_no") );
            	 deleteRestaurant.setResName( rs.getString("res_name") );
            	 deleteRestaurant.setResPhone( rs.getString("res_phone") );
            	 deleteRestaurant.setResTime( rs.getString("res_time") );
            	 deleteRestaurant.setResRoad( rs.getString("res_road_address") );
                
            	 deleteRestaurantList.add(deleteRestaurant);
             } 
             
          } catch (SQLException e) {
             e.printStackTrace();
          } finally {
             //DB객체 닫기
             JDBCTemplate.close(rs);
             JDBCTemplate.close(ps);
          }
          
          
          
          //최종 결과 반환
          return deleteRestaurantList; 	
		


	}


	@Override
	public List<Restaurantimg> selectImgList(int resno) {
Connection conn = JDBCTemplate.getConnection();
		
		String sql= "";
		sql += "SELECT * FROM restaurantimg";
		sql += " WHERE restaurant_no = ?"; 

		List<Restaurantimg> selectImgList = new ArrayList<>();
		
		try {
			ps=conn.prepareStatement(sql);
			
			ps.setInt(1, resno-1);
		
			rs=ps.executeQuery();
			
			
			System.out.println("쿼리체크");
			while(rs.next()) {
			
				Restaurantimg imgList= new Restaurantimg();
				
				imgList.setResimgNo(rs.getInt("res_imgNo"));
				imgList.setRestaurantNo(rs.getInt("restaurant_no"));
				imgList.setResFilename(rs.getString("res_filename"));
				
				System.out.println(imgList);
				
				selectImgList.add(imgList);
  			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
  			//DB객체 닫기
  			JDBCTemplate.close(rs);
  			JDBCTemplate.close(ps);
		}
		
			return selectImgList;
	}
	
}//마지막 괄호
	

	

	



	
	
	
	
