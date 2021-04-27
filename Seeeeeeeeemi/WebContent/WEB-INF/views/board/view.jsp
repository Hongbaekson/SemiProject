<%@page import="dto.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% Board viewBoard = (Board)request.getAttribute("viewBoard"); %>
<%@include file="/WEB-INF/views/layout/header.jsp" %>
<script type="text/javascript">


$(function(){
   
    $('#btn_del').click(function(){
         if( <%=request.getSession().getAttribute("login") != null %> ){
        	 if( !<%=viewBoard.getUserNick().equals( request.getSession().getAttribute("usernick") )%> ){ 
	   	          alert("작성자만 지울수 있습니다");
	   	          $(this).removeAttr("href");
	   	       }
         }else{
        	 alert("로그인하세요!")
         }
      
    })
    
    $('#btn_update').click(function(){
    	if( !<%=viewBoard.getUserNick().equals( request.getSession().getAttribute("usernick")) %>){
    		alert("작성자만 수정가능합니다")
    		$(this).removeAttr("href")
    	}
    })
    
   
})
</script>

<div class="inner">
	<h1>상세보기</h1>
	<hr>
	<table class="table">
		<tr>
			<th>제목</th>
			<td colspan="3" style="text-align:left;"><%=viewBoard.getBoardTitle() %></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td style="text-align:left;"><%=viewBoard.getUserNick() %></td>
			<th>작성일</th>
			<td style="text-align:left;"><%=viewBoard.getBoardCreateDate() %></td>
		</tr>
		<tr>
			<td colspan="4" style="text-align:left; height:300px">
			<%=viewBoard.getBoardContent() %>
			</td>
		</tr>
	</table>
	<div class="clearfix mt10">
		<div style="float:right;">
			<a href="/board/update?boardno=<%=viewBoard.getBoardNo() %>" class="btn" id="btn_update">수정</a>
			<a href="/board/delete?boardno=<%=viewBoard.getBoardNo() %>" class="btn" id="btn_del">삭제</a>
		</div>
		<a href="/board/list" class="btn blue">목록</a>
	</div>
</div>	
<%@include file="/WEB-INF/views/layout/footer.jsp" %>
