<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/include/head_main.jsp" %>
<link rel="stylesheet" type="text/css" href="/resources/css/profile.css">

<script type="text/javascript">
$(document).ready(function(){
	
});


function fn_toggleFollow(button, userId) {
    // 버튼의 텍스트와 스타일을 변경합니다.
    if (button.innerText === "팔로우") {
        
    	$.ajax({
    		type:"POST",
    		url:"/user/followingProc",
    		data:{
    			followingId:userId		//$("#boardNum").val()
    		},
    		datatype:"JSON",
    		beforeSend:function(xhr){
    			xhr.setRequestHeader("AJAX", "true");
    		},
    		success:function(res){
    			if(res.code == 200){
    				alert("팔로잉 성공");
    			}
    			else{
    				alert("팔로잉 실패");
    			}
    		},
    		error:function(xhr, status, error){
    			alert("팔로잉 중 예상치 못한 오류가 발생하였습니다.");
    			icia.common.error(error);
    		}
    	});
    	
    	button.innerText = "팔로잉";
        button.style.color = "gray";
    
    } else {
    	if(confirm("팔로우 취소 하시겠습니까?")){
	    	$.ajax({
	    		type:"POST",
	    		url:"/user/followingCancelProc",
	    		data:{
	    			followingId:userId
	    		},
	    		datatype:"JSON",
	    		beforeSend:function(xhr){
	    			xhr.setRequestHeader("AJAX", "true");
	    		},
	    		success:function(res){
	    			if(res.code == 200){
	    				alert("팔로잉 취소 성공");
	    			}
	    			else{
	    				alert("팔로잉 취소 실패");
	    			}
	    		},
	    		error:function(xhr, status, error){
	    			alert("팔로잉 취소 중 예상치 못한 오류가 발생하였습니다.");
	    			icia.common.error(error);
	    		}
	    	});
	    	
	        button.innerText = "팔로우";
	        button.style.color = "#4cb5f9";
    	}
    }
    // 여기서는 실제로 서버로 데이터를 보내어 팔로우 상태를 업데이트할 수 있습니다.
}



