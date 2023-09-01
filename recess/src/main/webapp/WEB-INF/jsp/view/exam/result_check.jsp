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

<!-- 콘텐츠 -->
<div id="sub">
    <div class="sub_wrap">
        <div class="cont_wrap">
            <!-- 타이틀 -->
            <div class="sub_tit font_noto">운전자피로도<span class="f_wet_03"> 자가진단</span></div>
            <!-- 타이틀끝 -->
            <!-- 문제 -->
            <div class="sub_wrap_box font_noto align_c">
                    <div class=""><img src="/resources/img/charac_03.png" alt="" class="move_04"></div>
				<div class="txt_30 t_pad_30 f_wet_05">자가 진단이 완료되었습니다. 검사 결과 확인 후 인센티브를 받으세요!</div>
            </div>
            <!-- 문제끝 -->
            <div class="btn_wrap">
                <span class="btn_01 blue_bg_01 font_noto pointer r_mar_15 animate__animated animate__swing animate__repeat-3" onclick="result_view();">진단 결과 확인하기</span>
				<span class="btn_01 orange_bg_01 font_noto pointer l_mar_15 animate__animated animate__bounceIn animate__repeat-2" onclick="video_view()">홍보 영상 시청하기</span>
            </div>
        </div>
    </div>
</div>
<!-- 콘텐츠 끝 -->

<div style="display:none" id="submit">
	<form action="/view/exam/result_view.do" method="POST" >
		<input type="text" name="exam_idx" value="${model.before.exam_idx }">
		<input type="text" name="idx" value="${model.before.idx }">
		<input type="text" name="name" value="">
		<input type="text" name="phone" value="">
		<input type="text" name="age" value="${model.before.age }">
		<input type="text" name="score" value="${model.before.score }">
		<input type="text" name="video" value="no">
	</form>
</div>

<!--공통하단-->
<%@ include file="../../include/user/footer.jsp" %>
<script type="text/javascript">

function video_view() {
	Swal.fire({
        title: '영상 시청',
        width: '50%',
        position: 'center',
        html: '<video id="videoInSwal" width="100%" controls><source src="/resources/video/video1.mp4" type="video/mp4">Your browser does not support the video tag.</video>',
        showCloseButton: true,
        showConfirmButton: false,
        focusConfirm: false,
        didOpen: () => {
            const videoElement = document.getElementById('videoInSwal');
            videoElement.play().catch(error => {
                console.error("Video play failed: ", error);
            });
            videoElement.addEventListener('timeupdate', function() {
                if(videoElement.currentTime === videoElement.duration) {
                    Swal.fire({
                        title: '점수가 추가되었습니다!',
                        text: '축하합니다! 영상 시청을 완료하셨습니다.',
                        icon: 'success',
                        confirmButtonText: '확인'
                    }).then(function() {
                    	score_plus('${model.before.idx}','${model.before.score}','3');
                    	result_view();
                    })
                    
                    
                }
            });
        }
    });
}

function score_plus(idx,score,score_plus){
	
	console.log('idx : ' + idx);
	console.log('score : ' + score);
	console.log('score_plus : ' + score_plus);
	
	score = parseInt(score) + parseInt(score_plus);
	
	console.log('score : ' + score);
	
	$.ajax({
		
		url : '/view/exam/score_plus.do',
		type : 'POST',
		data : ({
			idx : idx,
			score : score
		}),
		success : function(status){
			console.log('score_plus : success');
		},
		error : function(error , xhr , status){
			console.log('score_plus : error' + status);
		}
		
	})
	
}

function result_view(){
	
	$('#submit form').submit();
	
}


</script>