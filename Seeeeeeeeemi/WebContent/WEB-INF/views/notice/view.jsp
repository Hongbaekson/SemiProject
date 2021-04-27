<%@page import="dto.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% Board board =(Board)request.getAttribute("viewBoard"); %>
<%@include file="/WEB-INF/views/layout/header.jsp" %>
<div class="inner">
	<h1>공지사항</h1>
	<div class="sub">
	새로운 소식과 공지사항을 알려드립니다. <br>
	더 궁금하신 사항은 고객센터(0000-0000)으로 문의하여 주세요.
	</div>
	<hr>
	
	<div class="noticeView">
		<p class="title"><%=board.getBoardTitle() %> </p>
		<p class="date"><%=board.getBoardCreateDate() %></p>
		<div class="content">
			<%=board.getBoardContent() %>
		</div>	
	</div>
	<hr>
	<a href="/notice/list" class="btn blue">목록으로</a>
</div>
<%@include file="/WEB-INF/views/layout/footer.jsp" %>