<%@ page import="dto.Room" %>
  <%@ page import="dto.RoomImg" %>
  <%@ page import="dto.Review" %>
    <%@ page import="java.util.List" %>
    <%@page import="web.util.ReviewPaging"%>
      <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <% Room room = (Room)request.getAttribute("room"); %>
          <% List<RoomImg> roomImgList= (List)request.getAttribute("roomImgList"); %>
            <% List<Review> reviewList = (List)request.getAttribute("reviewList");  %>
              <% ReviewPaging paging = (ReviewPaging)request.getAttribute("paging"); %>
              <% List<String> reviewUser = (List)request.getAttribute("reviewUser"); %>
              <% List<Review> allReview = (List)request.getAttribute("allReview"); %>
              <% List<String> roomFacList= (List)request.getAttribute("roomFacList"); %>
            <%@include file="/WEB-INF/views/layout/header.jsp" %>

              <script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
              <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
              <script src="/resources/js/httpRequest.js"></script>
				
			  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">

              <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>

              <link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet"
                id="bootstrap-css">
              <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>

              <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet"
                id="bootstrap-css" />
            <style>
            	#header ul>li>a,#header .mypage_tooltip>ol>li>a{color:#337ab7}
                .b-0 {
                  bottom: 0;
                }

                .bg-shadow {
                  background: rgba(76, 76, 76, 0);
                  background: -webkit-gradient(left top, left bottom, color-stop(0%, rgba(179, 171, 171, 0)), color-stop(49%, rgba(48, 48, 48, 0.37)), color-stop(100%, rgba(19, 19, 19, 0.8)));
                  background: linear-gradient(to bottom, rgba(179, 171, 171, 0) 0%, rgba(48, 48, 48, 0.71) 49%, rgba(19, 19, 19, 0.8) 100%);
                  filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#4c4c4c', endColorstr='#131313', GradientType=0);
                }

                .overflow {
                  position: relative;
                  overflow: hidden;
                }

                .zoom img {
                  transition: all 0.2s linear;
                }

                .zoom:hover img {
                  -webkit-transform: scale(1.1);
                  transform: scale(1.1);
                }

                .star-box {
                  /* 별과 별 사이 공백 제거 */
                  font-size: 0;
                }

                .star {
                  /* width,height 적용가능하도록 변경 */
                  display: inline-block;

                  /* 별이 표현되는 영역 크기 */
                  width: 15px;
                  height: 30px;

                  /* 투명한 별 표현 */
                  background-image: url(/resources/img/empty.png);
                  background-repeat: no-repeat;
                  background-size: 200%;
                }

                .star_left {
                  /* 왼쪽 별 */
                  background-position: 0 0;
                }

                .star_right {
                  /* 오른쪽 별 */
                  background-position: 100% 0;
                }

                .on {
                  /* 채워진 별로 이미지 변경 */
                  background-image: url(/resources/img/star.png);
                }
			       *{
			       box-sizing:border-box;
						}
					
					body{
					  font-size:16px;
					  font-family: 'Poppins', sans-serif;
					}
					img{
					  max-width:100%;
					  display:block;
					}
					p{
					  margin:0;
					}
					.fa.fa-star{
					  color:#FEC902;
					}
					label{
					  width:15%;
					  margin:10px 1% 0 0;
					  display:inline-block;
					  float:left;
					}
					input[type="text"]{
					  width:84%;
					  margin:10px 0;
					  height:40px;
					  border:none;
					  background:#F6F6F6;
					  padding:1em;
					}
					textarea{
					  width:84%;
					  border:none;
					  background:#F6F6F6;
					  margin:10px 0;
					  height:100px;
					  padding:1em;
					}
					button{
					  float:right;
					  width:20%;
					  height:40px;
					  border:none;
					  background:#2ecc71;
					  font-size:16px;
					  color:white;
					}
					.review{
					  width:100%;
					  display:inline-block;
					  margin:10px 0;
					}
					.review-photo{
					  height:80px;
					  width:80px;
					  display:inline-block;
					  float:left;
					  margin-right:3em;
					}
					.review-box{
					  float:left;
					  display:inline-block;
					  width:87.5%;
					  background:#F6F6F6;
					  padding:1.5em;
					  position: relative;
					}
					.review-box:after, .review-box:before {
						right: 100%;
						top: 10%;
						border: solid transparent;
						content: " ";
						height: 0;
						width: 0;
						position: absolute;
						pointer-events: none;
					}
					.review-box:after {
						border-right-color: #F6F6F6;
						border-width: 25px;
					}
					.review-comment{
					  color:#9A9999;
					}
					.review-date{
					  color:#C7C7C7;
					  margin-bottom:20px;
					  
					}
					.review-author{
					  color:#C7C7C7;
					  margin-top :50px;
					  
					}
					.review-author strong{
					  color:black;
					}
					.purple-border textarea {
					    border: 1px solid #ba68c8;
					}
					.purple-border .form-control:focus {
					    border: 1px solid #ba68c8;
					    box-shadow: 0 0 0 0.2rem rgba(186, 104, 200, .25);
					}


						#comments .media {
							border-top:1px dashed #DDDDDD;
							padding:20px 0;
							margin:0;
						}
						
						#comments .media > .pull-left {
						    margin-right:20px;
						}
						
						#comments .media img {
							max-width:100px;
						}
						
						#comments .media h4 {
							margin:0 0 10px;
						}
						
						#comments .media h4 span {
							font-size:14px;
							float:right;
							color:#999999;
						}
						
						#comments .media p {
							margin-bottom:15px;
							text-align:justify;
						}
						
						#comments .media-detail {
							margin:0;
						}
						
						#comments .media-detail li {
							color:#AAAAAA;
							font-size:12px;
							padding-right: 10px;
							font-weight:600;
						}
						
						#comments .media-detail a:hover {
							text-decoration:underline;
						}
						
						#comments .media-detail li:last-child {
							padding-right:0;
						}
						
						#comments .media-detail li i {
							color:#666666;
							font-size:15px;
							margin-right:10px;
							
						
						}
						
						.bookmarkbtn {
						margin-right :5px;
						}
						.bookmarkbtn:hover {
							background-color: skyblue;
						}
						.bookingbtn:hover{
						background-color: skyblue;
						
						}

              </style>
              <script>
                function ajaxToServer() {


                  //전달 파라미터 준비 
                  var params = "reContent=" + document.f.reContent.value;

                  //AJAX 요청

                  sendRequest("POST", "/room/detail", params, ajaxFromServer);


                }


                function ajaxFromServer() {
                  if (httpRequest.readyState == 4) {
                    // Done 응답완료
                    if (httpRequest.status == 200) {
                      // ok  정상응답
                      console.log("정상 응답");

                      console.log(httpRequest.responseText)

                      submitComment();



                    } else {
                      console.log("AJAX 요청/응답 에러");
                    }
                  }
                }



                function dateToString(date) {
                  const dateString = date.toISOString();
                  const dateToString = dateString.substring(0, 10) + " " + dateString.substring(11, 19);
                  return dateToString;
                }

                function submitComment() {
                  const newcommentEL = document.getElementById("new-comment");
                  const newcomment = newcommentEL.value.trim();

                  if (newcomment) {
                    const dateEL = document.createElement("div");
                    dateEL.classList.add("comment-date");
                    const dateString = dateToString(new Date());
                    dateEL.innerText = dateString;

                    const contentEL = document.createElement("div");
                    contentEL.classList.add("comment-content");
                    contentEL.innerText = newcomment;

                    const commentEL = document.createElement("div");
                    commentEL.classList.add("comment-row");
                    commentEL.appendChild(dateEL);
                    commentEL.appendChild(contentEL);

                    document.getElementById("comments").appendChild(commentEL);
                    newcommentEL.value = "";

                    const countEL = document.getElementById("comments-count");
                    const count = countEL.innerText;
                    count.innerText = parseInt(count) + 1;
                  } else {
                    alert("내용을 입력하세요.");
                  }
                }
              </script>

              <script type="text/javascript">
                //별 선택 위치 변수
                var idx = -1;
                $(document).ready(function () {

                  //별 클릭 이벤트
                  $(".star").click(function () {
                    //클릭된 별이 몇 번째 칸인지 알아내기
                    idx = $(this).index();

                    //모두 투명하게 만들기
                    $(".star").removeClass("on")

                    //클릭이 된 곳까지 채워진 별로 만들기
                    for (var i = 0; i <= idx; i++) {
                      $(".star").eq(i).addClass("on");
                    }

                    //선택한 별점 숫자를 클릭위치값으로 고정
                    showStarValue(idx);

                  })

                  //마우스를 올리면 별 채워지기
                  var hover_idx = -1;
                  $(".star").mouseover(function () {
                    //클릭된 별이 몇 번째 칸인지 알아내기
                    hover_idx = $(this).index();

                    //모두 투명하게 만들기
                    $(".star").removeClass("on")

                    //클릭이 된 곳까지 채워진 별로 만들기
                    for (var i = 0; i <= hover_idx; i++) {
                      $(".star").eq(i).addClass("on");
                    }

                    //선택한 별점 숫자를 마우스움직임에 따라 변경
                    showStarValue(hover_idx);

                  })

                  //마우스를 떼면 클릭된 값으로 초기화시키기
                  $(".star").mouseout(function () {

                    //별점 숫자를 클릭된 값으로 초기화
                    showStarValue(idx);

                    //모두 투명하게 만들기
                    $(".star").removeClass("on")

                    //클릭이 된 곳까지 채워진 별로 만들기
                    for (var i = 0; i <= idx; i++) {
                      $(".star").eq(i).addClass("on");
                    }

                  })
                })

                //별 선택 값을 숫자로 보여주는 함수
                function showStarValue(val) {
                  if (val < 0) {
                    val = 0;
                  } else {
                    val = (val + 1) / 2;
                  }

                  $(".star-value").html(val);
                  document.getElementById("starValue").value = val;
                }
              </script>


