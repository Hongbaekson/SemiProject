<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/layout/header.jsp" %>

<link
     rel="stylesheet"
      href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"
    />
    <script
      src="https://kit.fontawesome.com/3f7a375eec.js"
      crossorigin="anonymous"
    ></script>
    <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
    <script src="http://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
    <!-- datepicker 한국어로 -->
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/datepicker-ko.js"></script>
   <script>
      $(function () {
        //오늘 날짜를 출력
        $("#today").text(new Date().toLocaleDateString());

        //datepicker 한국어로 사용하기 위한 언어설정
        $.datepicker.setDefaults($.datepicker.regional["ko"]);

        // 시작일(checkIn)은 종료일(checkOut) 이후 날짜 선택 불가
        // 종료일(checkOut)은 시작일(checkIn) 이전 날짜 선택 불가

        //시작일.
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
<div>
<h1>숙소예약</h1>
</div>
<div class="container">
      <form action="/room/search" method="post">
        <label for="checkIn">체크인</label>
        <input
          type="text"
          name="checkIn"
          id="checkIn"
          placeholder="날짜입력"
        />
        <i class="far fa-calendar-alt"></i>
        <label for="checkOut">체크아웃</label>
        <input type="text" name="checkOut" id="checkOut" placeholder="날짜입력" />
        <i class="far fa-calendar-alt"></i>

     
            <label for="guest" class="field-label">인원</label>
            <label for="guest" class="field prepend-icon">
              <input
                type="number"
                id="guest"
                name="bookingGuest"
                class="gui-input"
                required=""
                placeholder="게스트 추가"
                min="0"
              />
              <span class="field-icon"><i class="fa fa-users"></i></span>
            </label>
       
        <button type="submit" id="btnJoin" class="btn btn-default navbar-btn">검색</button>
      </form>
    </div>
	



<hr>



<%@include file="/WEB-INF/views/layout/footer.jsp" %>