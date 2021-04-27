package util;

public class BookingPaging {
	private int curPage;//현재 페이지의 번호
	private int totalCount;//총 게시글 수
	private int listCount;//한 페이지당 보여질 게시글의 수
	private int totalPage;//총 페이지 수
	private int pageCount;//한 화면에서 출력될 페이지네이션의 수
	private int startPage;//화면에 보이는 페이지네이션의 시작 번호
	private int endPage;//화면에 보이는 페이지네이션의 끝 번호
	private int startNo;//화면에 보이는 게시글의 시작 번호
	private int endNo;//화면에 보이는 게시글의 끝 번호
	
	public BookingPaging(int totalCount) {
		setTotalCount(totalCount);
		
		makePaging();
	}
	
	// 총게시글수, 현재페이지번호를 입력하는 생성자
	public BookingPaging(int totalCount, int curPage) {
		setTotalCount(totalCount);
		setCurPage(curPage);
		
		makePaging();
	}
	
	// 총게시글수, 현재페이지번호, 보여질 게시글 수를 입력하는 생성자
	public BookingPaging(int totalCount, int curPage, int listCount) {
		setTotalCount(totalCount);
		setCurPage(curPage);
		setListCount(listCount);
		makePaging();
	}
	
	// 총게시글수, 현재페이지번호, 보여질 게시글 수, 보여질 페이지수를 입력하는 생성자
	public BookingPaging(int totalCount, int curPage, int listCount, int pageCount) {
		setTotalCount(totalCount);
		setCurPage(curPage);
		setListCount(listCount);
		setPageCount(pageCount);
		makePaging();
	}
	
	
	//페이징 정보를 생성하는 메소드
	private void makePaging() {
		if( totalCount == 0) return; //게시글이 없는 경우 중단한다.
		
		//기본값 설정
		if(curPage == 0) setCurPage(1); //첫 페이지를 기본 페이지로 설정
		if(pageCount == 0) setPageCount(5); //화면에 보여질 페이지 수 기본 설정
		if(listCount == 0) setListCount(10); //화면에 보여질 게시글 수 기본 설정
		
		//총 페이지 수 계산
		totalPage =  totalCount / listCount;
		if(totalCount % listCount > 0) totalPage++;
		
		//보정작업) 현재페이지(curPage)가 총 페이지(totalPage)보다 크게 입력된 경우 강제로 마지막 페이지로 고정시킨다.
		if(totalPage < curPage) curPage = totalPage;
		
		//화면에 보여질 페이지네이션의 시작번호와 끝번호
		startPage = ( (curPage-1)/pageCount ) * pageCount + 1;
		endPage = startPage + pageCount -1;
		
		//보정작업) endPage가 totalPage보다 큰 경우 강제로 최종 페이지까지만 보이도록 설정
		if( endPage > totalPage ) endPage = totalPage;
		
		//화면에 보여질 시작번호, 끝번호
		startNo = (curPage-1) * listCount + 1;
		endNo = curPage * listCount; 
	}
	
	@Override
	public String toString() {
		return "Paging [curPage=" + curPage + ", totalCount=" + totalCount + ", listCount=" + listCount + ", totalPage="
				+ totalPage + ", pageCount=" + pageCount + ", startPage=" + startPage + ", endPage=" + endPage
				+ ", startNo=" + startNo + ", endNo=" + endNo + "]";
	}
	
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getListCount() {
		return listCount;
	}
	public void setListCount(int listCount) {
		this.listCount = listCount;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getPageCount() {
		return pageCount;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getStartNo() {
		return startNo;
	}
	public void setStartNo(int startNo) {
		this.startNo = startNo;
	}
	public int getEndNo() {
		return endNo;
	}
	public void setEndNo(int endNo) {
		this.endNo = endNo;
	}
	
	
}
