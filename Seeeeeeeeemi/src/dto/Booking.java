package dto; 

import java.sql.Date;

import org.eclipse.jdt.internal.compiler.ast.SuperReference;

public class Booking extends User{

	private int bookingNo ;
	private int usersNo;
	private int bookingGuest;
	private String bookingCheckin;
	private String bookingCheckout;
	private String bookingStatus;
	private String bookingMessage;
	private String bookingUsername;
	private String bookingUserphone;
	private String bookingUseremail;
	private int roomNo;
	private int roomPrice;
	private String roomType;
	private String roomName;

	private User userNoData;
	
	@Override
	public String toString() {
		System.out.println(super.toString());
		return "Booking [bookingNo=" + bookingNo + ", usersNo=" + usersNo + ", bookingGuest=" + bookingGuest
				+ ", bookingCheckin=" + bookingCheckin + ", bookingCheckout=" + bookingCheckout + ", bookingStatus="
				+ bookingStatus + ", bookingMessage=" + bookingMessage + ", bookingUsername=" + bookingUsername
				+ ", bookingUserphone=" + bookingUserphone + ", bookingUseremail=" + bookingUseremail + ", roomNo="
				+ roomNo + ", roomPrice=" + roomPrice + ", roomType=" + roomType + ", roomName=" + roomName
				+ " ]";
	}
	public int getBookingNo() {
		return bookingNo;
	}
	public void setBookingNo(int bookingNo) {
		this.bookingNo = bookingNo;
	}
	public int getusersNo() {
		return usersNo;
	}
	public void setusersNo(int usersNo) {
		this.usersNo = usersNo;
	}
	public int getBookingGuest() {
		return bookingGuest;
	}
	public void setBookingGuest(int bookingGuest) {
		this.bookingGuest = bookingGuest;
	}
	public String getBookingCheckin() {
		return bookingCheckin;
	}
	public void setBookingCheckin(String bookingCheckin) {
		this.bookingCheckin = bookingCheckin;
	}
	public String getBookingCheckout() {
		return bookingCheckout;
	}
	public void setBookingCheckout(String bookingCheckout) {
		this.bookingCheckout = bookingCheckout;
	}
	public String getBookingStatus() {
		return bookingStatus;
	}
	public void setBookingStatus(String bookingStatus) {
		this.bookingStatus = bookingStatus;
	}
	public String getBookingMessage() {
		return bookingMessage;
	}
	public void setBookingMessage(String bookingMessage) {
		this.bookingMessage = bookingMessage;
	}
	public String getBookingUsername() {
		return bookingUsername;
	}
	public void setBookingUsername(String bookingUsername) {
		this.bookingUsername = bookingUsername;
	}
	public String getBookingUserphone() {
		return bookingUserphone;
	}
	public void setBookingUserphone(String bookingUserphone) {
		this.bookingUserphone = bookingUserphone;
	}
	public String getBookingUseremail() {
		return bookingUseremail;
	}
	public void setBookingUseremail(String bookingUseremail) {
		this.bookingUseremail = bookingUseremail;
	}
	public int getRoomNo() {
		return roomNo;
	}
	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}
	public int getRoomPrice() {
		return roomPrice;
	}
	public void setRoomPrice(int roomPrice) {
		this.roomPrice = roomPrice;
	}
	public String getRoomType() {
		return roomType;
	}
	public void setRoomType(String roomType) {
		this.roomType = roomType;
	}
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	
	
	
}