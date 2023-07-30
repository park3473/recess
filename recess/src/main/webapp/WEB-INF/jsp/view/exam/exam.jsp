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
	<div id="ss">
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
<!--공통하단-->
<%@ include file="../../include/user/footer.jsp" %>
<script type="text/javascript">

function exam_result_insert(){

	var bool = confirm('해당 설문을 제출하시겠습니까?');
	if(bool){
	
		var exam_check_bool = exam_check();
		
		if(!exam_check_bool){
			alert('해당 문항을 모두 체크해주세요.');
			return;
		}
		
		var score_list = [];
		var all_score = 0;
		$('input[type=radio]:checked').each(function(){
			score_list.push($(this).val()); 
		    all_score += parseInt($(this).val());
		})
		
		console.log('name : ' + $('[name=name]').val());
		console.log('phone : ' + $('[name=phone]').val());
		console.log('age : ' + $('[name=age]').val());
		console.log('score_list : ' + score_list);
		console.log('all_score : ' + all_score);
		
		
	}
	
}

function exam_check(){

	var surveyDiv = $("#ss");
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



</script>