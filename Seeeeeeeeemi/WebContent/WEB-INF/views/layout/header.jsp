<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일루와</title>



<link href="/resources/css/common.css" rel="stylesheet">
<link href="/resources/css/style.css" rel="stylesheet">


 
<script type="text/javascript" src="/resources/js/jquery-2.2.4.min.js"></script>



<link href="/resources/css/common.css" rel="stylesheet"> 
<link href="/resources/css/search.css" rel="stylesheet"> 
<link href="/resources/css/datepicker.css" rel="stylesheet"> 
<link href="/resources/css/roomList.css" rel="stylesheet"> 

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 <!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">




<script>
	$(function(){
		/*네비*/
		$('.dropmenu').hover(function(){
			$(this).children('ol').toggleClass('open')
		})
		/*마이페이지버튼*/
		$('.mypage_tooltip>a').click(function(){
			$(this).next('ol').toggleClass('open')
		})
	})
</script>
</head>
<body>
<div id="header">
	<div class="inner">
		<a href="/" class="logo"><img src="/resources/img/logo.png" alt="logo"></a>
		<ul>
			<li><a href="/room/search">숙소예약</a></li>
			<li><a href="/restaurant/search">추천맛집</a></li>
			<li class="dropmenu">
				<a href="javascript:;">커뮤니티</a>
				<ol>
					<li><a href="/notice/list">공지사항</a></li>
					<li><a href="/board/list">자유게시판</a></li>
				</ol>
			</li>
		</ul>
		<div class="rgtmenu">
			<a href="/host/write">호스트되기</a>
			<div class="mypage_tooltip">
				<a href="#">
					<div class="hamburger_w">
						<div class="hamburger" id="hamburger-7">
							<span class="line"></span>
							<span class="line"></span>
							<span class="line"></span>
						</div>
					</div>
					<script type="text/javascript">
					$(document).ready(function () {
					  $(".hamburger_w").click(function () {
					    $(this).children().toggleClass("is-active");
					  });
					});
					</script>
				</a>
				<ol>
					<% if( request.getSession().getAttribute("login") !=null ){ %>	
						<% if( (Integer)request.getSession().getAttribute("usergrade")==2   ){ %>			
						<%-- 호스트일때 --%>
						<li><a href="/mypage/user">계정관리</a></li>
						<li><a href="/mypage/booking">예약</a></li>
						<li><a href="/mypage/review">이용후기</a></li>
						<li><a href="/mypage/bookmark">북마크한 숙소</a></li>
						<li><a href="/host/roomlist">내가 등록한 숙소</a></li>
						<li><a href="/host/booking">예약관리</a></li>
						<li><a href="/logout">로그아웃</a></li>
						<%}else{ %>
						<li><a href="/mypage/user">계정관리</a></li>
						<li><a href="/mypage/booking">예약</a></li>
						<li><a href="/mypage/review">이용후기</a></li>
						<li><a href="/mypage/bookmark">북마크한 숙소</a></li>
						<li><a href="/host/roomlist">내가 등록한 숙소</a></li>
						<li><a href="/logout">로그아웃</a></li>	
						<%} %>
					<% }else{ %>
					<li><a href="/login">로그인</a></li>
					<li><a href="/join">회원가입</a></li>
					<%} %>
				</ol>
			</div>
		</div>
	</div>
</div>
<div id="content">