package dto;

public class Restaurant {
	private int resNo;
	private int regionNo;
	private int filterNo;
	private String resName;
	private String resPhone;
	private String resTime;
	private String resParking;
	private String resRoad;
	private String resDetail;
	private int imgCheck;
	


	@Override
	public String toString() {
		return "Restaurant [resNo=" + resNo + ", regionNo=" + regionNo + ", filterNo=" + filterNo + ", resName="
				+ resName + ", resPhone=" + resPhone + ", resTime=" + resTime + ", resParking=" + resParking
				+ ", resRoad=" + resRoad + ", resDetail=" + resDetail + ", imgCheck=" + imgCheck + "]";
	}


	public int getResNo() {
		return resNo;
	}


	public void setResNo(int resNo) {
		this.resNo = resNo;
	}


	public String getResName() {
		return resName;
	}


	public void setResName(String resName) {
		this.resName = resName;
	}


	public String getResPhone() {
		return resPhone;
	}


	public void setResPhone(String resPhone) {
		this.resPhone = resPhone;
	}


	public String getResTime() {
		return resTime;
	}


	public void setResTime(String resTime) {
		this.resTime = resTime;
	}


	public String getResParking() {
		return resParking;
	}


	public void setResParking(String resParking) {
		this.resParking = resParking;
	}


	public String getResRoad() {
		return resRoad;
	}


	public void setResRoad(String resRoad) {
		this.resRoad = resRoad;
	}


	public String getResDetail() {
		return resDetail;
	}


	public void setResDetail(String resDetail) {
		this.resDetail = resDetail;
	}


	public int getRegionNo() {
		return regionNo;
	}


	public void setRegionNo(int regionNo) {
		this.regionNo = regionNo;
	}


	public int getFilterNo() {
		return filterNo;
	}


	public void setFilterNo(int filterNo) {
		this.filterNo = filterNo;
	}


	public int getImgCheck() {
		return imgCheck;
	}


	public void setImgCheck(int imgCheck) {
		this.imgCheck = imgCheck;
	}


	
	
	
	
}	