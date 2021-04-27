<%@page import="web.util.Paging"%>
<%@page import="dto.Board"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% List<Board> list = (List)request.getAttribute("list"); %>
<% Paging paging = (Paging)request.getAttribute("paging"); %>   
<%@include file="/WEB-INF/views/layout/header.jsp" %>

<script type="text/javascript">


$(function(){
   
    $('#btn_write').click(function(){
         if( <%=request.getSession().getAttribute("login") == null %> ){
        	 alert("로그인하세요!")
         }
      
    })
   
})
</script> 
<div class="inner">
	<h1>자유게시판</h1>
	<hr>
	<table class="table">
		<tr>
			<th width="5%">번호</th>
			<th width="55%">제목</th>
			<th width="15%">글쓴이</th>
			<th width="15%">날짜</th>
		</tr>
		<% for(int i=0; i<list.size(); i++){ %>
		<tr>
			<td><%=list.get(i).getBoardNo() %></td>
			<td style="text-align:left;">
				<a href="/board/view?boardno=<%=list.get(i).getBoardNo() %>">
				<%=list.get(i).getBoardTitle() %>
				</a>
			</td>
			<td><%=list.get(i).getUserNick() %></td>
			<td><%=list.get(i).getBoardCreateDate() %></td>
		</tr>	
		<% } %>
	</table>
	<a href="/board/write" class="btn blue mt10" id="btn_write">쓰기</a>
	<div class="text-center">
		<ul class="pagination">
			
			<% if(paging.getCurPage()>1){ %>
			<li><a href="/board/list?curpage=<%=paging.getCurPage()-1 %>">&lt; </a></li>
			<% } %>
			
			<% for(int i=paging.getStartPage(); i<=paging.getEndPage(); i++ ){ %>
				<% if(i==paging.getCurPage()){ %>
				<li class="active"><a href="/board/list?curpage=<%=i%>"><%=i%></a></li>
				<%}else{ %>
				<li><a href="/board/list?curpage=<%=i%>"><%=i%></a></li>
				<%} %>
			<%} %>
			
			<% if(paging.getTotalPage() !=paging.getCurPage()){ %>
			<li><a href="/board/list?curpage=<%=paging.getCurPage()+1%>">&gt;</a>
			<% } %>
		</ul>
	</div>
	
	
</div>
<%@include file="/WEB-INF/views/layout/footer.jsp" %>