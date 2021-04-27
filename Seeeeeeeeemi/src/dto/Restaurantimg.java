package dto;

public class Restaurantimg {
	
	private int resimgNo; 
	private int restaurantNo;
	private String resFilename;
	
	@Override
	public String toString() {
		return "Restaurantimg [resimgNo=" + resimgNo + ", restaurantNo=" + restaurantNo + ", resFilename=" + resFilename
				+ "]";
	}
	public int getResimgNo() {
		return resimgNo;
	}
	public void setResimgNo(int resimgNo) {
		this.resimgNo = resimgNo;
	}
	public int getRestaurantNo() {
		return restaurantNo;
	}
	public void setRestaurantNo(int restaurantNo) {
		this.restaurantNo = restaurantNo;
	}
	public String getResFilename() {
		return resFilename;
	}
	public void setResFilename(String resFilename) {
		this.resFilename = resFilename;
	}
	
	
}
