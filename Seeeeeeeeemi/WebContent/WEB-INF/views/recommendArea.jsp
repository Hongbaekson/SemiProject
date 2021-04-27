<%@page import="dto.RoomImgReview"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% List<RoomImgReview> list = (List)request.getAttribute("list"); %>
<% List<RoomImgReview> poplist = (List)request.getAttribute("poplist"); %>
<% for(int i=0; i<list.size(); i++){ %>
<div class="col-md-3">
	<div class="box">
		<div>
			<a href="room/detail?room_no=<%=list.get(i).getRoomNo() %>">
				<img src="/resources/upload/<%=list.get(i).getRoomImgFilename() %>"/>
			</a>
		</div>
		<div>
			<div class="location"><%=list.get(i).getRoomRoadAddress() %> <%=list.get(i).getRoomDetailedAddress() %></div>
			<p class="text-bold"><%=list.get(i).getRoomName() %></p>
			<p class="meta small">
                     		<a>게스트 <%=list.get(i).getRoomGuests() %>명 
                     		* <%=list.get(i).getRoomType() %>
                     		* 침실 <%=list.get(i).getRoomBedroom() %>개  * <br> 
                     		 침대 <%=list.get(i).getRoomBed() %>개 
                     		* 욕실 <%=list.get(i).getRoomBathroom() %>개 </a>
                    	</p>
			<p><%=list.get(i).getRoomDesc() %></p>
			<div class="price"><%=list.get(i).getRoomPrice() %><small>원</small></div>
		</div>
	</div>
</div>
<%} %>