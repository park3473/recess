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
                                    <tr>
                                        <th class="min_score">상품 최소 점수</th>
                                        <th class="max_score">상품 최대 점수</th>
                                        <th class="recess">휴식 시간</th>
                                        <th class="name">상품명</th>
                                        <th class="create_tm">생성일시</th>
                                        <th class="update_tm">수정일시</th>
                                        <th class="setting">비고</th>
                                    </tr>
                                    <c:forEach var="item" items="${model.list}" varStatus="status">
                                    <tr data-role="button" class="list_tr update">
                                    	<input type="hidden" name="idx" value="${item.idx }">
                                    	<td>${item.min_score }</td>
                                    	<td>${item.max_score }</td>
                                    	<td>${item.recess }</td>
                                        <td>${item.NAME }</td>
                                        <td>${item.TYPE }</td>
                                        <td>
                                            ${fn:substring(item.create_tm,0,11)}
                                        </td>
                                        <td>
                                            ${fn:substring(item.update_tm,0,11)}
                                        </td>
                                        <td>
                                        	<button type="button"  onclick="location.href='/admin/product/view.do?idx=${item.pro_idx}'" data-idx="${item.idx }">상품 보기</button>
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

var product_select;

function selectOpen(btnNum){
	
	var url = '/admin/exam/product_list/select.do';
	
	product_select = window.open(url, '상품 추가', 'width=1600, height=500');
	
	product_select.onload = function(){
		
		console.log(btnNum);
		
		product_select.document.getElementById('btnNum').value = btnNum;
		
	}

}

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
			
			//insert인지 update인지 구분 (insert 아니면 update임)
			if($('#in_'+i).attr('class').includes('insert')){
				//insert
				var min_score = $('#in_'+i+' [name=min_score]').val();
				var max_score = $('#in_'+i+' [name=max_score]').val();
				var name = $('#in_'+i+' [name=name]').val();
				var recess = $('#in_'+i+' [name=recess]').val();
				var pro_idx = $('#in_'+i+' [name=pro_idx]').val();
				
				var ProductForm = new FormData();
				ProductForm.append('min_score',min_score);
				ProductForm.append('max_score',max_score);
				ProductForm.append('name',name);
				ProductForm.append('recess',recess);
				ProductForm.append('pro_idx',pro_idx);
				
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
				
				
			}else{
				//update
				//insert
				var min_score = $('#in_'+i+' [name=min_score]').val();
				var max_score = $('#in_'+i+' [name=max_score]').val();
				var name = $('#in_'+i+' [name=name]').val();
				var recess = $('#in_'+i+' [name=recess]').val();
				var pro_idx = $('#in_'+i+' [name=pro_idx]').val();
				var idx = $('#in_'+i+' [name=idx]').val();
				
				var ProductForm = new FormData();
				ProductForm.append('min_score',min_score);
				ProductForm.append('max_score',max_score);
				ProductForm.append('name',name);
				ProductForm.append('recess',recess);
				ProductForm.append('pro_idx',pro_idx);
				ProductForm.append('idx',idx);
				
				$.ajax({
					url : '/admin/exam/product_list/update.do',
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
		
		
		alert('해당 상품 저장이 완료되었습니다.')
		
		
	}else{
		return;
	}
	
}

</script>

</html>

