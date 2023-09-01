<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!--삭제금지-->
<script src="${pageContext.request.contextPath}/resources/sweetalert/jquery-1.12.4.js"></script>
<!-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script> -->
<script src="${pageContext.request.contextPath}/resources/js/time_main.js"></script>

<!--공통 헤더 시작-->
<%@ include file="../../include/user//header.jsp" %>
<%@ include file="../../include/user/menu.jsp" %>

<!-- 콘텐츠 -->
<div id="sub">
    <div class="sub_wrap">
        <div class="cont_wrap" id="result_view">
            <!-- 타이틀 -->
            <div class="sub_tit font_noto">운전자피로도<span class="f_wet_03"> 자가진단</span></div>
            <!-- 타이틀끝 -->
            <!-- result_view -->
            <div class="sub_wrap_box font_noto" id="result_view">
                <div class="align_c">
                    <span class="box_01 blue_bg_01 txt_20 f_wet_05 gray_00" style="width:60%">진단결과</span>
                </div>
                <div class="box_wrap font_noto txt_24 align_c">
                    <ul class="t_pad_35">
                        <li class="line"><span class="box_07 green_bg_02"></span><br>휴식권고</li>
                        <li class="line"><span class="box_07 orange_bg_02"></span><br>휴식필요</li>
                        <li class="line"><span class="box_07 red_bg_01"></span><br>즉각적인 휴식</li>
                    </ul>
                </div>
                <div class="cont_txt">
                    <div class="box_wrap font_noto txt_24 align_c">
                    <ul class="">
                        <li><img src="/resources/img/charac_01.png" alt="" style="width:30%" class="animate__animated animate__bounceIn move_02"></li>
                        <li>
                        	<c:if test="${model.ProductList[0].recess == '15' }">
						    	<div class=""><span class="box_07 green_bg_02 align_m"></span><span class="l_pad_30">짧은 주행은 가능하지만 휴식을 권고합니다.</span></div>
						    </c:if>
						    <c:if test="${model.ProductList[0].recess == '30' }">
						    	<div class=""><span class="box_07 orange_bg_02 align_m"></span><span class="l_pad_30">짧은 주행은 가능하지만 빠른 휴식이 필요합니다.</span></div>
						    </c:if>
						    <c:if test="${model.ProductList[0].recess == '60' }">
						    	<div class=""><span class="box_07 red_bg_01 align_m"></span><span class="l_pad_30">즉각적인 휴식이 필요합니다.</span></div>
						    </c:if>
							<div class=""><span class="">현재 귀하의 상태 </span><span class="box_01 white_bg_01"><span class="txt_40 f_wet_07">${model.ProductList[0].recess }분</span> 휴식시간</span><span class=""> 이 필요합니다</span></div>
						</li>
                        <li class="animate__animated animate__zoomInRight"><img src="/resources/img/charac_02.png" alt="" style="width:50%"></li>
                    </ul>
                </div>
                </div>
            </div>
            <!-- result_view끝 -->
            
            <div class="btn_wrap animate__animated animate__bounceIn animate__repeat-3">
                <div class="btn_01 blue_bg_01 font_noto pointer" id="result_view_btn" onclick="select_view()">휴식 취하고 인센티브 받기</div>
            </div>
        </div>
        
        <div class="cont_wrap" id="result_select" style="display:none">
            <!-- 타이틀 -->
            <div class="sub_tit font_noto">운전자피로도<span class="f_wet_03"> 자가진단</span></div>
            <!-- 타이틀끝 -->
            
            <!-- result_select -->
            <div class="sub_wrap_box font_noto" id="result_select">
                <div class="align_c">
                    <span class="box_01 blue_bg_01 txt_20 f_wet_05 gray_00" style="width:60%">인센티브 (쿠폰) 수령</span>
                </div>
                <div class="cont_txt">
                    <div class="box_wrap font_noto txt_24">
                        <ul class="">
                            <li class="coupon align_m">
                            <div class="flex_l">
                                <span class="box_01 white_bg_01  animate__animated animate__swing animate__repeat-3"><img src="/resources/upload/product/image/${model.ProductList[0].image }" alt=""></span>
                                <span class="align_l l_pad_30 t_pad_15">
                                <strong>인센티브 :</strong> ${model.ProductList[0].name }<br>
                                <strong>휴게소명 :</strong> 천안 휴게소(샘플)<br>
                                <strong>발행시간 :</strong> 23.08.31<br>
                                <strong>사용기한 :</strong> 당일
                                </span>
                            </div>
                            </li>
                            <li class="align_m">
                            <div class="b_pad_15"><span class="r_pad_30">이&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp름</span><span class=""><input type="text" name="my_name" size="25" class="txt_24 f_wet_05 gray_10 "></span></div>
                            <div class=""><span class="r_pad_30">전화번호</span><span class=""><input type="text" name="my_phone" size="25" class="txt_24 f_wet_05 gray_10 "></span></div>
                            </li>
                        </ul>
                    </div>
                    <div class="red_02 font_noto txt_20 f_ert_05 align_c t_pad_30">
                        휴식시간은 자동으로 계산되며, 쿠폰받기를 클릭하시면 휴식이 끝난 후 최초 입력한 번호로 자동 문자 발송됩니다.<br>
                        현재의 휴게소 편의점에서 1일 이내 인센티브 수령이 가능합니다.
                    </div>
                </div>
            </div>
            <!-- result_select끝 -->
            
            <div class="btn_wrap animate__animated animate__bounceIn animate__repeat-3">
                <div class="btn_01 blue_bg_01 font_noto pointer" id="result_view_btn" onclick="exam_complete()">인센티브(쿠폰) 받기</div>
            </div>
        </div>
        
    </div>