<div class="inner">



              <div class="container">
	   			<br>	
                <h1><%=room.getRoomName() %></h1>
              
              </div>


              <hr>

              <div class="container">
                <!--Start code-->
                <div class="row">
                  <div class="col-12 pb-5">
                    <div id="featured" class="carousel slide carousel" data-ride="carousel">
                      <!--carousel inner-->
                      <div class="carousel-inner">
                        <div class="carousel-item active">
                          <div class="row">
                            <!--Start slider news-->
                            <div class="col-12 col-md-6 pb-0 pb-md-3 pt-2 pr-md-1">
                              <div class="card border-0 rounded-0 text-light overflow zoom">
                                <div class="position-relative">
                                  <!--thumbnail img-->
                                  <div class="ratio_left-cover-1 image-wrapper">
                                    <% if(roomImgList.size()> 0) {%>
                                      <img src="/getImg?filename=<%=roomImgList.get(0).getRoomImgFilename()%>"
                                        alt="thumbnail">
                                      <% } %>
                                  </div>
                                  <div class=" position-absolute p-2 p-lg-3 b-0 w-100 bg-shadow"></div>
                                </div>
                              </div>
                            </div>
                            <!--End slider news-->

                            <!--Start box news-->
                            <div class="col-12 col-md-6 pt-2 pl-md-1 mb-3 mb-lg-4">
                              <div class="row">
                                <!--news box-->
                                <div class="col-6 pb-1 pt-0 pr-1">
                                  <div class="card border-0 rounded-0 text-white overflow zoom">
                                    <div class="position-relative">
                                      <!--thumbnail img-->
                                      <div class="ratio_right-cover-2 image-wrapper">
                                        <% if(roomImgList.size()> 1) {%>
                                          <img src="/getImg?filename=<%=roomImgList.get(1).getRoomImgFilename()%>"
                                            alt="thumbnail">
                                          <% } %>
                                      </div>
                                      <div class="position-absolute p-2 p-lg-3 b-0 w-100 bg-shadow"></div>
                                    </div>
                                  </div>
                                </div>

                                <!--news box-->
                                <div class="col-6 pb-1 pl-1 pt-0">
                                  <div class="card border-0 rounded-0 text-white overflow zoom">
                                    <div class="position-relative">
                                      <!--thumbnail img-->
                                      <div class="ratio_right-cover-2 image-wrapper">
                                        <% if(roomImgList.size()> 2) {%>
                                          <img src="/getImg?filename=<%=roomImgList.get(2).getRoomImgFilename()%>"
                                            alt="thumbnail">
                                          <% } %>
                                      </div>
                                      <div class="position-absolute p-2 p-lg-3 b-0 w-100 bg-shadow"></div>
                                    </div>
                                  </div>
                                </div>

                                <!--news box-->
                                <div class="col-6 pb-1 pr-1 pt-1">
                                  <div class="card border-0 rounded-0 text-white overflow zoom">
                                    <div class="position-relative">
                                      <!--thumbnail img-->
                                      <div class="ratio_right-cover-2 image-wrapper">
                                        <% if(roomImgList.size()> 3) {%>
                                          <img src="/getImg?filename=<%=roomImgList.get(3).getRoomImgFilename()%>"
                                            alt="thumbnail">
                                          <% } %>
                                      </div>
                                      <div class="position-absolute p-2 p-lg-3 b-0 w-100 bg-shadow"></div>
                                    </div>
                                  </div>
                                </div>

                                <!--news box-->
                                <div class="col-6 pb-1 pl-1 pt-1">
                                  <div class="card border-0 rounded-0 text-white overflow zoom">
                                    <div class="position-relative">
                                      <!--thumbnail img-->
                                      <div class="ratio_right-cover-2 image-wrapper">
                                        <% if(roomImgList.size()> 4) {%>
                                          <img src="/getImg?filename=<%=roomImgList.get(4).getRoomImgFilename()%>"
                                            alt="thumbnail">
                                          <% } %>
                                      </div>
                                      <div class="position-absolute p-2 p-lg-3 b-0 w-100 bg-shadow"></div>
                                    </div>
                                  </div>
                                </div>
                                <!--end news box-->
                              </div>
                            </div>
                            <!--End box news-->
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              
<form action="/room/booking" method="get">
	<input type="hidden" name="room_no_booking" value=<%= room.getRoomNo()%> />
	<button type="submit" class="bookingbtn">예약하기</button>

