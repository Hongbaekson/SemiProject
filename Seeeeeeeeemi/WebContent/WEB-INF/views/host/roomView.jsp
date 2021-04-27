<%@page import="dto.RoomFacilityMapping"%>
<%@page import="dto.RoomImg"%>
<%@page import="java.util.List"%>
<%@page import="dto.Room"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<% Room roomView = (Room) request.getAttribute("roomView"); %>
<% List<RoomImg> roomImgList = (List) request.getAttribute("roomImgList"); %>
<% List<String> roomFacList = (List) request.getAttribute("roomFacList"); %>

<script type="text/javascript">
$(document).ready(function() {

	//수정버튼 동작
	$("#btnUpdate").click(function() {
		$(location).attr("href", "/host/roomupdate?roomno=<%=roomView.getRoomNo() %>");
	});
	//삭제버튼 동작
	$("#btnDelete").click(function() {
		if( confirm("숙소를 삭제하시겠습니까?") ) {
			$(location).attr("href", "/host/roomdelete?roomno=<%=roomView.getRoomNo() %>");
		}
	});
	//목록버튼 동작
	$("#btnList").click(function() {
		$(location).attr("href", "/host/roomlist");
	});
	
	//관리자 승인 표시 설정
	var adminStatus = '<%=roomView.getRoomAdminCheck() %>';
	console.log(adminStatus);
	if(adminStatus == 'W') {
		$(".waiting").css("background-color", "orange");
		$(".noticetext").html("관리자승인 대기중인 숙소입니다. 승인완료가 되면 메뉴탭>예약관리에서 숙소예약을 관리할 수 있습니다.<hr>").css("color", "orange");
	} else if(adminStatus == 'Y'){
		$(".complete").css("background-color", "green");
		$(".noticetext").html("관리자의 승인을 받은 숙소입니다. 예약관리에서 숙소예약을 관리할 수 있습니다.<hr>").css("color", "green");
	} else if(adminStatus == 'N') {
		$(".refuse").css("background-color", "red");
		$(".noticetext").html("관리자 승인거절된 숙소입니다. 숙소게시글을 다시 작성해주세요.<hr>").css("color", "red");
	}
	
});
</script>
<style>
.indicator {
	position: relative;
	height: 70px;
}
.indicator-innerLeft{
	position: absolute;
	display: inline-block;
	float: left;
	width: 200px;
}
.indicator-innerRight{
	position: absolute;
	display: inline-block;
	right: 0;
	width: 100px;
	margin: 20px 0;
}
#btnUpdate {
	right: 240px;
}
#btnDelete {
	right: 120px;
}
.notification {
	display: inline-block;
	color: white;
	border-radius: 30px;
	padding-right: 10px;
	padding-left: 10px;
	margin: 0 5px 5px 5px;
}
.waiting {
	background-color: #ccc;
}
.complete {
	background-color: #ccc;
}
.refuse {
	background-color: #ccc;
}
.imgBox {
	position: relative;
}
.roomImg {
	display: inline-block;
	float: left;
}
.leftImgBox {
	height: 500px;
}
.rightImgBox {
	height: 500px;
}
.img1 {
	width: 100%;
	height: 100%;
	
}
.img2, .img3, .img4, .img5 {
	width: 50%;
	height: 50%;
	float: left;
}
.roomImg > img {
	width: 100%;
	height: 100%;
}
</style>
<div class="container" style="min-height: 1000px">
<div class="indicator">
	<div class="indicator-innerLeft">
		<h3>숙소 상세보기</h3>
	</div>
	<% if( request.getSession().getAttribute("login") !=null ){ %>
		<% if( (Integer)request.getSession().getAttribute("userno") == roomView.getUserNo() ){ %>
			<button id="btnDelete" class="btn btn-default indicator-innerRight">삭제하기</button>
			<button id="btnUpdate" class="btn btn-default indicator-innerRight">수정하기</button>
		<% } %>
	<%} %>
	<button id="btnList" class="btn btn-default indicator-innerRight">목록으로</button>	
</div>
<!-- 관리자 승인 여부  -->
<div class="adminCheck">
	<div class="notification waiting">대 기 중</div>
	<div class="notification complete">승 인 완 료</div>
	<div class="notification refuse">승 인 거 절</div>
</div>
<div class="notice">
	<span class="noticetext"></span>
</div>

<!-- 이미지 5장  -->
<div class="imgBox">
	<div class="row">
		<div class="col-md-6 leftImgBox" style="padding: 0;">
			<div class="roomImg img1">
				<% if(roomImgList.size() > 0) {%>
				<img src="/getImg?filename=<%=roomImgList.get(0).getRoomImgFilename()%>">
				<% } %>
			</div>
		</div>
		<div class="col-md-6 rightImgBox" style="padding: 0;">
			<div class="roomImg img2">
				<% if(roomImgList.size() > 1) { %>
				<img src="/getImg?filename=<%=roomImgList.get(1).getRoomImgFilename()%>" style="width: 100%; max-width: 760px; vertical-align: middle">
				<% } %>
			</div>
			<div class="roomImg img3">
				<% if(roomImgList.size() > 2) { %>
				<img src="/getImg?filename=<%=roomImgList.get(2).getRoomImgFilename()%>" style="width: 100%; max-width: 760px; vertical-align: middle">
				<% } %>
			</div>
			<div class="roomImg img4">
				<% if(roomImgList.size() > 3) { %>
				<img src="/getImg?filename=<%=roomImgList.get(3).getRoomImgFilename()%>" style="width: 100%; max-width: 760px; vertical-align: middle">
				<% } %>
			</div>
			<div class="roomImg img5">
				<% if(roomImgList.size() > 4) { %>
				<img src="/getImg?filename=<%=roomImgList.get(4).getRoomImgFilename()%>" style="width: 100%; max-width: 760px; vertical-align: middle">
				<% } %>
			</div>
		</div>			
	</div>
</div>

<!-- 숙소 정보 -->
<div class="roomInfo">
	<h2><span><%= roomView.getRoomName() %></span></h2><br>
	<span>최대 인원 <%=roomView.getRoomGuests() %>명 · </span> 
	<span><%= roomView.getRoomType() %> · </span>
	<span>침실 <%= roomView.getRoomBedroom() %>개 · </span>
	<span>침대/침구류 <%= roomView.getRoomBed() %>개 · </span>
	<span>욕실 <%= roomView.getRoomBathroom() %>개</span>
	<hr>
	<h3>숙소설명</h3>
	<p><%= roomView.getRoomDesc().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">",  "&gt;").replaceAll("\n", "<br>") %></p>
	<hr>
	<h3>편의시설</h3>
	<% for(int i=0; i<roomFacList.size(); i++) { %>
		<% if( i == (roomFacList.size()-1) ) { %>
			<span><%=roomFacList.get(i) %></span>
		<% continue; } %>
		<span><%=roomFacList.get(i) %> · </span>
	<% } %>
	<hr>
	<h3>1박 비용</h3>
	<span><%=roomView.getRoomPrice() %>원</span>
	<hr>
	<h3>위치</h3>
	<span><%=roomView.getRoomRoadAddress() %></span> <span> <%=roomView.getRoomDetailedAddress() %></span>
	<br><br><br>
	
</div>

</div>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>