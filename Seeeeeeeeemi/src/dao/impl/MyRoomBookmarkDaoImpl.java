package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import common.JDBCTemplate;
import dao.face.MyRoomBookmarkDao;
import dto.Bookmark;


public class MyRoomBookmarkDaoImpl implements  MyRoomBookmarkDao{
   PreparedStatement ps = null;
   ResultSet rs = null;
   
   
   @Override
   public int insertBookmark(Connection conn, Bookmark bookmark) {
      String sql = "";
      sql += "INSERT INTO bookmark(bookmark_no, user_no, room_no)";
      sql += " VALUES(BOOKMARK_SEQ.NEXTVAL, " + bookmark.getUserNo() + ", " + bookmark.getRoomNo() + ")";
      String sqlc = "COMMIT";
      
      
      System.out.println(sql);
      int res = -1;
      
      try {
         ps = conn.prepareStatement(sql);
         res = ps.executeUpdate();
         
         ps = conn.prepareStatement(sqlc);
         res = ps.executeUpdate();
         
         
      } catch (SQLException e) {
         e.printStackTrace();
      } finally {
         JDBCTemplate.close(ps);
      }
      return res;
   }
   
}
   
   