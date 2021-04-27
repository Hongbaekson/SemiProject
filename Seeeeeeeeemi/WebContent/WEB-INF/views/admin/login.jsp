<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/admin/include/header.jsp" %>
	<h1>관리자 로그인</h1>
<body class="hold-transition login-page">
<div class="login-box">
  <div class="login-logo">
    <a href="../../index2.html"><b>일루와</b></a>
  </div>
  <!-- /.login-logo -->
  <div class="card">
    <div class="card-body login-card-body">
      <form action="/admin/login" method="post">
        <div class="input-group mb-3">
          <input type="type" class="form-control" placeholder="Id" name="uid">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
        <div class="input-group mb-3">
          <input type="password" class="form-control" placeholder="Password" name="upw">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
        <div class="row">
          <!-- /.col -->
          <div class="col-12">
            <button type="submit" class="btn btn-primary btn-block">Sign In</button>
          </div>
          <!-- /.col -->
        </div>
      </form>

      <div class="social-auth-links text-center mb-3">
        <p>- OR -</p>
        <a href="/" class="btn btn-block btn-primary">
          <i class="fab fa-waze mr-2"></i> 일루와 홈으로 가기
        </a>
        <a href="/find/id" class="btn btn-block btn-danger">
          <i class="fab fa-whmcs mr-2"></i> 아이디 비번찾기 
        </a>
      </div>
    </div>
    <!-- /.login-card-body -->
  </div>
</div>
<!-- /.login-box -->



<%@include file="/WEB-INF/views/admin/include/footer.jsp" %>