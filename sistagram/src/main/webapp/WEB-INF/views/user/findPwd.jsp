<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<meta charset="UTF-8">
<title>searchPwd</title>

<script>
$(document).ready(function() {
	
	$("#userEmail").focus();
	

	
	
	
});

function fn_resetPwd(){
	if($.trim($("#userEmail").val()).length <= 0){
		alert("이메일 전화번호 또는 아이디를 입력해 주세요.");
		$("#userEmail").val("");
		$("#userEmail").focus();
		return;
	}
	
	$.ajax({
		type:"POST",
		url:"/user/findPwdProc",
		data:{
			
		},
		datatype:"JSON",
		beforeSend:function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success:function(res){
			
		},
		error:function(xhr, status, error){
			icia.common.error(error);
		}
		
	});
	
	document.findpw_form.action = "/main/home";
	document.findpw_form.submit();
	
}

</script>
</head>
<body>
    <div class="main">
        <div class="container">
            <div class="logo">
                <img src="/resources/images/Sistagram.png" alt="Instagram" class="brand_logo">
            </div>
            <div class="centent">
                <form name="findpw_form"  method="POST">
                    <div class="content_text">
                        <span style="font-weight: bold;">로그인에 문제가 있나요?</span>
                    </div>
                    <div class="content_text">
                        <span style="font-size: 13px;">이메일 주소, 전화번호 또는 아이디를 입력하시면 계정에 다시 액세스할 수 있는 링크를 보내드립니다</span>
                    </div>
                    <div class="input_value">
                        <input type="text" id="userEmail" name="userEmail"  placeholder="이메일, 전화번호, 아이디">
                    </div>
                    <div class="btn_submit">
                        <button onclick="fn_resetPwd()">비밀번호 재설정</button>
                    </div>
                </form>
                <div class="or_line">
                    <div class="line"></div>
                    <div class="text">또는</div>
                    <div class="line"></div>
                </div>
                <ul class="find_pw">
                    <li><a href="/user/signUp">새 계정 만들기</a></li>
                </ul>
            </div>
        </div>
        <div class="container">
            <span><a href="/index">로그인으로 돌아가기</a></span>
        </div>
            </div>
        </div>
    </div>
</body>
</html>