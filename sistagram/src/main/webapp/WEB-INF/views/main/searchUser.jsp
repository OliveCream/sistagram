<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/include/head_main.jsp" %>
<link rel="stylesheet" type="text/css" href="/resources/css/searchUser.css">

<script type="text/javascript">
$(document).ready(function(){
	
	$("#searchUser").focus();
	
	$("#searchUser").keyup(function(e){
		if(e.which == 13){
			fn_searchUser();
		}
	});
	
// 	$("#someIdd").on("click", function(){
// 		document.searchForm.someId.value = $("#someIdd").val();
// 		alert($("#someIdd").val());
// 	});
	
});


function fn_searchUser(){
	document.searchForm.searchValue.value = $("#searchUser").val();
	document.searchForm.action = "/main/searchUser";
	document.searchForm.submit();
}

function fn_clear(){
	$("#searchUser").val("");
}

function fn_profileSomeone(userId){
	
	document.searchForm.someId.value = userId;
// 	alert($("#someId").val());
// 	alert('${cookieUserId}');
	if('${cookieUserId}' !== $("#someId").val()){
// 		alert("성공");
		
		document.searchForm.action = "/main/profileSomeone";
		document.searchForm.submit();
	}
	else{
		location.href = "/main/profile";
	}
}

</script>

</head>
<body>

<form id="searchForm" name="searchForm" method="post">
	<input type="hidden" id="searchValue" name="searchValue" value="${searchValue}" />
	<input type="hidden" id="boardNum" name="boardNum" value="" />
	<input type="hidden" id="someId" name="someId" value="" />
</form>

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
                                <b style="font: inherit;font-size: 25px;font-weight: bold;">&nbsp;&nbsp;&nbsp;검색</b>
        
		<div style="position: relative; display: inline-block; margin-top:5px; margin-bottom:-5px">
		    <label for="userPwd">&nbsp;</label>
		    <input class="input-search" type="text" id="searchUser" name="searchUser" value="${searchValue}" placeholder="검색">
<%-- 		    <input type="hidden" id="searchValue" name="searchValue" value="${searchValue}" /> --%>
		        <span id="close-search" onClick="fn_clear()" style="position: absolute; right: 20px; top:40%; cursor: pointer; font-weight: bold;">x</span>

		</div>
		
		<section class="section-img">
			<div style="width: 100%;">
<c:if test="${!empty list}">			        
	<c:forEach var="user" items="${list}" varStatus="status">
			    <div class="user-list" style="padding: 10px; ">
			        <div style="display: flex; flex-direction: row; justify-content: space-between;">
			            <div style="margin-right: 10px;">
			                <div style="cursor: pointer;">
			                    <img src="/resources/upload/${user.fileName}" onerror="this.src='/resources/images/default_profile.png';" alt="img" style="width: 42px; height: 42px; border-radius: 50%;">
			                </div>
			            </div>
			            <div style="width: 100%; display: flex;">
			                <div style="display: flex; flex-direction: column; justify-content: center; flex-grow: 1;">
			                    <div>
			                        <div>
			                            <span id="someIdd" name="someIdd" onclick="fn_profileSomeone('${user.userId}')" style="font-weight: bold; cursor:pointer;"  >${user.userId}</span>
			                        </div>
			                    </div>
			                    <div>
			                        <span>${user.userName}</span>
			                    </div>
			                </div>
			            </div>
			        </div>
			    </div>
	</c:forEach>
</c:if>	
			</div>
		</section>
</section>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>



</body>
</html>