</form>

<!-- 북마크 버튼  -->
<form action="/room/bookmark" method="post">
    <input type="hidden" name="bookmarkRoomNo" value=<%= room.getRoomNo() %> >
    <button type="submit" class="bookmarkbtn">북마크</button>
</form>
              <hr>



<!-- 숙소 정보 불러오기-->     

<div class =container">
<div class="roomInfo">
  <h2><span><%= room.getRoomName() %></span></h2><br>
	<span>최대 인원 <%=room.getRoomGuests() %>명 · </span>
	<span><%= room.getRoomType() %> · </span>
	<span>침실 <%= room.getRoomBedroom() %>개 · </span>
	<span>침대/침구류 <%= room.getRoomBed() %>개 · </span>
	<span>욕실 <%= room.getRoomBathroom() %>개</span>
	<hr>
	
	


<h3>편의시설 <h3>
<% for(int i=0; i<roomFacList.size(); i++) { %>
<% if( i == (roomFacList.size()-1) ) { %>
<span><%=roomFacList.get(i) %></span>
<% continue; } %>
<span><%=roomFacList.get(i) %> · </span>
<% } %>
<% if(roomFacList.size() == 0) { %>
<span>X</span>
<% } %>
	<hr>
	<h3>위치</h3>
	<span><%=room.getRoomRoadAddress() %></span> <span> <%=room.getRoomDetailedAddress() %></span>
	<hr>
	<h3>숙소설명</h3>	
     <p><%= room.getRoomDesc() %></p>
    <hr>
	<h2>1박 비용</h2>
	<span><%=room.getRoomPrice() %>원</span>
	
