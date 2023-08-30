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
<%@ include file="../../include/user/menu.jsp" %>

<!-- 콘텐츠 -->
<div id="sub">
    <div class="sub_wrap">
        <div class="cont_wrap">
            <!-- 타이틀 -->
            <div class="sub_tit font_noto">운전자피로도<span class="f_wet_03"> 자가진단</span></div>
            <!-- 타이틀끝 -->
            <!-- 문제 -->
            <div class="sub_wrap_box font_noto">
                <div class="flex_l">
                    <span class="box_06 blue_bg_01 txt_36 f_wet_05">Q1</span>
                    <span class="txt_24 f_wet_05 l_pad_50">
                    질문지 영역입니다질문지 영역입니다질문지 영역입니다질문지 영역입니다질문지 영역입니다<br>질문지 영역입니다질문지 영역입니다질문지 영역입니다질문지 영역입니다질문지 영역입니다<br>질문지 영역입니다질문지 영역입니다질문지 영역입니다질문지 영역입니다질문지 영역입니다<br>
                    </span>
                </div>
                <div class="cont_txt">
                    <div class="box_wrap font_noto txt_24">
                        <ul class="qna_ul b_pad_30">
                            <li class="qna_li"><span class="box_07 white_bg_01">1</span><input type="radio" name="xxx" value="yyy" checked class="radio">내용입력</li>
                            <li class="qna_li"><span class="box_07 white_bg_01">2</span><input type="radio" name="xxx" value="yyy" class="radio">내용입력</li>
                        </ul>
                        <ul class="qna_ul">
                            <li class="qna_li"><span class="box_07 white_bg_01">3</span><input type="radio" name="xxx" value="yyy" class="radio">내용입력</li>
                            <li class="qna_li"><span class="box_07 white_bg_01">4</span><input type="radio" name="xxx" value="yyy" class="radio">내용입력</li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- 문제끝 -->
            <div class="btn_wrap">
                <div class="btn_01 blue_bg_01 font_noto pointer animate__animated animate__swing animate__repeat-3" onclick="location.href='/view/subpage/view.do?idx=8';">제출하기</div>
            </div>
        </div>
    </div>
</div>
<!-- 콘텐츠 끝 -->
<!-- 
<div id="survey">
	<ul>
		<li>이름 : <input type="text" name="name"></li>
		<li>핸드폰 : <input type="text" name="phone" placeholder="-제외한 010부터 숫자만 입력해주세요." oninput="this.value = this.value.replace(/[^0-9]/g, '');"></li>
		<li>연령대 : 
		<select name="age">
			<option value="">연령대를 선택해주세요</option>
			<option value="4">20대 ~ 30대</option>
			<option value="3">40대</option>
			<option value="2">50대</option>
			<option value="1">60대 이상</option>
		</select>
		</li>
	</ul>
	<div id="exam_list">
  <c:forEach items="${model.list}" var="item" varStatus="status">
    <ul>
      <li>제목: ${item.name}</li>
      <c:set var="selectContentList" value="${fn:split(item.select_content_list, ',')}" />
      <c:set var="selectScoreList" value="${fn:split(item.select_score_list, ',')}" />
      <c:forEach var="content" items="${selectContentList}" varStatus="selectStatus">
        <input type="radio" name="${item.name}" value="${selectScoreList[selectStatus.index]}">${content.trim()}
      </c:forEach>
    </ul>
  </c:forEach>
  </div>
</div>
<div>
	<button type="button" onclick="exam_result_insert()">제출 테스트</button>
</div>
-->


<div style="display:none" id="submit">
	<form action="/view/exam/insert.do" method="POST" >
		<input type="text" name="exam_idx" value="${model.idx }">
		<input type="text" name="name" value="">
		<input type="text" name="phone" value="">
		<input type="text" name="age" value="">
		<input type="text" name="score" value="">
	</form>
</div>

<!--공통하단-->
<%@ include file="../../include/user/footer.jsp" %>
<script type="text/javascript">

function exam_result_insert(){

	var bool = confirm('해당 설문을 제출하시겠습니까?');
	if(bool){
	
		var exam_check_member = member_check();
		var exam_check_bool = exam_check();
		
		console.log('exam : ' + exam_check_bool);
		console.log('member : ' + exam_check_member);
		
		if(!(exam_check_bool && exam_check_member)){
			alert('해당 설문을 모두 확인해주세요.');
			return;
		}
		
		var score_list = [];
		var all_score = 0;
		$('input[type=radio]:checked').each(function(){
			score_list.push($(this).val()); 
		    all_score += parseInt($(this).val());
		})
		
		all_score += parseInt($('#survey [name=age]').val());
		
		console.log('name : ' + $('#survey [name=name]').val());
		console.log('phone : ' + $('#survey [name=phone]').val());
		console.log('age : ' + $('#survey [name=age]').val());
		console.log('score_list : ' + score_list);
		console.log('all_score : ' + all_score);
		
		$('#submit [name=name]').val($('#survey [name=name]').val());
		$('#submit [name=phone]').val($('#survey [name=phone]').val());
		$('#submit [name=age]').val($('#survey [name=age]').val());
		$('#submit [name=score]').val(all_score);
		
		$('#submit form').submit();
		
		
		
	}
	
}

function exam_check(){

	var surveyDiv = $("#exam_list");
    var totalQuestions = ${fn:length(model.list)};
    var checkedCount = 0;

    surveyDiv.find("ul").each(function() {
      var radioButtons = $(this).find("input[type='radio']");
      if (radioButtons.is(":checked")) {
        checkedCount++;
      }
    });

    var isAllChecked = checkedCount === totalQuestions;

    return isAllChecked
	
}

function member_check(){
	
	var MemberCheck = true;
	
	if($('#survey [name=name]').val() != '' &&  $('#survey [name=phone]').val() != '' && $('#survey [name=age]').val() != ''){
		
		MemberCheck = true;
		
	}else{
		
		MemberCheck = false;
		
	}
	
	return MemberCheck
	
}



</script>