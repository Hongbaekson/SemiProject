<%@page import="dto.Bookmark"%>
<%@page import="dto.Room"%>
<%@page import="dto.RoomImg"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%	List<Map<String, Object>> bmList = (List<Map<String, Object>>) request.getAttribute("bookmarkList"); %>  
    
<%@include file="/WEB-INF/views/layout/header.jsp" %>

<!-- jq -->
<script type="text/javascript" src="/resources/js/jquery-2.2.4.min.js"></script>    
<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link href="/resources/css/mypage.css" rel="stylesheet">


<div id="mypage-nav">
	<ul>
		<li><a href="/mypage/user">계정설정</a></li>
		<li><a href="/mypage/booking">예약</a></li>
		<li><a href="/mypage/review">이용후기</a></li>
		<li><a href="/mypage/bookmark">숙소 북마크</a></li>
	</ul>
</div>


<div id="bookmark" class="inner container">

	<h1>북마크</h1>
	
	<%	for(int i=0; i<bmList.size(); i++) { %>
	<div class="bookmark col-xs-4 text-center">
		<div class="room-info">
			<img src="/getImg?filename=<%=((RoomImg)bmList.get(i).get("room_img")).getRoomImgFilename() %>" class="img-rounded img-thumbnail">
		</div>
<!-- 		<img src="/resources/img/room_img123.jpg" alt="room_img" class="img-rounded img-responsive"> -->
<%-- 		<div class="room-info"><%=((RoomImg)bmList.get(i).get("room_img")).getRoomImgFilename() %></div><br> --%>
		<div class="room-info"><%=((Room)bmList.get(i).get("room")).getRoomRoadAddress() %></div><br>
		<div class="room-info"><%=((Room)bmList.get(i).get("room")).getRoomDetailedAddress() %></div><br>
		<a href="/room/detail?room_no=<%=((Room)bmList.get(i).get("room")).getRoomNo() %>" class="btn text-center">숙소 상세 보기</a>
		<form action="/mypage/bookmark?bookmark_no=<%=((Bookmark)bmList.get(i).get("bookmark")).getBookmarkNo() %>" method="post">
			<button class="btn text-center">북마크 삭제</button>
		</form>
	</div>
	<%	} %><br>
</div>
<%@ include file="/WEB-INF/views/layout/myPageBookmarkPaging.jsp" %>



<%@include file="/WEB-INF/views/layout/footer.jsp" %>