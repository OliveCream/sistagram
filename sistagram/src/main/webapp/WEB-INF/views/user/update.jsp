<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update your profile</title>
<%@ include file="/WEB-INF/views/include/head_main.jsp" %>
<link rel="stylesheet" type="text/css" href="/resources/css/update.css">

<script type="text/javascript">

$(document).ready(function(){
	//글자수 띄우기 + 제한
	$("#userIntro").on("input", function(){
		$("#counter").html(+$(this).val().length+ "/150");
		
		if($(this).val().length > 150){
			$(this).val($(this).val().substring(0, 150));
	        $("#counter").html("150/150");
		}
	});
	
	//비밀번호 숨기기/보이기
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


//제출버튼 클릭시 실행 함수
function saveProfile(){
	
	//공백체크
	var emptCheck = /\s/g;
	//영문 대소문자, 숫자로만 이루어진 4~12자리 정규식
	var idPwdCheck = /^[a-zA-Z0-9]{4,16}$/;
	//숫자만 정규식
	var numCheck = /^[0-9]+$/; 
	
	var errChk = false;		//이메일 중복 없을 시 fn_userUpdate()로 보내기
	
	if($.trim($("#userEmail").val()) <= 0){
		alert("이메일은 필수 입력사항입니다.");
		$("#userEmail").focus();
		return;
	}
	
	if(onEmailInput() == false){
		alert("이메일 형식이 올바르지 않습니다.");
		$("#userEmail").focus();
		return;
	}
	
	if($.trim($("#userName").val()) <= 0){
		alert("이름을 입력해주세요.");
		$("#userName").val("");
		$("#userName").focus();
		return;
	 }
	if(emptCheck.test($("#userName").val())){
		alert("이름에는 공백을 포함할 수 없습니다.");
		$("#userName").focus();
		return;
	}
	if(numCheck.test($.trim($("#userName").val()))){
		alert("잘못된 이름입니다.(숫자만 사용 불가)");
		$("#userName").focus();
		return;
	}
	
	if($.trim($("#userPwd").val()).length <= 0){
		alert("변경하실 비밀번호를 입력해주세요.");
		$("#userPwd").val("");
		$("#userPwd").focus();
		return;
	}
	if(emptCheck.test($("#userPwd").val())){
		alert("비밀번호는 공백을 포함할 수 없습니다.");
		$("#userPwd").focus();
		return;
	}
	if(!idPwdCheck.test($("#userPwd").val())){
		alert("비밀번호는 4~16자의 영어 대소문자 및 숫자로만 입력가능합니다.");
		$("#userPwd").focus();
		return;
	}
	
	
	
	if($("#userEmail").val() != "${user.userEmail}"){
		
		$.ajax({
    		type:"POST",
    		url:"/user/emailChk",
    		async: false,			// AJAX 요청이 비동기적이지 않고 동기적으로 처리되도록 설정(권장x)
    		data:{
    			userEmail:$("#userEmail").val()
    		},
    		datatype:"JSON",
    		beforeSend:function(xhr){
    			xhr.setRequestHeader("AJAX", "true");
    		},
    		success:function(res){
				if(res.code == 1){
					alert("해당 이메일은 이미 사용 중입니다.");
					$("#userEmail").focus();
					return;
				}
				else if(res.code == 0){
					alert("이메일 사용가능능");
					errChk = true;
					return;
				}
				else{
					alert("이메일 중복체크 중 오류가 발생하였습니다.");
					return;
				}
    		},
    		error:function(xhr, status, error){
    			alert("이메일 중복체크 중 예상치 못한 오류가 발생하였습니다.");
    			icia.common.error(error);
    		},
//     		callback:function(e){
//     			fn_userUpdate();
//     		}
		});
	}
	else{
		errChk = true;
	}
	
	if(errChk){
		fn_userUpdate();
	}
	
}

//회원 정보 수정 ajax
function fn_userUpdate(){
	
	var formData = new FormData($("#profileForm")[0]);
	console.log(formData.values());

	$.ajax({
		type:"POST",
		enctype:"multipart/form-data",
		url:"/user/updateProc",
		data:formData,
		processData:false,		// false로 설정하면 jQuery는 데이터를 문자열로 변환하지 않는다(기본값 true)
		contentType:false,		//false로 설정하면 jQuery가 기본적으로 설정하는  Content-Type 헤더를 사용하지 않는다 
		cache:false,			//get 요청일 때 :  브라우저가 이전에 받은 응답을 캐시하지 않도록
		beforeSend:function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success:function(res){
			if(res.code == 200){
				alert("회원정보 수정이 정상적으로 처리되었습니다.");
				location.href = "/user/update";
			}else if(res.code == 404){
				alert("회원 정보가 존재하지 않습니다.");
				return;
			}
			else{
				alert("회원정보수정 중 오류가 발생하였습니다.");
				return;
			}
		},
		error:function(xhr, status, error){
			alert("회원정보수정 중 예상치 못한 오류가 발생하였습니다.");
			icia.common.error(error);
		}
		
	});
}


//실시간 이메일 형식 띄우기
function onEmailInput(){
	if(!fn_Email($("#userEmail").val())){
		emailError.textContent = "  이메일 형식이 올바르지 않습니다.";
		return false;
	}
	else{//이메일 제대로 입력했을 경우
		//중복된 이메일인지 확인
		emailError.textContent = "";
		return true;
	}
}

//실시간 소개글 초과 문구 띄우기
function onIntroInput(){
	if($(this).val().length >= 150){
		introError.textContent = "소개글 글자수를 초과하셨습니다.";
	}
}


function fn_Email(value)
{
   var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
   
   return emailReg.test(value);
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
                                <b style="font: inherit;font-size: 25px;font-weight: bold;">&nbsp;프로필 편집</b>
                                <section class="section-img">
                                <img id="userFileImg" name="userFileImg" src="/resources/upload/${user.fileName}" alt="profile.jpg" onerror="this.src='/resources/images/default_profile.png';" class="profile-image"/>
                                <div>
                                   <b style="font-weight: bold; font-size: 20px; ">&nbsp;&nbsp;${user.userId}</b>
                                   <h5 style="font-size:8;">&nbsp;&nbsp;${user.userName}</h5>
                                </div>
                                <button id="changeImg" class="button-img" onclick="$('#userFile').click();">사진 변경</button>
                                
	<form id="profileForm" name="profileForm" enctype="multipart/form-data">
                                <input type="file" id="userFile" name="userFile" accept="image/*" style="display:none">
                                </section>
		<input type="hidden" id="userId" name="userId" value="${user.userId}" />
        <label for="userName">&nbsp;사용자 이름</label>
        <input type="text" id="userName" name="userName" value="${user.userName}" placeholder="사용자 이름을 입력해주세요." required>
        
		<div style="position: relative; display: inline-block; margin-top:5px; margin-bottom:-5px">
		    <label for="userPwd">&nbsp;비밀번호</label>
		    <input class="input-pwd" type="password" id="userPwd" name="userPwd" value="${user.userPwd}" placeholder="변경하실 비밀번호를 입력해주세요.(필수)">
		    <img class="showPw" id="showPw" name="showPw" src="/resources/images/visibility.png" >
		</div>

        <label for="userEmail">&nbsp;이메일</label>
        <input type="email" id="userEmail" name="userEmail" value="${user.userEmail}" oninput="onEmailInput()" placeholder="사용자 이메일을 입력해주세요. (필수)" required>
        <div id="emailError" style="font-size: 12px; color: red; margin-left:10px; margin-top: -5px;margin-bottom: 20px;"></div>
        
        <label for="userPhone">&nbsp;연락처</label>
        <input type="text" id="userPhone" name="userPhone" value="${user.userPhone}" placeholder="사용자 연락처를 입력해주세요." required>

        <label for="userIntro">&nbsp;소개</label>
		<textarea id="userIntro" name="userIntro" class="intro-style" placeholder="자기소개를 입력해주세요." style="font-size: 13px;" required>${user.userIntro}</textarea>
		<a id="counter" style="color:#aaa; display: block; text-align: right;">0/150</a> 
		<br />
        <button type="button" onclick="saveProfile()" class="button-submitt" style="margin-bottom:20px;">제출</button>
    </form>
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