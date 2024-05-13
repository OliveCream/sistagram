<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
    <meta charset="UTF-8">
    <title>signUp</title>

    <script>
        $(document).ready(function() {
            $("#userId").focus();

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
            
            
            $("#btn_signup").on("click", function(){
            	
         	   //공백체크
         	   var emptCheck = /\s/g;
         	   //영문 대소문자, 숫자로만 이루어진 4~12자리 정규식
         	   var idPwdCheck = /^[a-zA-Z0-9]{4,16}$/;
         	   //숫자만 정규식
         	   var numCheck = /^[0-9]+$/; 
         	   
         	   if($.trim($("#userId").val()).length <= 0){
         			alert("사용하실 아이디를 입력하세요.");
         			$("#userId").val("");
         			$("#userId").focus();
         			return;
         		}
         	   if(emptCheck.test($("#userId").val())){
         		   alert("아이디에는 공백을 포함할 수 없습니다.");
         		   $("#userId").focus();
         		   return;
         	   }
         	   if(!idPwdCheck.test($("#userId").val())){
         		   alert("아이디는 4~16자의 영문 대소문자 및 숫자로만 입력가능합니다.");
         		   $("#userId").focus();
         		   return;
         	   }
         	   if(numCheck.test($.trim($("#userId").val()))){
         		   alert("아이디는 숫자만 입력 불가능합니다. 4~16자의 영문 대소문자 및 숫자로 입력해 주세요.");
         		  $("#userId").focus();
         		   return;
         	   }
         	   
         	   if($.trim($("#userPwd").val()).length <= 0){
         		   alert("사용하실 비밀번호를 입력하세요.");
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
         	   
         	   
         	   if($.trim($("#userName").val()) <= 0){
         		   alert("이름을 입력하세요.");
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
         	   
         	   if($.trim($("#userEmail").val()) <= 0){
         		   alert("사용하실 이메일을 입력하세요.");
         		   $("#userEmail").val("");
         		   $("#userEmail").focus();
         		   return;
         	   }
         	   if(!fn_Email($("#userEmail").val())){
         		   alert("사용자 이메일 형식이 올바르지 않습니다.");
         		   $("#userEmail").focus()
         		   return;;
         	   }
         	   
         	   alert("비밀번호를 확인하셨습니까?.");
	       		
         	   //var form = $("#signup_form")[0];
	    		//var formData = new FormData(form);
         	   
	    		$.ajax({
	    			type:"POST",
	    			url:"/user/idEmailCheck",
	    			data:{
	    				userId:$("#userId").val(),
	    				userEmail:$("#userEmail").val()
	    			},
	    			datatype:"JSON",
	    			beforeSend:function(xhr){
	    				xhr.setRequestHeader("AJAX", "true");
	    			},
	    			success:function(res){
	    				if(res.code == 0){
	    					alert("중복아이디 없습니다. 회원가입이 가능합니다.");
	    					fn_signUpProc();
	    				}
	    				else if(res.code == -1){
	    					alert("중복 아이디가 존재합니다.");
	    					$("#userId").focus();
	    				}
	    				else if(res.code == -2){
	    					alert("중복 이메일이 존재합니다.");
	    					$("#userEmail").focus();
	    				}
	    				else if(res.code == 400){
	    					alert("파라미터 값이 올바르지 않습니다.");
	    					$("#userId").focus();
	    				}
	    				else{
	    					alert("예상치 못한 오류가 발생하였습니다.");
	    					$("#userId").focus();
	    				}
	    			},
	    			error:function(xhr, status, error){
	    				icia.common.error(error);
	    			}
	    		});
     
            	
            });
            
        });

	function fn_signUpProc(){
		$.ajax({
			type:"POST",
			url:"/user/signUpProc",
			data:{
				userId:$("#userId").val(),
				userPwd:$("#userPwd").val(),
				userName:$("#userName").val(),
				userEmail:$("#userEmail").val()
			},
			datatype:"JSON",
			beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(res){
				
				if(res.code == 0){
					alert("회원가입 성공");
					location.href = "/index";
				}
				else if(res.code == -1){
					alert("회원 아이디가 중복되었습니다.");
					$("#userId").focus();
				}
				else if(res.code == 400){
					alert("파라미터값이 올바르지 않습니다.");
					$("#userId").focus();
				}
				else if(res.code == 500){
					alert("회원가입 중 오류가 발생하였습니다.");
					$("#userId").focus();
				}
				else{
					alert("회원가입 중 예상치 못한 오류가 발생하였습니다.");
					$("#userId").focus();
				}
			},
			error:function(xhr, status, error){
				icia.common.error(error);
			}
		});
	}
	
        
	function fn_Email(value)
	{
	   var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
	   
	   return emailReg.test(value);
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
                <form name="signup_form" id="signup_form" action="" method="POST">
                    <div class="content_text">
                        <span style="font-weight: bold; color:gray; ">친구들의 사진과 동영상을 보려면 가입하세요</span>
                    </div>
                    <br />
                    <div class="input_value">
                        <input type="text" id="userId" name="userId"  placeholder="아이디">
                    </div>
                    <div class="input_value">
                        <input type="password" id="userPwd" name="userPwd" placeholder="비밀번호를 입력하세요">
                        <img class="showPw" id="showPw" name="showPw" src="/resources/images/visibility.png" style="visibility: hidden;">
                    </div>
                    <div class="input_value">
                        <input type="text" id="userName" name="userName"  placeholder="사용자 이름">
                    </div>
                    <div class="input_value">
                        <input type="text" id="userEmail" name="userEmail"  placeholder="이메일">
                    </div>
                    <div class="input_value" style="margin-top: 12px; margin-bottom: 12px; font-size:12px;">
                        저희 서비스를 이용하는 사람이 회원님의 연락처 정보를 Instagram에 업로드했을 수도 있습니다. 더 알아보기
                    </div>
                    
                    <div class="btn_submit">
                        <button type="button" id="btn_signup">가입</button>
                    </div>
                </form>
            </div>
        </div>
        <div class="container">
            <span><p style="margin: 15px;">계정이 있으신가요? <a href="/index"><span style="color: #4cb5f9;">로그인</span></a></p></span>
        </div>
    </div>
</body>
</html>