function fn_boardDetail(boardNum){
// 	alert(boardNum);
	document.profileForm.boardNum.value = boardNum;
	document.profileForm.action = "/main/boardDetail";
	document.profileForm.submit();
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
<section class="section-submit"><br />
                                <b style="font: inherit;font-size: 25px;font-weight: bold;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;프로필</b>
        
		<section class="section-img">
		    <div class="profile-image-container">
		        <img id="userFileImg" name="userFileImg" src="/resources/upload/${user.fileName}" alt="profile.jpg" onerror="this.src='/resources/images/default_profile.png';" class="profile-image"/>
		    </div>
		       <div style="margin-left: 60px; display: flex; flex-direction: column; justify-content: space-between;">
		            <div style="display: flex; align-items: center;">
		                <div style=" flex-grow: 1; width: auto;">
		                    <b class="userId-container">${user.userId}</b> <br /><br />
		                    <p class="follow-board">게시물 ${list.size()} &nbsp;&nbsp;<span id="followerCount" style="cursor:pointer;">팔로워 ${followerList.size()}</span> &nbsp;&nbsp;<span id="followingCount" style="cursor:pointer;">팔로잉 ${followingList.size()}</span></p><br />
		                    <p class="userName-container">${user.userName}</p>
		                    <p class="userIntro-container">${user.userIntro}</p>
		                </div>
		            </div>
		        </div>
				<div>
					<button id="changeImg" class="button-img" onclick="location.href='/user/update'" style="margin-left:100px;">프로필 편집</button>
				</div>
		
		    		<input type="file" id="userFile" name="userFile" accept="image/*" style="display:none">
		</section>

<hr>
<br />

<div>

	<table border="1">
	    <c:forEach var="insBoard" items="${list}" varStatus="status">
	        <c:if test="${status.index % 3 == 0}">
	            <tr>
	        </c:if>
			        <td>
			        	<div class="boardImg-container">
			            	<img class="profile-boardImg" src="/resources/upload/${insBoard.fileName}" >
			            	<div class="overlay" onclick="fn_boardDetail(${insBoard.boardNum})">
	                    		<div class="heart-icon">❤︎ <div class="numberr">28</div><c:if test="${insBoard.commentCnt != 0}">🗨️ <div class="numberr">${insBoard.commentCnt}</div></c:if>  </div>
	                		</div>
			            </div>
			        </td>
	        <c:if test="${status.index % 3 == 2 || status.last}">
	            </tr>
	        </c:if>
	    </c:forEach>
	</table>

</div>

</section>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>



<!-- 팔로잉 모달 창 -->
<div id ="follow-list" class="modal_overlay" >
	<div class="modal_window" style="width:30%;">
		<div class="modal-title">
			<div class="modal-title-side"></div>
			<div style="margin:5px;">팔로잉 목록</div>
			<div class="modal-title-side" style="cursor:pointer;">
				<span id ="follow-list-close" class="material-icons-outlined" >  <!-- onClick="closeModal()"  -->
				X
				</span>
			</div>
		</div>
		<hr class="black-line"><br /><br />

<c:if test="${!empty followingList}">
	<c:forEach var="following" items="${followingList}" varStatus="status">
				<div style="width: 90%; margin: 0 auto;">
				    <div style="padding: 10px;">
				        <div style="display: flex; flex-direction: row; justify-content: space-between;">
				            <div style="margin-right: 10px;">
				                <div style="cursor: pointer;">
				                    <img onclick="fn_profileSomeone('${following.userId}')" src="/resources/upload/${following.fileName}" onerror="this.src='/resources/images/default_profile.png';" alt="img" style="width: 44px; height: 44px; border-radius: 50%;">
				                </div>
				            </div>
				            <div style="width: 100%; display: flex;">
				                <div style="display: flex; flex-direction: column; justify-content: center; flex-grow: 1;">
				                    <div>
				                        <div style=" margin-bottom:5px;">
				                            <span style="font-weight: bold; cursor:pointer;" onclick="fn_profileSomeone('${following.userId}')">${following.userId}</span>
				                        </div>
				                    </div>
				                    <div >
				                        <span style="cursor:pointer;" onclick="fn_profileSomeone('${following.userId}', this)">${following.userName}</span>
				                    </div>
				                </div>
				            </div>
				
				            <div style="display: flex; ">
				                <div class="followButton" style="display: flex; align-items: center; flex-shrink: 0; ">
				                    <span class="followText" style="font-size: 12px; font-weight:bold; color: gray; cursor:pointer;" onclick="fn_toggleFollow(this, '${following.userId}')">팔로잉</span>
				                </div>
				            </div>
				
				        </div>
				    </div>
				</div>
	</c:forEach>
</c:if>

	</div>
</div>

<!-- 팔로워 모달 창 -->
<div id ="follower-list" class="modal_overlay" >
	<div class="modal_window" style="width:30%;">
		<div class="modal-title">
			<div class="modal-title-side"></div>
			<div style="margin:5px;">팔로워 목록</div>
			<div class="modal-title-side" style="cursor:pointer;">
				<span id ="follower-list-close" class="material-icons-outlined" >  <!-- onClick="closeModal()"  -->
				X
				</span>
			</div>
		</div>
		<hr class="black-line"><br /><br />

<c:if test="${!empty followerList}">
	<c:forEach var="follower" items="${followerList}" varStatus="status">
				<div style="width: 90%; margin: 0 auto;">
				    <div style="padding: 10px;">
				        <div style="display: flex; flex-direction: row; justify-content: space-between;">
				            <div style="margin-right: 10px;">
				                <div style="cursor: pointer;">
				                    <img onclick="fn_profileSomeone('${follower.userId}')" src="/resources/upload/${follower.fileName}" onerror="this.src='/resources/images/default_profile.png';" alt="img" style="width: 44px; height: 44px; border-radius: 50%;">
				                </div>
				            </div>
				            <div style="width: 100%; display: flex;">
				                <div style="display: flex; flex-direction: column; justify-content: center; flex-grow: 1;">
				                    <div>
				                        <div style=" margin-bottom:5px;">
				                            <span style="font-weight: bold; cursor:pointer;" onclick="fn_profileSomeone('${follower.userId}')">${follower.userId}</span>
				                        </div>
				                    </div>
				                    <div >
				                        <span style="cursor:pointer;" onclick="fn_profileSomeone('${follower.userId}', this)">${follower.userName}</span>
				                    </div>
				                </div>
				            </div>
				
				            <div style="display: flex; ">
				                <div class="followButton" style="display: flex; align-items: center; flex-shrink: 0; ">
				                    <span class="followText" style="font-size: 12px; font-weight:bold; color: #4cb5f9; cursor:pointer;" onclick="fn_toggleFollow(this, '${follower.userId}')">팔로우</span>
				                </div>
				            </div>
				
				        </div>
				    </div>
				</div>
	</c:forEach>
</c:if>

	</div>
</div>

<!-- jQuery 로드 -->
<script src="/resources/js/jquery-3.5.1.min.js"></script>

<!-- 스크립트 -->
<script>
$(document).ready(function() {
    // 팔로잉 표시 클릭 시 모달 열기
    $("#followingCount").on("click", function() {
    	var scrollTop = $(window).scrollTop();
    	
		$('#follow-list').css({
			display : 'flex',
			top: scrollTop + 'px'
		});
		
		$(document.body).css({
			overflow : 'hidden'
		});
    });

	//X 클릭시 팔로잉 모달 닫기
	$("#follow-list-close").on("click", function(){
		
		$('#follow-list').css({
			display : 'none'
		});	
		$(document.body).css({
			overflow : 'auto'
		});
		location.href = "/main/profile";
	});
	
	
	//팔로워 표시 클릭 시 모달 열기 followerCount
    $("#followerCount").on("click", function() {
    	var scrollTop = $(window).scrollTop();
    	
		$('#follower-list').css({
			display : 'flex',
			top: scrollTop + 'px'
		});
		
		$(document.body).css({
			overflow : 'hidden'
		});
    });
	
	//X 클릭시 팔로워 모달 닫기
	$("#follower-list-close").on("click", function(){
		
		$('#follower-list').css({
			display : 'none'
		});	
		$(document.body).css({
			overflow : 'auto'
		});
		
		location.href = "/main/profile";
	});
});
</script>



<form id="profileForm" name="profileForm" method="post">
	<input id="boardNum" name="boardNum" value="" />
</form>
</body>
</html>