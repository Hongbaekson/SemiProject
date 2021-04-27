package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.JDBCTemplate;
import dao.face.MainDao;
import dto.RoomImgReview;

public class MainDaoImpl implements MainDao {
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	@Override
	public List<RoomImgReview> selectByAddress(Connection conn, RoomImgReview room) {
		
		//키워드검색 (4개만) 
		String sql="";
		sql+="select rownum, T.* from (";
		sql+=" SELECT  TB.*";
		sql+="  FROM(   SELECT ROW_NUMBER() OVER(PARTITION BY i.room_no ORDER BY i.room_img_no ) AS RNUM, i.*, r.*";
		sql+="   FROM room_img i,room r";
		sql+="  where i.room_no=r.roomno and roomadmincheck='Y' and roomroadaddress like '%' || ? || '%'";
		sql+="  ) TB"; 
		sql+="   WHERE RNUM = 1";
		sql+="  )T";
		sql+=" where rownum between 1 and 4";
				
		
		List<RoomImgReview> list = new ArrayList<>();
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, room.getRoomRoadAddress() );
			rs = ps.executeQuery();		
			while(rs.next()) {
				
				RoomImgReview roomAll = new RoomImgReview();
				roomAll.setRoomNo( rs.getInt("roomno") );
				roomAll.setUserNo(rs.getInt("userno") );
				roomAll.setRoomName( rs.getString("roomname"));
				roomAll.setRoomGuests( rs.getInt("roomguests"));
				roomAll.setRoomPrice( rs.getInt("roomprice"));
//				roomAll.setRoomBedroom( rs.getInt("roombedroom"));
				roomAll.setRoomBed(rs.getInt("roombed"));
//				roomAll.setRoomAdminCheck(rs.getString("roomadmincheck"));
				roomAll.setRoomDesc( rs.getString("roomdesc"));
				roomAll.setRoomBathroom(rs.getInt("roombathroom"));
				roomAll.setRoomType( rs.getString("roomtype"));
				roomAll.setRoomRoadAddress( rs.getString("roomroadaddress"));
				roomAll.setRoomDetailedAddress( rs.getString("roomdetailedaddress") );
				roomAll.setRoomImgFilename( rs.getString("room_img_filename"));
				
				list.add(roomAll);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		return list;
	}
	@Override
	public List<RoomImgReview> selectPopularRoom(Connection conn) {

		//리뷰가 최신순이면서 별점이 4개이상인 숙소를 보여줌(3개만)
		String sql="";
		sql+="select rownum, T.* from (";
		sql+="   SELECT  TB.*";
		sql+="      FROM(   SELECT ROW_NUMBER() OVER(PARTITION BY i.room_no ORDER BY i.room_img_no ) AS RNUM, i.*, r.*,v.re_date, v.re_content, v.re_star,v.user_no reviewno, u.user_nick reviewnick";
		sql+="              FROM room_img i,room r,users u, review v";
		sql+="              where i.room_no=r.roomno and u.user_no=v.user_no and r.roomno=v.room_no and re_star>=4";
		sql+="      ) TB";
		sql+="      WHERE RNUM = 1";
		sql+="    )T";
		sql+=" where rownum between 1 and 3";
		
		List<RoomImgReview> list = new ArrayList<>();
		
		try {
			ps = conn.prepareStatement(sql);			
			rs = ps.executeQuery();
			while(rs.next()) {
				
				RoomImgReview roomAll = new RoomImgReview();
				
				roomAll.setRoomNo( rs.getInt("roomno") );
				roomAll.setRoomName( rs.getString("roomname"));
				roomAll.setReDate( rs.getDate("re_date"));
				roomAll.setRoomImgFilename( rs.getString("room_img_filename"));
				roomAll.setReContent( rs.getString("re_content"));
				roomAll.setReStar(rs.getInt("re_star"));
				roomAll.setUserNoReview(rs.getInt("reviewno"));
				roomAll.setUserNick( rs.getString("reviewnick"));
				list.add(roomAll);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		return list;
	}
	
}
