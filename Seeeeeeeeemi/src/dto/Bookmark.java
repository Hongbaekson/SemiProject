package dto;

public class Bookmark {
	private int bookmarkNo;
	private int userNo;
	private int roomNo;
	
	@Override
	public String toString() {
		return "Bookmark [bookmarkNo=" + bookmarkNo + ", userNo=" + userNo + ", roomNo=" + roomNo + "]";
	}
	
	public int getBookmarkNo() {
		return bookmarkNo;
	}
	public void setBookmarkNo(int bookmarkNo) {
		this.bookmarkNo = bookmarkNo;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public int getRoomNo() {
		return roomNo;
	}
	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}
	
	
	
	
}
