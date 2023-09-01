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

<style>

  .sub_wrap_box, .btn_wrap{
      display: none; /* 처음에는 모든 문제를 숨김 */
    }
    .active_exam {
      display: block; /* 활성화된 문제만 보임 */
    }

</style>

<!-- 콘텐츠 -->
<div id="sub">
    <div class="sub_wrap">
        <div class="cont_wrap">
            <!-- 타이틀 -->
            <div class="sub_tit font_noto">운전자피로도<span class="f_wet_03"> 자가진단</span></div>
            <!-- 타이틀끝 -->
            <!-- 문제 -->
            <c:forEach items="${model.list}" var="item" varStatus="status">
            <c:set var="selectContentList" value="${fn:split(item.select_content_list, ',')}" />
      		<c:set var="selectScoreList" value="${fn:split(item.select_score_list, ',')}" />
            <div class="sub_wrap_box font_noto" id="exam_list">
                <div class="flex_l">
                    <span class="box_06 blue_bg_01 txt_36 f_wet_05">Q${status.index + 1 }</span>
                    <span class="txt_24 f_wet_05 l_pad_50">
                    	${item.name}
                    </span>
                </div>
                <div class="cont_txt">
                    <div class="box_wrap font_noto txt_24">
                        <ul class="qna_ul">
                        	<c:forEach var="content" items="${selectContentList}" varStatus="selectStatus">
                            <li class="qna_li b_pad_30" onclick="q_check(this)"><span class="box_07 white_bg_01">${selectStatus.index + 1}</span><input type="radio" name="${item.name}" value="${selectScoreList[selectStatus.index]}" class="radio">${content.trim()}</li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            <c:if test="${!status.last}">
            <div class="btn_wrap">
                <div class="btn_01 blue_bg_01 font_noto pointer animate__animated animate__swing animate__repeat-3">다음문제</div>
            </div>
            </c:if>
            <c:if test="${status.last}">
            <div class="btn_wrap">
                <div class="btn_01 blue_bg_01 font_noto pointer animate__animated animate__swing animate__repeat-3">제출하기</div>
            </div>
            </c:if>
            </c:forEach>
            <!-- 문제끝 -->
        </div>
    </div>
</div>
<!-- 콘텐츠 끝 -->
<!-- 
<div id="survey">
	<ul>
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
		<input type="text" name="ip" value="">
		<input type="text" name="phone" value="">
		<input type="text" name="age" value="">
		<input type="text" name="score" value="">
	</form>
</div>

<!--공통하단-->
<%@ include file="../../include/user/footer.jsp" %>
<script type="text/javascript">

$(document).ready(function(){
    let currentQuestion = 0; // 현재 문제 인덱스
    const totalQuestions = $(".sub_wrap_box").length; // 전체 문제 수
    
    // 첫 번째 문제를 보여줌
    $(".sub_wrap_box").eq(currentQuestion).addClass("active_exam");
    $(".btn_wrap").eq(currentQuestion).addClass("active_exam");

    $(".btn_01").click(function(){
      
    	//현재 문제 답안 석택 했는지 확인
    	const isChecked = $(".sub_wrap_box.active_exam input[type='radio']:checked").length > 0;

    	  if (!isChecked) {
    	    Swal.fire("답안을 선택해주세요.");
    	    return;
    	  }else{
    		 if(currentQuestion >= totalQuestions-1) {
    			 Swal.fire("모든 문제를 완료했습니다.");
    			 exam_result_insert();
    	  	}
    	  }
    	
    // 현재 문제를 숨김
      $(".sub_wrap_box").eq(currentQuestion).removeClass("active_exam");
      $(".btn_wrap").eq(currentQuestion).removeClass("active_exam");
      
      currentQuestion++; // 다음 문제 인덱스로 이동

      
      // 다음 문제를 보여줌
      $(".sub_wrap_box").eq(currentQuestion).addClass("active_exam");
      $(".btn_wrap").eq(currentQuestion).addClass("active_exam");
      
      
    });
  });


function exam_result_insert(){

		
		var score_list = [];
		var all_score = 0;
		$('input[type=radio]:checked').each(function(){
			score_list.push($(this).val()); 
		    all_score += parseInt($(this).val());
		})
		
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

function q_check(e){

    $(e).find('input').prop('checked',true);
    
}

</script>