</div>

<!-- 콘텐츠 끝 -->

<div style="display:none" id="submit">
	<form action="/view/exam/result_view.do" method="POST" >
		<input type="text" name="exam_idx" value="${model.view.exam_idx }">
		<input type="text" name="idx" value="${model.view.idx }">
		<input type="text" name="name" value="${model.view.name }">
		<input type="text" name="phone" value="${model.view.phone }">
		<input type="text" name="age" value="${model.view.age }">
		<input type="text" name="score" value="${model.before.score }">
		<input type="text" name="video" value="${model.view.video }">
	</form>
</div>

<!--공통하단-->
<%@ include file="../../include/user/footer.jsp" %>
<script type="text/javascript">

//상품 이미지 보기
function image_view(image_name){
	
	Swal.fire({
		  title: '',
		  html: '<img style="width:100%" src="/resources/upload/product/image/'+image_name+'" alt="상품이미지">',
		  showCloseButton: true,
		}).then((result) => {
		  // 닫기 버튼 클릭 시 처리할 로직 작성
		  console.log('닫기 버튼이 클릭되었습니다.');
		});
	
}

function sms_test(message , phone , reservation_tm){
	
	var Message = message;
	var Phone = phone;
	var Sms_type = 'L';
	var Type = '0';
	var Reservation_tm = reservation_tm;
	
	$.ajax({
		url : '/view/exam/result_select.do',
		type : 'POST',
		data : ({
			MESSAGE : Message,
			PHONE : Phone,
			SMS_TYPE : Sms_type,
			TYPE : Type,
			RESERVATION_TM : Reservation_tm,
		}),
		success : function(xhr , status){
			console.log('success');
		},
		error : function(xhr , status , error){
			console.log('error');
		}
		
		
	})
	
}

function select_view(){
	
	$('#result_view').hide();
	
	$('#result_select').show();
	
}

function exam_complete(){
	
	var name = $('[name=my_name]').val();
	var phone = $('[name=my_phone]').val();
	var message = '';
	var reservation_tm = '${model.ProductList[0].recess }';
	
	message += '휴식을 완료하였습니다.\n';
	message += ('현재 휴게소 편의점에서 상품 : ' + '${model.ProductList[0].name}' + '를 수령하실수 있습니다.\n');
	message += '관련 문의는 한국도로공사 대전충남본부(042-722-6142)\n';
	message += '로 연락 바랍니다.';
	
	console.log(message);
	console.log(name);
	console.log(phone);
	console.log(reservation_tm);
	
	sms_test(message , phone , reservation_tm);
	
	Swal.fire('진단이 완료되었습니다.');
	location.href='/view/subpage/view.do?idx=8'
	
	
}


</script>