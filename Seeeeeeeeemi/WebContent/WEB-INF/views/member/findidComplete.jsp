<%@page import="dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% User user = (User)request.getAttribute("userid"); %>
<%@include file="/WEB-INF/views/layout/header.jsp" %>
<div class="inner">
	<h1>당신의 아이디는?</h1>
	<h1> <%=user.getUserId() %>  </h1>
	<a href="/login">로그인화면으로 가기</a>
	<a href="/find/pw">비밀번호 찾기</a>
</div>
<%@include file="/WEB-INF/views/layout/footer.jsp" %>