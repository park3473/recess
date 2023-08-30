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
<!-- 콘텐츠 -->
<div id="main">
    <div class="main_wrap">
        <div class="cont_wrap font_noto">
		    <!-- 텍스트 -->
            <div class="col_50">
                <div class="l_pad_50"><img src="${pageContext.request.contextPath}/resources/img/logo.png" alt=""></div>
                <div class="box_01 white_bg_01 txt_20 f_wet_07 red_01 t_mar_30">한국도로공사와 함께하는 안전운전 캠페인</div>
                <div class="font_gmarket t_spa_03">
                    <div class="txt_80 gray_00 t_mar_30 pos_r">피로할땐 휴식이지 ~ <span class="l_pad_20"></span> <span class="pos_a animate__animated animate__jackInTheBox"><img src="${pageContext.request.contextPath}/resources/img/gift_01.png" alt=""></span></div>
                    <div class="txt_70 gray_00">쾌적한 휴게소에서</div>
                    <div class="txt_90 gray_00 t_spa_07 f_wet_09 animate__animated animate__flash animate__repeat-2"><span class="yellow_01">푹 쉬고 인센티브</span> 먹자 !</div>
                </div>
                <div class="box_02 blue_bg_01 pointer t_mar_30 animate__animated animate__swing animate__repeat-3" onclick="location.href='/view/subpage/view.do?idx=5';">
                    <div class="txt_30">고속도로 운전자 피로도</div>
                    <div class="txt_44 f_wet_07 t_pad_10">자가진단 참여하기</div>
                </div>
            </div>
			<!-- 텍스트 끝 -->
			<!-- 캐릭터 -->
            <div class="col_50 pos_r">
                <div class="pos_a charac_01 animate__animated animate__bounceIn"><img src="${pageContext.request.contextPath}/resources/img/charac_01.png" alt="" class="move_02"></div>
                <div class="pos_a charac_02 animate__animated animate__zoomInRight"><img src="${pageContext.request.contextPath}/resources/img/charac_02.png" alt="" class="move_03"></div>
                <div class="pos_a box_03 white_bg_01 animate__animated animate__bounce animate__repeat-3">
                    <div class="txt_30 f_wet_07 gray_07 t_spa_02 t_pad_55">졸음운전</div>
                    <div class="txt_36 f_wet_09 red_02 t_spa_00 t_het_36">OUT</div>
                </div>
                <div class="pos_a box_04 white_bg_01 animate__animated animate__rubberBand">
                    <div class="txt_38 f_wet_07 gray_07 t_spa_02 t_pad_50 t_het_46">건강한<br>운전습관</div>
                    <div class="txt_46 f_wet_09 blue_01 t_spa_00 t_het_60">UP</div>
                </div>
            </div>
			<!-- 캐릭터끝 -->
        </div>
    </div>
</div>
<!-- 콘텐츠 끝 -->

<!--공통하단-->
<%@ include file="../../include/user/footer.jsp" %>
<script type="text/javascript">