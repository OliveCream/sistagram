<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
    <meta charset="UTF-8">
    <title>index</title>

    <script>
$(document).ready(function() {
    $("#userId").focus();

	$("#userId").keyup(function(e){
		if(e.which == 13){
			fn_login();
		}
	});

	$("#userPwd").keyup(function(e){
		if(e.which == 13){
			fn_login();
		}
	});
	
    $('#userPwd').on('input', function() {
        if ($('#userPwd').val() == '') {
            $('#showPw').css('visibility', 'hidden');
        }

        else {
            $('#showPw').css('visibility', 'visible');
        }
    });

    $('#showPw').on('click',function() {
        var pw = $("#userPwd");
        var pwType = pw.attr('type');

        if (pwType == 'password') {
            pw.attr('type', 'text');
            $('#showPw').attr('src', '/resources/images/visibility_off.png');
        }

        else {
            pw.attr('type', 'password');
            $('#showPw').attr('src', '/resources/images/visibility.png');
        }
    });



});

function fn_login(){	
if($.trim($("#userId").val()).length <= 0){
   	alert("아이디를 입력해 주세요.");
   	$("#userId").val("");
   	$("#userId").focus();
   	return;
}
if($.trim($("#userPwd").val()).length <= 0){
	alert("비밀번호를 입력해 주세요.");
	$("#userPwd").val("");
	$("#userPwd").focus();
	return;
}

$.ajax({
	type:"POST",
	url:"/user/login",
	data:{
		userId:$("#userId").val(),
		userPwd:$("#userPwd").val()
	},
	datatype:"JSON",
	beforeSend:function(xhr){
		xhr.setRequestHeader("AJAX", "true");
	},
	success:function(res){
		if(res.code == 0){
			location.href = "/main/home";
		}
		else if(res.code == -1){
			alert("정지된 회원입니다.");
			$("#userPwd").focus();
		}
		else if(res.code == -2){
			alert("탈퇴한 회원입니다.");
			$("#userPwd").focus();
		}
		else if(res.code == -3){
			alert("퇴출당한 회원입니다.");
			$("#userPwd").focus();
		}
		else if(res.code == -99){
			alert("아이디 또는 비밀번호가 잘못되었습니다.");
			$("#userPwd").focus();
		}
		else if(res.code == 404){
			alert("아이디 또는 비밀번호가 잘못되었습니다.");
			$("#userPwd").focus();
		}
		else if(res.code == 400){
			alert("잘못된 요청");
			$("#userPwd").focus();
		}
		else{
			alert("로그인 중 오류가 발생하였습니다.");
			$("#userPwd").focus();
		}
	},
	error:function(xhr, status, error){
		alert("오류가 발생하였습니다.");
		icia.common.error(error);
	}
});

}
    </script>
</head>
<body>
    <div class="main">
        <div class="container">
            <div class="logo">
                <a href="/index"><img src="/resources/images/Sistagram.png" alt="Instagram" class="brand_logo"></a>
            </div>
            <br />
            <div class="centent">
                <form name="login_form" action="/main/home" method="POST">
                    <div class="input_value">
                        <input type="text" id="userId" name="userId" placeholder="아이디 또는 이메일">
                    </div>
                    <div class="input_value">
                        <input type="password" id="userPwd" name="userPwd" placeholder="비밀번호를 입력하세요">
                        <img class="showPw" id="showPw" name="showPw" src="/resources/images/visibility.png" style="visibility: hidden;">
                    </div>
                    <div class="btn_submit">
                        <button type="button" id="btn_login">로그인</button>
                    </div>
                </form>
                <div>
                    <span id="Check" name="Check"></span>
                </div>
                <div class="or_line">
                    <div class="line"></div>
                    <div class="text">또는</div>
                    <div class="line"></div>
                </div>
                <ul class="find_pw">
                    <li><a href="/user/findPwd">비밀번호를 잊으셨나요?</a></li>
                </ul>
            </div>
        </div>
        <div class="container">
            <span><p style="margin: 15px;">계정이 없으신가요? <a href="/user/signUp"><span style="color: #4cb5f9;">가입하기</span></a></p></span>
        </div>
    </div>
  </body>
</html>