</div>
</div>



<hr>

              <div class="container">
                <div id="comments">
                  <div id="comment-head" class="commnet-row">
                  <h1>후기 작성</h1>
                  </div>
                  <form action="/room/detail" method="post">
                    <div class="star-box ">
                      <span class="star star_left"></span>
                      <span class="star star_right"></span>
                      <span class="star star_left"></span>
                      <span class="star star_right"></span>
                      <span class="star star_left"></span>
                      <span class="star star_right"></span>
                      <span class="star star_left"></span>
                      <span class="star star_right"></span>
                      <span class="star star_left"></span>
                      <span class="star star_right"></span>
                    </div>
<!--                     <div class="comment-row"> -->
<!--                       <input type="hidden" id="starValue" name="stars" value=0> -->
<!--                       <textarea id="new-comment" name="reContent" row="5" placeholder="리뷰를 입력하세요"></textarea> -->
<!--                       <button type="submit" class="btn btn-default navbar-btn">등록</button> -->
<!--                     </div> -->
							
							<div class="container">
							<div class="form-group purple-border">
							  <label for="exampleFormControlTextarea4"></label>
							  <input type="hidden" id="starValue" name="stars" value=0 >
							  
							  <textarea class="form-control" name="reContent" id="exampleFormControlTextarea4" rows="5"  style="font-size : 25px;"></textarea>
							 	
							   <input type="hidden" name="room_no_booking" value=<%= room.getRoomNo()%> />
							 
							   <button type="submit" class="btn btn-default navbar-btn">등록</button>
							
							</div>
							</div>
                  </form>
                  <hr>
<!-- 		<h1> 리뷰 n개 </h1>  총 리뷰 갯수 나오게 구현예정  -->
<!-- 		<div class ="container"> -->
<!-- 			<div class="review-author"> -->
<!-- 				      <p><strong>{{유저이름}}</strong> - <i class="fa fa-star" aria-hidden="true"></i> -->
<!-- 				      <i class="fa fa-star" aria-hidden="true"></i> -->
<!-- 				      <i class="fa fa-star" aria-hidden="true"></i> -->
<!-- 				      <i class="fa fa-star" aria-hidden="true"></i> -->
<!-- 				      <i class="fa fa-star" aria-hidden="true"></i> -->
<!-- 				      - {{유저별점}}</p> -->
<!-- 				    </div> -->
<!-- 				    <div class="review-comment"> -->
<!-- 				      <p>{{리뷰내용}}</p> -->
<!-- 				    </div> -->
				    
