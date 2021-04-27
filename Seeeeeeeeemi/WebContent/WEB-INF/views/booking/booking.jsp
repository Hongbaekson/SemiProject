<%@ page import="dto.Room" %>
<%@ page import="dto.RoomImg" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% Room room = (Room)request.getAttribute("room"); %>
<% List<RoomImg> roomImgList= (List)request.getAttribute("roomImgList"); %>
<%@include file="/WEB-INF/views/layout/header.jsp" %>



<link rel="stylesheet" href="//code.jquery/com/ui/1.12.1/themes/base/jquery-ui.css" />
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>







<!-- auto slide css  -->

<style>
  * {
    box-sizing: border-box;
  }

  body {
    font-family: Verdana, sans-serif;
  }

  .mySlides {
    display: none;
  }

  img {
    vertical-align: middle;
  }

  /* Slideshow container */
  .slideshow-container {
    max-width: 1000px;
    position: relative;
    margin: auto;
  }

  /* Caption text */
  .text {
    color: #f2f2f2;
    font-size: 15px;
    padding: 8px 12px;
    position: absolute;
    bottom: 8px;
    width: 100%;
    text-align: center;
  }

  /* Number text (1/3 etc) */
  .numbertext {
    color: #f2f2f2;
    font-size: 12px;
    padding: 8px 12px;
    position: absolute;
    top: 0;
  }

  /* The dots/bullets/indicators */
  .dot {
    height: 15px;
    width: 15px;
    margin: 0 2px;
    background-color: #bbb;
    border-radius: 50%;
    display: inline-block;
    transition: background-color 0.6s ease;
  }

  .active {
    background-color: #717171;
  }

  /* Fading animation */
  .fade {
    -webkit-animation-name: fade;
    -webkit-animation-duration: 1.5s;
    animation-name: fade;
    animation-duration: 1.5s;
  }

  @-webkit-keyframes fade {
    from {
      opacity: 0.4;
    }

    to {
      opacity: 1;
    }
  }

  @keyframes fade {
    from {
      opacity: 0.4;
    }

    to {
      opacity: 1;
    }
  }

  /* On smaller screens, decrease text size */
  @media only screen and (max-width: 300px) {
    .text {
      font-size: 11px;
    }
  }
</style>









<!--예약 폼 js  -->
<script>
  $(document).ready(function () {
    $('.input-group input[required], .input-group textarea[required], .input-group select[required]').on(
      'keyup change',
      function () {
        var $form = $(this).closest('form'),
          $group = $(this).closest('.input-group'),
          $addon = $group.find('.input-group-addon'),
          $icon = $addon.find('span'),
          state = false;

        if (!$group.data('validate')) {
          state = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|]+$/.test($(this).val())
        } else if ($group.data('validate') == "email") {
          state = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test($(this).val())
        } else if ($group.data('validate') == 'phone') {
          state = /^\d{3}-\d{3,4}-\d{4}$/.test($(this).val())
        } else if ($group.data('validate') == "length") {
          state = $(this).val().length >= $group.data('length') ? true : false;
        } else if ($group.data('validate') == "number") {
          state = !isNaN(parseFloat($(this).val())) && isFinite($(this).val());
        }

        if (state) {
          $addon.removeClass('danger');
          $addon.addClass('success');
          $icon.attr('class', 'glyphicon glyphicon-ok');
        } else {
          $addon.removeClass('success');
          $addon.addClass('danger');
          $icon.attr('class', 'glyphicon glyphicon-remove');
        }

        if ($form.find('.input-group-addon.danger').length == 0) {
          $form.find('[type="submit"]').prop('disabled', false);
        } else {
          $form.find('[type="submit"]').prop('disabled', true);
        }
      });

    $('.input-group input[required], .input-group textarea[required], .input-group select[required]').trigger(
      'change');


  });
</script>

<!-- date picker js  -->
<script>
  $(function () {

    $("#checkIn").datepicker({
      showOn: "focus", // 달력을 표시할 타이밍 (both: focus or button)
      dateFormat: "yy-mm-dd", // 날짜의 형식
      changeMonth: true, // 월을 이동하기 위한 선택상자 표시여부
      //minDate: 0,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이전 날짜 선택 불가)
      onClose: function (selectedDate) {
        // 시작일(checkIn) datepicker가 닫힐때
        // 종료일(checkOut)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
        $("#checkOut").datepicker("option", "minDate", selectedDate);
      },
    });

    //종료일
    $("#checkOut").datepicker({
      showOn: "focus",
      dateFormat: "yy-mm-dd",
      changeMonth: true,
      //minDate: 0, // 오늘 이전 날짜 선택 불가
      onClose: function (selectedDate) {
        // 종료일(checkOut) datepicker가 닫힐때
        // 시작일(checkIn)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정
        $("#checkIn").datepicker("option", "maxDate", selectedDate);
      },
    });
  });
</script>

</script>

<div class="container">

  <h1> <%=room.getRoomName() %></h1>

</div>

