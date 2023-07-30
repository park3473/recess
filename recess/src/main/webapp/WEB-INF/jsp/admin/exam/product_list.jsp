<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="../include/header.jsp" %>
</head>

<style>
	#bootstrap-data-table tr th{
	
	text-align: center;
	
	}
</style>

<body>
    <!--헤더-->
	<%@ include file="../include/menu.jsp" %>
    <!--헤더 end-->

    <!--본문-->
    <section id="adm_sc">
        <div id="adm_sc_area">
            <div id="adm_sc_con">
                <div class="adm_sc_size">

                    <!--본문 내용-->
                    <section class="adm_sc_txt">
                        <div class="sc_con">
                            <div class="title">
                                <span></span>
                                <span>상품 및 휴식 리스트</span>
                            </div>
                            
                            <!--관리자 버튼-->
                            <div class="page_seach">
                                <div class="adm_btn_wrap stats_btn_area">
                                    <ul>
	                                    <li class="delete">
	                                        <button onclick="selectAppend()">추가</button>
	                                    </li>
	                                </ul>
                                </div>
                            </div>
                            <!--관리자 버튼 end-->
                            <div class="table_wrap">
                                <table id="bootstrap-data-table">
                                	<input type="hidden" name="exam_idx" value="${model.exam_idx }">
                                    <tr>
                                        <th class="min_score">상품 최소 점수</th>
                                        <th class="max_score">상품 최대 점수</th>
                                        <th class="recess">휴식 시간</th>
                                        <th class="name">상품명</th>
                                        <th class="setting">비고</th>
                                    </tr>
                                    <c:forEach var="item" items="${model.list}" varStatus="status">
                                    <tr data-role="button" class="list_tr update" id="in_${status.index }">
                                    	<input type="hidden" name="idx" value="${item.idx }">
                                    	<td>${item.min_score }</td>
                                    	<td>${item.max_score }</td>
                                    	<td>${item.recess }</td>
                                        <td>${item.NAME }</td>
                                        <td>
                                        	<button type="button"  onclick="image_view('${item.IMAGE}')" data-idx="${item.idx }">상품 이미지 보기</button>
                                        	<button type="button"  onclick="product_delete('${item.idx}')" data-idx="${item.idx }">삭제</button>
                                        </td>
                                    </tr>
                                    </c:forEach>
                                </table>
                            </div>
                        </div>
                        
                        <!--저장하기 버튼-->
                        <div class="register_btn_area">
                            <div class="register_btn_con">
                                <button class="storage" onclick="updateClick()">저장</button>
                            </div>
                        </div>
                        <!--저장하기 버튼 end-->
                        
                        
                    </section>
                    <!--본문 내용 end-->
                </div>
            </div>
        </div>
    </section>
    <!--본문 end-->

    <!--푸터-->
    <footer>
	<%@ include file="../include/footer.jsp" %>
    </footer>
    <!--푸터 end-->

</body>
<script>

$(document).ready(function () {
	
	$(".adm_menu_con > li").eq(2).find(".sub_menu_con").show();
	$(".adm_menu_con > li").eq(2).css({
	    backgroundColor: "#fff"
	});
});
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

//상품 삭제(리스트에서)
function product_delete(idx){
	
	var result = confirm('해당 상품을 현 리스트에서 제거 하시겠습니까?');
	if(result){
		
		$.ajax({
			url : '/admin/exam/product_list/delete.do',
			type : 'POST',
			data : ({
				idx : idx
			}),
			success : function(status , xhr){
				
				console.log('삭제 성공');
				alert('삭제 되었습니다.');
				location.reload();
				
			},
			error : function(error , status , xhr){
				
				console.log('삭제 실패');
				
			}
			
		})
		
	}else{
		
		return;
		
	}
	
}

var product_select;
//상품 추가 모달 open
function selectOpen(btnNum){
	
	var url = '/admin/exam/product_list/select.do';
	
	product_select = window.open(url, '상품 추가', 'width=1600, height=500');
	
	product_select.onload = function(){
		
		console.log(btnNum);
		
		product_select.document.getElementById('btnNum').value = btnNum;
		
	}

}
//상품 리스트 추가
function selectAppend(){
	
	var cnt = $('.list_tr').length;
	
	var html = ``;
	html += `<tr class="list_tr insert" id="in_`+cnt+`">`;
	html += `<input type="hidden" name="pro_idx">`;
	html += `<td><input type="text" name="min_score" oninput="this.value = this.value.replace(/[^0-9]/g, '');" ></td>`;
	html += `<td><input type="text" name="max_score" oninput="this.value = this.value.replace(/[^0-9]/g, '');" ></td>`;
	html += `<td><input type="text" name="recess" oninput="this.value = this.value.replace(/[^0-9]/g, '');" ></td>`;
	html += `<td><input type="text" name="name" readonly="readonly" placeholder="상품 선택 버튼을 클릭"></td>`;
	html += `<td colspan="3"><button type="button" onclick="selectOpen(`+cnt+`)">상품 선택</button></td>`
	html += `</tr>`;
	$('#bootstrap-data-table').append(html);
	
	
}
//등록
function updateClick(){
	
	var bool = confirm('해당 상품 리스트를 저장하시겠습니까?');
	
	if(bool){
		console.log('저장 시작')
		
		updateCnt = $('.list_tr').length;
		if(updateCnt <= 0){
			alert('상품을 최소 한개 추가해주세요.');
			return;
		}
		
		for(var i=0; i < updateCnt; i++){
			
			//insert인지 update인지 구분 (insert 인것만 데이터 넘김)
			if($('#in_'+i).attr('class').includes('insert')){
				//insert
				var min_score = $('#in_'+i+' [name=min_score]').val();
				var max_score = $('#in_'+i+' [name=max_score]').val();
				var name = $('#in_'+i+' [name=name]').val();
				var recess = $('#in_'+i+' [name=recess]').val();
				var pro_idx = $('#in_'+i+' [name=pro_idx]').val();
				var exam_idx = $('[name=exam_idx]').val();
				
				var ProductForm = new FormData();
				ProductForm.append('min_score',min_score);
				ProductForm.append('max_score',max_score);
				ProductForm.append('name',name);
				ProductForm.append('recess',recess);
				ProductForm.append('pro_idx',pro_idx);
				ProductForm.append('exam_idx' , exam_idx);
				
				$.ajax({
					url : '/admin/exam/product_list/insert.do',
					type : 'POST',
					processData : false,
					contentType : false,
					data : ProductForm,
					success : function(status , xhr){
						
						console.log('success');
						
					},
					error : function(error , status , xhr){
						
						console.log('error');
					}
					
					
				})
					
			}
			
		}
		
		
		alert('해당 상품 저장이 완료되었습니다.');
		location.reload();
		
		
	}else{
		return;
	}
	
}

</script>

</html>

