<%@page import="dto.Room"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<% List<Room> list = (List)request.getAttribute("myRoomList"); %>

<style>
.subnav {
	width: 700px;
	margin: 20px auto;
	text-align: center;
}
.subnavelement {
	font-size: 20px;
	margin: 20px;
}
</style>
<div class="container" style="min-height: 1000px">
<div class="subnav">
	<span class="subnavelement" style="font-weight: bolder;">내가 등록한 숙소</span>
	<a href="/host/booking"><span class="subnavelement">예약 관리</span></a>
</div>
<h3>내가 등록한 숙소</h3>
<hr>
<a href="/host/write"><button id="roomRegister" class="btn btn-default">숙소등록</button></a>
<br>
<table class="table table-striped table-hover table-condensed" style="margin-top: 20px;">
		<tr>
			<th class="text-center" style="width: 10%;">숙소번호</th>
			<th class="text-center" style="width: 30%;">숙소명</th>
			<th class="text-center" style="width: 20%;">숙소유형</th>
			<th class="text-center" style="width: 20%;">최대숙박인원</th>
			<th class="text-center" style="width: 10%;">승인여부</th>
			<th class="text-center" style="width: 10%;">취소</th>
		</tr>
		<% for(int i=0; i<list.size(); i++) { %>
		<tr>
			<td class="text-center" ><%= list.get(i).getRoomNo() %></td>
			<td class="text-center"><a href="/host/roomview?roomno=<%= list.get(i).getRoomNo() %>"><%= list.get(i).getRoomName() %></a></td>
			<td class="text-center"><%= list.get(i).getRoomType() %></td>
			<td class="text-center"><%= list.get(i).getRoomGuests() %></td>
			<%if("W".equals( list.get(i).getRoomAdminCheck() ) ) { %>
			<td class="text-center">대기중</td>
			<% } else if("Y".equals( list.get(i).getRoomAdminCheck() ) ) { %>
			<td class="text-center" style="color: green">승인완료</td>
			<% } else if("N".equals( list.get(i).getRoomAdminCheck() ) ) { %>
			<td class="text-center" style="color: red">거절됨</td>
			<% } %>
			<td class="text-center"><a id="deleteLink" href="/host/roomdelete?roomno=<%= list.get(i).getRoomNo()%>" onclick="confirm('등록한 숙소를 삭제하시겠습니까?')">삭제</a></td>
		</tr>
		<% } %>
	</table>
</div><!-- .container -->


<%@ include file="/WEB-INF/views/layout/footer.jsp" %>