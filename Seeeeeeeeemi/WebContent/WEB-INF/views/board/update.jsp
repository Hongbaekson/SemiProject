<%@page import="dto.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/layout/header.jsp" %>
<% Board viewBoard = (Board)request.getAttribute("viewBoard"); %>
<!-- 스마트에디터 2 -->
<script type="text/javascript"
 src="/resources/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
function submitContents( elClickedObj ) {
	
	//에디터의 내용을 #content에 반영한다
	oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
	
	try {
		// <form>태그의 submit 수행
		elClickedObj.form.submit();
	} catch(e) {}
	
}
</script>

<script type="text/javascript">
$(document).ready(function() {
	
	$("#btnWrite").click(function() {
		submitContents( $("#btnWrite") )
		$("form").submit();
	});
	
});
</script>
<div class="inner">
	<h1>수정하기</h1>
	<hr>
	<form action="/board/update" method="post">
		<input type="hidden" name="boardno" value="<%=viewBoard.getBoardNo() %>">
		<input type="hidden" name="userno" value="<%=request.getSession().getAttribute("userno") %>">
		<table class="table">
			<tr>
				<th>제목</th>
				<td colspan="3" style="text-align:left;">
					<input type="text" name="title" style="width:100%;box-sizing:border-box;" value="<%=viewBoard.getBoardTitle() %>">
				</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td style="text-align:left;">
					<%=request.getSession().getAttribute("usernick") %>
				</td>
			</tr>
			<tr>
				<td colspan="4" style="text-align:left;">
					<textarea  name="content" id="contents" style="width:100%;">
					<%=viewBoard.getBoardContent() %>
					</textarea>
				</td>
			</tr>
		</table>
		<div class="mt10">
			<button class="btn blue" id="btnWrite">완료</button>
			<button type="button" class="btn blue" onclick="location.href='/board/list'">취소</button>
		</div>
	</form>
</div>
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "contents", 
	sSkinURI: "/resources/se2/SmartEditor2Skin.html",
	fCreator: "createSEditor2"
})
</script>
<%@include file="/WEB-INF/views/layout/footer.jsp" %>