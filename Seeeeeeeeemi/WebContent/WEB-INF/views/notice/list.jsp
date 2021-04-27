<%@page import="web.util.Paging"%>
<%@page import="dto.Board"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% List<Board> list = (List)request.getAttribute("list"); %>
<% Paging paging = (Paging)request.getAttribute("paging"); %>
<%@include file="/WEB-INF/views/layout/header.jsp" %>
<div class="inner">
	<h1>공지사항</h1>
	<div class="sub">
	새로운 소식과 공지사항을 알려드립니다. <br>
	더 궁금하신 사항은 고객센터(0000-0000)으로 문의하여 주세요.
	</div>
	<hr>
	<div class="noticeWrap">
		<% for(int i=0; i<list.size();i++){ %>
		<dl>
			<dt><a href="/notice/view?boardno=<%=list.get(i).getBoardNo() %>"><%=list.get(i).getBoardTitle() %></a></dt>
			<dd><%=list.get(i).getBoardContent() %></dd>
			<dd><%=list.get(i).getBoardCreateDate() %></dd>
		</dl>
		<%} %>	
	</div>
	<div class="text-center mt10">
		<ul class="pagination">
			
			<% if(paging.getCurPage()>1){ %>
			<li><a href="/notice/list?curpage=<%=paging.getCurPage()-1 %>">&lt; </a></li>
			<% } %>
			
			<% for(int i=paging.getStartPage(); i<=paging.getEndPage(); i++ ){ %>
				<% if(i==paging.getCurPage()){ %>
				<li class="active"><a href="/notice/list?curpage=<%=i%>"><%=i%></a></li>
				<%}else{ %>
				<li><a href="/notice/list?curpage=<%=i%>"><%=i%></a></li>
				<%} %>
			<%} %>
			
			<% if(paging.getTotalPage() !=paging.getCurPage()){ %>
			<li><a href="/notice/list?curpage=<%=paging.getCurPage()+1%>">&gt;</a>
			<% } %>
		</ul>
	</div>
</div>
<%@include file="/WEB-INF/views/layout/footer.jsp" %>