<!-- 				    <div class="review-date"> -->
<!-- 				      <time>July, 27th, 2016 {{작성날짜}}</time>  -->
<!-- 				    </div> -->
              
<!--        		</div> -->
<!--               </div> -->

<h3><%=allReview.size()%> Comments</h3> <!-- 코맨트 총 갯수 나오게 구현예정  -->
                
                <!-- COMMENT 1 - START -->
                <% for(int i=0; i<reviewList.size(); i++){ %>
                <div class="media">
                    <a class="pull-left" href="#"><img class="media-object" src="/resources/img/profilepic.jpeg" alt=""></a>
                    <div class="media-body">
                        <h4 class="media-heading"><%=reviewUser.get(i)%></h4>
                        <p><%=reviewList.get(i).getReContent()%></p>
                        <ul class="list-unstyled list-inline media-detail pull-left">
                            <li><i class="fa fa-calendar"></i><%=reviewList.get(i).getReDate()%></li>
                            <li>
                              <i class="fa ">
                            	<%if(Float.parseFloat(reviewList.get(i).getReStar()) == 0.0){ %>
                            		<img src="/resources/img/star/0.png" alt="">
                            	<%} else if(Float.parseFloat(reviewList.get(i).getReStar()) == 0.5){ %>
                            		<img src="/resources/img/star/05.png" alt="">
                            	<%} else if(Float.parseFloat(reviewList.get(i).getReStar()) == 1.0){ %>
                            		<img src="/resources/img/star/1.png" alt="">
                            	<%} else if(Float.parseFloat(reviewList.get(i).getReStar()) == 1.5){ %>
                            		<img src="/resources/img/star/15.png" alt="">
                            	<%} else if(Float.parseFloat(reviewList.get(i).getReStar()) == 2.0){ %>
                            		<img src="/resources/img/star/2.png" alt="">
                            	<%} else if(Float.parseFloat(reviewList.get(i).getReStar()) == 2.5){ %>
                            		<img src="/resources/img/star/25.png" alt="">
                            	<%} else if(Float.parseFloat(reviewList.get(i).getReStar()) == 3.0){ %>
                            		<img src="/resources/img/star/3.png" alt="">
                            	<%} else if(Float.parseFloat(reviewList.get(i).getReStar()) == 3.5){ %>
                            		<img src="/resources/img/star/35.png" alt="">
                            	<%} else if(Float.parseFloat(reviewList.get(i).getReStar()) == 4.0){ %>
                            		<img src="/resources/img/star/4.png" alt="">
                            	<%} else if(Float.parseFloat(reviewList.get(i).getReStar()) == 4.5){ %>
                            		<img src="/resources/img/star/45.png" alt="">
                            	<%} else if(Float.parseFloat(reviewList.get(i).getReStar()) == 5.0){ %>
                            		<img src="/resources/img/star/5.png" alt="">
                            	<%} %>
                              </i>
                            </li>
                        </ul>
                       
                    </div>
                </div>
                <% } %>

                <div class="text-center">
                  <ul class="pagination">
                  <% if(reviewList.size() > 0){ %>
                    <% if(paging.getCurPage()>1){ %>
                    <li><a href="/room/detail?room_no=<%=reviewList.get(0).getRoomNo() %>&curpage=<%=paging.getCurPage()-1 %>">&lt; </a></li>
                    <% } %>
                    
                    <% for(int i=paging.getStartPage(); i<=paging.getEndPage(); i++ ){ %>
                      <% if(i==paging.getCurPage()){ %>
                      <li class="active"><a href="/room/detail?room_no=<%=reviewList.get(0).getRoomNo() %>&curpage=<%=i%>"><%=i%></a></li>
                      <%}else{ %>
                      <li><a href="/room/detail?room_no=<%=reviewList.get(0).getRoomNo() %>&curpage=<%=i%>"><%=i%></a></li>
                      <%} %>
                    <%} %>
                    
                    <% if(paging.getTotalPage() !=paging.getCurPage()){ %>
                    <li><a href="/room/detail?room_no=<%=reviewList.get(0).getRoomNo() %>&curpage=<%=paging.getCurPage()+1%>">&gt;</a>
                    <% } %>
                    <% } %>
                    
                  </ul>
                </div>
                      
                      </div>
                <!-- COMMENT 1 - END -->

	</div>
</div>
	
              <%@include file="/WEB-INF/views/layout/footer.jsp" %>