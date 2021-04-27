package dto;

import java.sql.Date;

public class Review {

	private int reNo;
	private int userNo;
	private int roomNo;
	private String reContent;
	private Date reDate;
	private String reStar;
	@Override
	public String toString() {
		return "Review [reNo=" + reNo + ", userNo=" + userNo + ", roomNo=" + roomNo + ", reContent=" + reContent
				+ ", reDate=" + reDate + ", reStar=" + reStar + "]";
	}
	public int getReNo() {
		return reNo;
	}
	public void setReNo(int reNo) {
		this.reNo = reNo;
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
	public String getReContent() {
		return reContent;
	}
	public void setReContent(String reContent) {
		this.reContent = reContent;
	}
	public Date getReDate() {
		return reDate;
	}
	public void setReDate(Date reDate) {
		this.reDate = reDate;
	}
	public String getReStar() {
		return reStar;
	}
	public void setReStar(String reStar) {
		this.reStar = reStar;
	}
	
	
	
	
}