<div class="slideshow-container">
  <div class="mySlides fade">
    <div class="numbertext">1 / 5</div>
    <% if(roomImgList.size()> 0) {%>
    <img src="/getImg?filename=<%=roomImgList.get(0).getRoomImgFilename()%>" alt="thumbnail" style="width: 100%" />
    <% } %>
  </div>

  <div class="mySlides fade">
    <div class="numbertext">2 / 5</div>
    <% if(roomImgList.size()> 1) {%>
    <img src="/getImg?filename=<%=roomImgList.get(1).getRoomImgFilename()%>" alt="thumbnail" style="width: 100%" />
    <% } %>
  </div>

  <div class="mySlides fade">
    <div class="numbertext">3 / 5</div>
    <% if(roomImgList.size()> 2) {%>
    <img src="/getImg?filename=<%=roomImgList.get(2).getRoomImgFilename()%>" alt="thumbnail" style="width: 100%" />
    <% } %>
  </div>

  <div class="mySlides fade">
    <div class="numbertext">4 / 5</div>
    <% if(roomImgList.size()> 3) {%>
    <img src="/getImg?filename=<%=roomImgList.get(3).getRoomImgFilename()%>" alt="thumbnail" style="width: 100%" />
    <% } %>
  </div>
  <div class="mySlides fade">
    <div class="numbertext">5 / 5</div>
    <% if(roomImgList.size()> 4) {%>
    <img src="/getImg?filename=<%=roomImgList.get(4).getRoomImgFilename()%>" alt="thumbnail" style="width: 100%" />
    <% } %>
  </div>
  <br />

  <div style="text-align: center">
    <span class="dot"></span>
    <span class="dot"></span>
    <span class="dot"></span>
    <span class="dot"></span>
    <span class="dot"></span>
  </div>
</div>






<hr>









<div class="container">

  <div class="row">
    <div class="col-sm-offset-4 col-sm-4">

      <form action="/room/booking" method="post">
        <h1>예약 정보</h1>
        <div class="form-group">
          <label for="validate-text">예약자 이름</label>
          <div class="input-group">
            <input type="text" class="form-control" name="bookingUserName" id="validate-text"
              placeholder="Validate Text" required>
            <span class="input-group-addon danger"><span class="glyphicon glyphicon-remove"></span></span>
          </div>
        </div>

        <div class="form-group">
          <label for="validate-phone">예약자 번호</label>
          <div class="input-group" data-validate="phone">
            <input type="text" class="form-control" name="bookingUserPhone" id="validate-phone"
              placeholder="Phone Number" required>
            <span class="input-group-addon danger"><span class="glyphicon glyphicon-remove"></span></span>
          </div>
        </div>


        <div class="form-group">
          <label for="validate-email">예약자 이메일</label>
          <div class="input-group" data-validate="email">
            <input type="text" class="form-control" name="bookingUserEmail" id="validate-email"
              placeholder="Validate Email" required>
            <span class="input-group-addon danger"><span class="glyphicon glyphicon-remove"></span></span>
          </div>
        </div>

        <div class="form-group">
          <label for="checkIn">체크인</label>
          <div class="input-group">
            <input type="text" id="checkIn" name="bookingCheckin" class="form-control" placeholder="Checkin Date" />
          </div>
        </div>

        <div class="form-group">
          <label for="checkOut">체크아웃</label>
          <div class="input-group">
            <input type="text" id="checkOut" name="bookingCheckout" class="form-control" placeholder="Checkout Date" />
          </div>
        </div>

        <div class="form-group">
          <label for="guest">게스트</label>
          <div class="input-group">
            <input type="number" id="guest" name="bookingGuest" class="gui-input from-control" required=""
              placeholder="Guest" min="0" />
          </div>
        </div>


        <div class="form-group">
          <label for="validate-length">호스트에게 메시지</label>
          <div class="input-group" data-validate="length" data-length=1>
          	<input type="hidden" value=<%= room.getRoomNo() %> name="room_no_booking"/>
            <textarea type="text" class="form-control" name="bookingMessage" id="validate-length" placeholder="Message"
              required></textarea>
            <span class="input-group-addon danger"><span class="glyphicon glyphicon-remove"></span></span>
          </div>
        </div>
        <button type="submit" class="btn btn-primary col-xs-12">예약</button>
      </form>
    </div>
  </div>
</div>
<hr>




<!-- 이미지 슬라이드 js -->
<script>
  var slideIndex = 0;
  showSlides();

  function showSlides() {
    var i;
    var slides = document.getElementsByClassName("mySlides");
    var dots = document.getElementsByClassName("dot");
    for (i = 0; i < slides.length; i++) {
      slides[i].style.display = "none";
    }
    slideIndex++;
    if (slideIndex > slides.length) {
      slideIndex = 1;
    }
    for (i = 0; i < dots.length; i++) {
      dots[i].className = dots[i].className.replace(" active", "");
    }
    slides[slideIndex - 1].style.display = "block";
    dots[slideIndex - 1].className += " active";
    setTimeout(showSlides, 1000); //1초후변경 사진 
  }
</script>


<%@include file="/WEB-INF/views/layout/footer.jsp" %>