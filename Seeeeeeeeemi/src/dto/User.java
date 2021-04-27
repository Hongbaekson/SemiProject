package dto;

public class User {
	 private int userNo; 
	 private String userId;
	 private String userPw;
	 private String userName;
	 private String userGender;
	 private String userNick;
	 private String userBithdate;
	 private String userEmail;
	 private String userPhone;
	 private int userGrade;
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserGender() {
		return userGender;
	}
	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}
	public String getUserNick() {
		return userNick;
	}
	public void setUserNick(String userNick) {
		this.userNick = userNick;
	}
	public String getUserBithdate() {
		return userBithdate;
	}
	public void setUserBithdate(String userBithdate) {
		this.userBithdate = userBithdate;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	public int getUserGrade() {
		return userGrade;
	}
	public void setUserGrade(int userGrade) {
		this.userGrade = userGrade;
	}
	@Override
	public String toString() {
		return "Users [userNo=" + userNo + ", userId=" + userId + ", userPw=" + userPw + ", userName=" + userName
				+ ", userGender=" + userGender + ", userNick=" + userNick + ", userBithdate=" + userBithdate
				+ ", userEmail=" + userEmail + ", userPhone=" + userPhone + ", userGrade=" + userGrade + "]";
	}  
	 
	 
}
