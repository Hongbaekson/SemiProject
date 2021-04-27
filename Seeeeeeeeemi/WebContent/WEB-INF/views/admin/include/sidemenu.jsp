<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="index3.html" class="brand-link">
      <img src="/resources/img/logo.png"  class="brand-image img-circle elevation-3">
      <span class="brand-text font-weight-light">관리자페이지</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          
          
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-copy"></i>
              <p>
                	회원관리
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="/admin/userlist" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>회원리스트</p>
                </a>
              </li>
            </ul>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-copy"></i>
              <p>
                	숙소관리
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="/admin/bookinglist" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>예약조회</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/admin/roomlist" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>숙소 승인관리</p>
                </a>
              </li>
            </ul>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-copy"></i>
              <p>
                	추천맛집관리 
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="/admin/restaurantlist" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>추천맛집 등록/삭제</p>
                </a>
              </li>
            </ul>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-copy"></i>
              <p>
                	리뷰관리
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="/admin/review/list" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>리뷰 조회/삭제</p>
                </a>
              </li>
            </ul>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-copy"></i>
              <p>
                	게시글관리
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="/admin/notice/list" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>공지 조회/등록/삭제</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/admin/board/list" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>자유게시판 조회/삭제</p>
                </a>
              </li>
            </ul>
          </li>
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>
