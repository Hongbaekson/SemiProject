<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/admin/include/header.jsp" %>
<script type="text/javascript" src="/resources/js/jquery-2.2.4.min.js"></script>
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


<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">
	<!-- Preloader -->
  <div class="preloader flex-column justify-content-center align-items-center">
    <img class="animation__shake" src="/resources/admin/img/AdminLTELogo.png" alt="AdminLTELogo" height="60" width="60">
  </div>
  
  <%@include file="/WEB-INF/views/admin/include/sidemenu.jsp" %>
  
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-12">
            <h1 class="m-0">공지사항 쓰기</h1>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <section class="content">
     	<div class="container-fluid">
     		
     		<form action="/admin/notice/write" method="post">
				<input type="hidden" name="userno" value="<%=request.getSession().getAttribute("userno") %>">
				<table class="table table-bordered">
					<tr>
						<th>제목</th>
						<td colspan="3" style="text-align:left;">
							<input type="text" name="title" class="form-control" >
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
							<textarea  name="content" id="contents" class="form-control"></textarea>
						</td>
					</tr>
				</table>
				<div class="mt10">
					<button class="btn btn-primary" id="btnWrite">완료</button>
					<button type="button" class="btn btn-info" onclick="location.href='admin/notice/list'">취소</button>
				</div>
			</form>
     	</div>
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <strong>Copyright &copy; 2014-2021 <a href="https://adminlte.io">AdminLTE.io</a>.</strong>
    All rights reserved.
    <div class="float-right d-none d-sm-inline-block">
      <b>Version</b> 3.1.0
    </div>
  </footer>

  

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


<%@include file="/WEB-INF/views/admin/include/footer.jsp" %>