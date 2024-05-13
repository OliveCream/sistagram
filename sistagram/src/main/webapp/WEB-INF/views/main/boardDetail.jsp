<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/include/head_main.jsp" %>
<link rel="stylesheet" type="text/css" href="/resources/css/boardDetail.css">

<style>
.highlight {
    color: blue; /* 변경할 색상 설정 */
    font-weight: bold; /* 기타 스타일 지정 가능 */

}
</style>

<script type="text/javascript">
$(document).ready(function(){
	$("#comment").focus();
	
// 	$("#boardNum").val() = ${boardNum};
	
	//게시 버튼 클릭시 실행 함수
	$(document).on("click", "#btnCommentPost", function(){	//기존 온클릭 이벤트 적용 안될 시 이렇게 바꿔보기
		alert("되나");
	
		if($.trim($("#comment").val()).length <= 0){
			alert("댓글 내용을 입력해주세요.");
			alert("댓글 그룹 번호 - " + $("#commentGroup").val());
			return;
		}
		
		fn_commentProc($("#commentGroup").val());
		
	});

});

function fn_comment(commentGroup, groupId){		//댓글 달기 클릭시 실행 함수
	alert("매개변수 그룹 - " + commentGroup);
	alert("게시글 번호 - " + $("#boardNum").val());
	alert("댓글 그룹 번호 - " + $("#commentGroup").val());
	alert("매개변수 groupId -- " + groupId);
	
	$("#commentGroup").val(commentGroup);
	
	alert("댓글 그룹 번호 세팅 후 - " + $("#commentGroup").val());
	
	$("#comment").val("");		//해당 댓글 쓴 id 태그
	
	$("#comment").focus();
	
	
	
    // 백스페이스 키를 누르면 입력된 값과 commentGroup 초기화
    $("#comment").on("keydown", function(event){
		if(event.keyCode === 8){
			$("#commentGroup").val("");
			$("#comment").val("");
		}
    });
    
    $("#comment").val('@' + groupId + ' ');

}

function fn_commentProc(commentGroup){		//댓글 등록 Proc
	
	$.ajax({
		type:"POST",
		url:"/main/commentProc",
		data:{
			boardNum:$("#boardNum").val(),
			comment:$("#comment").val(),
			commentGroup:commentGroup
		},
		datatype:"JSON",
		beforeSend:function(xhr){
			xhr.setRequestHeader("AJAX", "true");
			alert("commentGroup 매개변수 -- " + commentGroup);
			alert("commentGroup 히든 -- " + $("#commentGroup").val());
		},
		success:function(res){
			if(res.code == 200){
				alert("댓글 등록 성공");
				location.reload();
			}
			else{
				alert(res.code);
				alert("댓글 등록 중 오류가 발생하였습니다.");
			}
		},
		error:function(xhr, status, error){
			alert("게시 중 예상치 못한 오류가 발생하였습니다.");
			icia.common.error(error);
		}
	});
}


</script>

</head>
<body>
<div>
    <div>
        <div>
            <div class="main">
                <div class="container">
                    <div>
                        <div>
                            <%@ include file="/WEB-INF/views/include/navigation.jsp"%>
                            <br />
                            <section class="section-submit">
                                <div style="display: flex; justify-content: space-between;">
                                    <!-- 왼쪽에 이미지 넣기 -->
                                    <div class="boardDetail-img" style="flex-grow: 0; display: flex; align-items: center; background-color:black; border-radius: 5px;">
                                        <img src="/resources/upload/${insBoard.fileName}" onerror="this.src='/resources/images/default_profile.png';" alt="프로필 이미지" style="width: 450px; height:auto;">
                                    </div>
                                    <!-- 오른쪽에 댓글 넣기 -->
                                    <div style="flex-grow: 1; overflow-y: auto; margin-left:30px;">
<!-- 게시글 작성자 + 게시글 내용 -->                                        
									    <div class="user-list" style="padding: 10px; ">
									        <div style="display: flex; flex-direction: row; justify-content: space-between;">
									            <div style="margin-right: 10px;">
									                <div style="cursor: pointer;">
									                    <img src="/resources/upload/${boardUser.fileName}" onerror="this.src='/resources/images/default_profile.png';" alt="img" style="width: 38px; height: 38px; border-radius: 50%;">
									                </div>
									            </div>
									            <div style="width: 100%; display: flex;">
									                <div style="display: flex; flex-direction: column; justify-content: center; flex-grow: 1;">
									                    <div>
									                        <div>
									                            <span style="font-weight: bold;">${boardUser.userId}</span>
									                        </div>
									                    </div>
									                    <div>
									                        <span style="font-size: 12px;">${boardUser.userName} <b style="text-align: right; margin-left:200px;"> ${insBoard.regDate}</b></span>
									                    </div>
									                </div>
									            </div>
									        </div>
									    </div>
                                        
                                        <p></p><hr>
