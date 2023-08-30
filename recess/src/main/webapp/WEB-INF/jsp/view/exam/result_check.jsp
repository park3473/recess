<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!--삭제금지-->
<script src="${pageContext.request.contextPath}/resources/sweetalert/jquery-1.12.4.js"></script>
<!-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script> -->


<!--공통 헤더 시작-->
<%@ include file="../../include/user//header.jsp" %>
<!-- 동영상 -->
<div id="popup1" class="overlay">
  <div class="popup">
    <a class="close" href="#">&times;</a>
    <div class="content b_pad_50">
      <iframe width="100%" height="300" src="https://www.youtube.com/embed/G6G73jsmCgY" title="[한국도로공사] 교통안전캠페인_안전하자Go! - 졸음운전은 안돼요!" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
    </div>
  </div>
</div>
<!-- 동영상 끝 -->

<!-- 콘텐츠 -->
<div id="sub">
    <div class="sub_wrap">
        <div class="cont_wrap">
            <!-- 타이틀 -->
            <div class="sub_tit font_noto">운전자피로도<span class="f_wet_03"> 자가진단</span></div>
            <!-- 타이틀끝 -->
            <!-- 문제 -->
            <div class="sub_wrap_box font_noto align_c">
                    <div class=""><img src="/ex/contents/img/charac_03.png" alt="" class="move_04"></div>
				<div class="txt_30 t_pad_30 f_wet_05">자가 진단이 완료되었습니다. 검사 결과 확인 후 인센티브를 받으세요!</div>
            </div>
            <!-- 문제끝 -->
            <div class="btn_wrap">
                <span class="btn_01 blue_bg_01 font_noto pointer r_mar_15 animate__animated animate__swing animate__repeat-3" onclick="location.href='sub_06.php';">진단 결과 확인하기</span>
				<span class="btn_01 orange_bg_01 font_noto pointer l_mar_15 animate__animated animate__bounceIn animate__repeat-2" onclick="location.href='#popup1';">홍보 영상 시청하기</span>
            </div>
        </div>
    </div>
</div>
<!-- 콘텐츠 끝 -->

<!--공통하단-->
<%@ include file="../../include/user/footer.jsp" %>
<script type="text/javascript">