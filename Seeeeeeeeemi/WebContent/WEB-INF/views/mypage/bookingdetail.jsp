<%@page import="dto.RoomImg"%>
<%@page import="java.util.List"%>
<%@page import="dto.User"%>
<%@page import="dto.Booking"%>
<%@page import="dto.Room"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	Map<String, Object> map = (Map) request.getAttribute("detail"); %>
<% List<RoomImg> roomImgList = (List) request.getAttribute("roomImgList"); %>

<!-- <div class="col-md-6 rightImgBox" style="padding: 0;"> -->
<!-- 	<div class="roomImg img2"> -->
<%-- 		<img src="/upload/<%=roomImgList.get(1).getRoomImgFilename()%>" style="width: 100%; max-width: 760px; vertical-align: middle""> --%>

<%-- 		<% if(roomImgList.size() > 1) { %> --%>
<%-- 		<img src="/getImg?filename=<%=roomImgList.get(1).getRoomImgFilename()%>" style="width: 100%; max-width: 760px; vertical-align: middle"> --%>
<%-- 		<% } %> --%>
<!-- 	</div> -->
<!-- 	<div class="roomImg img3"> -->
<%-- 		<% if(roomImgList.size() > 2) { %> --%>
<%-- 		<img src="/getImg?filename=<%=roomImgList.get(2).getRoomImgFilename()%>" style="width: 100%; max-width: 760px; vertical-align: middle"> --%>
<%-- 		<% } %> --%>
<!-- 	</div> -->
<!-- 	<div class="roomImg img4"> -->
<%-- 		<% if(roomImgList.size() > 3) { %> --%>
<%-- 		<img src="/getImg?filename=<%=roomImgList.get(3).getRoomImgFilename()%>" style="width: 100%; max-width: 760px; vertical-align: middle"> --%>
<%-- 		<% } %> --%>
<!-- 	</div> -->
<!-- 	<div class="roomImg img5"> -->
<%-- 		<% if(roomImgList.size() > 4) { %> --%>
<%-- 		<img src="/getImg?filename=<%=roomImgList.get(4).getRoomImgFilename()%>" style="width: 100%; max-width: 760px; vertical-align: middle"> --%>
<%-- 		<% } %> --%>
<!-- 	</div> -->
<!-- </div>	 -->

<table class="table table-striped">
	<tr>
		<td>숙소이름</td><td><%=((Room)map.get("room")).getRoomName()%></td>
	</tr>
	<tr>
		<td>주소</td><td><%=((Room)map.get("room")).getRoomRoadAddress()%>  <%=((Room)map.get("room")).getRoomDetailedAddress() %></td>
	</tr>
	<tr>
		<td>예약날짜</td><td><%=((Booking)map.get("booking")).getBookingCheckin()%> ~ <%=((Booking)map.get("booking")).getBookingCheckout()%> </td>
	</tr>
	<tr>
		<td>게스트</td><td><%=((Booking)map.get("booking")).getBookingGuest()%></td>
	</tr>
	<tr>
		<td>호스트 전화번호</td><td><%=((User)map.get("host")).getUserPhone()%></td>
	</tr>
	<tr>
		<td>호스트 이메일</td><td><%=((User)map.get("host")).getUserEmail()%></td>
	</tr>
</table>