<!-- 댓글 박스 시작 -->
                                        <div style="height: 500px; width:450px; overflow-y: auto;">
                                            <!-- 댓글이 많을 경우 스크롤이 생성됩니다 -->
                                            <ul>
	<!--글 작성자 + 글내용 시작-->
                                            <div class="comment-list" >
										        <div style="display: flex; flex-direction: row; justify-content: space-between;">
										            <div style="margin-right: 10px;">
										                <div style="cursor: pointer;">
										                    <img src="/resources/upload/${boardUser.fileName}" onerror="this.src='/resources/images/default_profile.png';" alt="img" style="width: 38px; height: 38px; border-radius: 50%;">
										                </div>
										            </div>
										            <div style="width: 100%; display: flex;">
										                <div style="display: flex; flex-direction: column; justify-content: center; flex-grow: 1;">
										                    <div>
										                        <p style="font-size: 15px;"><b style="font-weight:bold">${insBoard.userId}</b>&nbsp;&nbsp;${insBoard.boardContent}</p>
										                    </div>
										                </div>
										            </div>
										        </div>
										    </div>
	<!--글 작성자 + 글내용 끝-->
	<!--댓글 시작-->
		<c:if test="${!empty commentList}">
			<c:forEach var="insComment" items="${commentList}" varStatus="status">
					<c:if test="${insComment.commentParent eq 0}">
										    <div class="comment-list" >
										        <div style="display: flex; flex-direction: row; justify-content: space-between; margin-bottom:5px;">
										            <div style="margin-right: 10px;">
										                <div style="cursor: pointer;">
										                    <img src="/resources/upload/${insComment.fileName}" onerror="this.src='/resources/images/default_profile.png';" alt="img" style="width: 38px; height: 38px; border-radius: 50%;">
										                </div>
										            </div>
										            <div style="width: 100%; display: flex;">
										                <div style="display: flex; flex-direction: column; justify-content: center; flex-grow: 1;">
										                    <div>
										                    	<p style="font-size: 15px;"><b style="font-weight:bold">${insComment.userId}</b>&nbsp;&nbsp;${insComment.commentContent}</p>
										                    	<span style="font-size: 11px; color:gray;">
										                    		<b style="margin-left:px;font-weight:bold; ">좋아요 5개</b>
										                    		<b style="margin-left:15px;font-weight:bold; cursor:pointer" onclick="fn_comment(${insComment.commentGroup}, '${insComment.userId}')" >답글달기</b>
										                    		<b style="margin-left:15px; font-weight: thin;">${insComment.regDate}</b>
										                    	</span>
										                    </div>
										                </div>
										            </div>
										        </div>
										    </div>
					</c:if>
										
					<c:if test="${insComment.commentParent eq 1}">
										    <div class="comment-list" >
										        <div style="margin-left:50px; margin-top:-10px; margin-bottom:-5px; display: flex; flex-direction: row; justify-content: space-between;">
										            <div style="margin-right: 10px;">
										                <div style="cursor: pointer;">
										                    <img src="/resources/upload/${insComment.fileName}" onerror="this.src='/resources/images/default_profile.png';" alt="img" style="width: 38px; height: 38px; border-radius: 50%;">
										                </div>
										            </div>
										            <div style="width: 100%; display: flex;">
										                <div style="display: flex; flex-direction: column; justify-content: center; flex-grow: 1;">
										                    <div>
										                    	<p style="font-size: 15px;"><b style="font-weight:bold">${insComment.userId}</b>&nbsp;&nbsp;${insComment.commentContent}</p>
										                    	<span style="font-size: 11px; color:gray;">
										                    		<b style="margin-left:px;font-weight:bold; ">좋아요 5개</b>
										                    		<b style="margin-left:15px;font-weight:bold; cursor:pointer"  onclick="fn_comment(${insComment.commentGroup}, '${insComment.userId}')"  >답글달기</b>
										                    		<b style="margin-left:15px; font-weight: thin;">${insComment.regDate}</b>
										                    	</span>										                    
										                    </div>
										                </div>
										            </div>
										        </div>
										    </div>
							
					</c:if>
					
			</c:forEach>
		</c:if>
	<!--댓글 끝-->
                                                <!-- 댓글이 많아질 경우 추가 -->
                                            </ul>
                                        </div>
<!-- 댓글 박스 끝 -->
<br />
<hr>
                                        <!-- 여기에 댓글 관련 코드를 넣으세요 -->
                                        <br />
<!--                                         <form id="commentForm" name="commentForm" method="post"> -->
                                            <input type="text" id="comment" name="comment" style="outline: none;"><br>
                                            <input type="hidden" id="commentGroup" name="commentGroup" value="">
                                            <button class="btn-comment" id="btnCommentPost" >게시</button>
<!--                                         </form> -->
                                    </div>
                                </div>
                            </section>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<form id="boardDetailForm" name="boardDetailForm" method="post">
	<input type="hidden" id="cookieUserId" name="cookieUserId" value="${cookieUserId}" />
	<input type="hidden" id="userId" name="userId" value="" />
	<input type="hidden" id="boardNum" name="boardNum" value="${boardNum}" />
</form>

</body>
</html>