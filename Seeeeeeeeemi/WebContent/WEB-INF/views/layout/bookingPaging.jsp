<%@page import="util.BookingPaging"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 페이지네이션 -->
<div class="text-center">
	<ul class="pagination pagination-sm">
		
		<!-- 첫페이지로 이동 -->
		
		<li><a href="/host/booking">처음으로</a></li>
		
		<!-- 이전 페이징 리스트로 가기 -->
		<% if(paging.getStartPage() > paging.getPageCount()) { %>
		<li><a href="/host/booking?curPage=<%=paging.getStartPage() - paging.getPageCount() %>">&laquo;</a></li>
		<% } else { %>
		<li class="disabled"><a>&laquo;</a></li>
		<% } %>
		
		<!-- 이전 페이지로 가기 -->
		<% if(paging.getCurPage() != 1) { %>
		<li><a href="/host/booking?curPage=<%=paging.getCurPage() - 1 %>">&lt;</a></li>
		<% } else {%>
		<li class="disabled"><a>&lt;</a></li>
		<% } %>
		
		<% for(int i=paging.getStartPage(); i<=paging.getEndPage(); i++) { %>
			<% if( i == paging.getCurPage() ) {%>
		<li class="active"><a><%=i %></a></li>
			<% } else {%>
		<li><a href="/host/booking?curPage=<%=i %>"><%=i %></a></li>
			<% } %>
		<% } %>
		
		<!-- 다음페이지로 가기 -->
		<% if(paging.getCurPage() != paging.getTotalPage()) { %>
		<li><a href="/host/booking?curPage=<%=paging.getCurPage() + 1 %>">&gt;</a></li>
		<% } else { %>
		<li class="disabled"><a>&gt;</a></li>
		<% } %>
		
		<!-- 다음페이지 리스트로 가기 -->
		<% if(paging.getStartPage() + paging.getPageCount() < paging.getTotalPage() ) {%>
		<li><a href="/host/booking?curPage=<%=paging.getStartPage() + paging.getPageCount() %>">&raquo;</a></li>
		<% } else { %>
		<li class="disabled"><a>&raquo;</a></li>
		<% } %>
		<!-- 마지막페이지로 이동 -->
		
		<li><a href="/host/booking?curPage=<%=paging.getTotalPage() %>">끝으로</a></li>
		
		
	</ul>
</div>