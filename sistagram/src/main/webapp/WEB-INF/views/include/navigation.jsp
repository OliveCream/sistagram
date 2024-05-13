<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<style>
    /* 기본 버튼 스타일 */
.nav_button {
  width: 100%; /* 버튼의 너비 (예: 150px) */
  height: 50px; /* 버튼의 높이 (예: 40px) */
  background-color: #ffffff; /* 초기 배경색 (흰색) */
  color: #000000; /* 초기 텍스트 색상 (검은색) */
  padding: 10px 20px; /* 내부 여백 */
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  cursor: pointer;
  border: none; /* 테두리 없음 */
  border-radius: 5px; /* 둥근 모서리 */
  transition: background-color 0.3s ease; /* 변화가 부드럽게 일어나도록 설정 */
  display: flex; /* 플렉스 컨테이너로 설정 */
  flex-direction: column; /* 수직으로 쌓도록 설정 */
  justify-content: center; /* 수직 가운데 정렬 */
  position: relative; /* 포지션 추가 */
  margin-top:10px;
  margin-bottom:10px;
}

/* 마우스 호버 시의 버튼 스타일 */
.nav_button:hover {
  background-color: #dddddd; /* 호버 시 배경색 (옅은 회색) */
  color: #000000; /* 호버 시 텍스트 색상 (검은색) */
}

/* 모달css */
.modal_overlay {
    width: 100%;
    height: 100%;
    position: absolute;
    left: 0;
    top: 0;
    display: none;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    background: rgba(0, 0, 0, 0.8);
    backdrop-filter: blur(5px);
    -webkit-backdrop-filter: blur(1.5px);
}
.modal_window {
    background: white;
    backdrop-filter: blur(13.5px);
    -webkit-backdrop-filter: blur(13.5px);
    border-radius: 10px;
    border: 1px solid rgba(255, 255, 255, 0.18);
    width: 700px;
    height: 1000px;
    position: relative;
    padding: 10px;
    z-index: 99999; /* 다른 요소 위에 나타나도록 설정 */
	max-height: 80vh; /* 브라우저 뷰포트 높이의 80%까지만 허용 */
    overflow-y: auto; /* 내용이 넘칠 경우 스크롤 표시 */
}
.modal-title {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    font-weight: bold;
    font-size: 17px;
    /* border-bottom: solid 1px rgb(202, 202, 202); */
}
.modal-title-side {
    width: 40px;
    text-align: center;
    
}

#modal-close{
	cursor: pointer;
}
.black-line {
    border-top: 1px solid gray; /* 검정색 가로 실선 스타일 */
}

         .button-submit { 
             background-color: #2c84dc; 
             color: #fff; 
             padding: 10px 15px; 
             border: none;
             border-radius: 4px;
             cursor: pointer;
 /*             font-weight: bold; */
             font: inherit;
             position: absolute;
             margin-top: 30px;
             margin-right: 7%;
             right: 30px;  
             width: 250px; 
         } 
        
        .boardUpload-image {
            width: 80%;
            height: 80%;
            object-fit: cover;
            margin-bottom: 0px;
            display: block;
            margin: 20px auto;
            cursor: pointer;
        }    
        .content-style{
        	width: 80%;
        	height: 120px; 
        	resize: none;
        	border: 1px solid gray; 
        	box-sizing: border-box;
			overflow-y: auto; 
         	font-size: 13px;
         	font: inherit;
         	display: inline-block;"
         	margin-left: 100px;
     		display: block; /* 블록 레벨로 설정 */
        }
</style>

<nav> 

<div style="width: 15%; height: 100vh; padding: 8px 12px 20px; display: flex; flex-direction: column; position: fixed; border-right: 1px solid #dbdbdb;">
    <div style="width: 100%; height: 90px; margin-top:20px;">
        <div class="logo" style="padding: 25px 10px 0px; margin-bottom: 20px; margin-left:25px">
            <a href="/main/home" style="display: inline-block;"><img src="/resources/images/Sistagram.png" alt="Instagram" class="brand_logo" style="max-width: 70%;"></a>
        </div>
    </div>
    <div style="width: 100%; flex-grow: 1;">
        
        
        <div> 
        <button class="nav_button" onclick="window.location.href='/main/home'">
            <span>
                    <div style="width: 100%; padding: 10px; display: inline-flex; align-items: center; vertical-align: middle; ">
                        <div style="vertical-align: middle; margin-bottom: -5px;">
                            <img src="/resources/images/home.png" alt="home">
                        </div>
                        <div style="width: 100%; height: 24px; display: flex; align-items: center; padding-left: 10px;">
                            홈
                        </div>
                    </div>
            </span>
        </button>
        </div>
        
        
        <div>
         <button class="nav_button" onclick="window.location.href='/main/searchUser'">
            <span>
                <a>
                    <div style="width: 100%; padding: 10px; margin-bottom: 5px; display: inline-flex; align-items: center;">
                        <div style="vertical-align: middle; margin-bottom: -5px;">
                            <img src="/resources/images/search.png" alt="search">
                        </div>
                        <div style="width: 100%; height: 24px; display: flex; align-items: center; padding-left: 10px;">
                            <span>검색</span>
                        </div>
                    </div>
                </a>
            </span>
            </button>
        </div>
        

        
        
        <div>
         <button class="nav_button" onclick="window.location.href='/main/home'">
            <span>
                <a>
                    <div style="width: 100%; padding: 10px; margin-bottom: 5px; display: inline-flex; align-items: center;">
                        <div style="vertical-align: middle; margin-bottom: -5px;">
                            <img src="/resources/images/msg.png" alt="msg">
                        </div>
                        <div style="width: 100%; height: 24px; display: flex; align-items: center; padding-left: 10px;">
                            <span>메세지</span>
                        </div>
                    </div>
                </a>
            </span>
            </button>
        </div>
        
        
        <div>
         <button class="nav_button" id="alarmBtn" onclick="window.location.href='/main/home'">
            <span>
                <a>
                    <div style="width: 100%; padding: 10px; margin-bottom: 5px; display: inline-flex; align-items: center;">
                        <div style="vertical-align: middle; margin-bottom: -5px;">
                            <img src="/resources/images/heart.png" alt="heart">
                        </div>
                        <div style="width: 100%; height: 24px; display: flex; align-items: center; padding-left: 10px;">
                            <span>알림</span>
                        </div>
                    </div>
                </a>
            </span>
            </button>
        </div>


		<div>
<!-- 		    <button class="nav_button" id="writeBtn" onclick="window.location.href='/main/write'"> -->
		    <button class="nav_button" id="writeBtn">			<!-- onclick="showModal()" -->
		        <span>
		            <a>
		                <div style="width: 100%; padding: 10px; margin-bottom: 5px; display: inline-flex; align-items: center;">
		                    <div style="vertical-align: middle; margin-bottom: -5px;">
		                        <img src="/resources/images/add.png" alt="add">
		                    </div>
		                    <div style="width: 100%; height: 24px; display: flex; align-items: center; padding-left: 10px;">
		                        <span>만들기</span>
		                    </div>
		                </div>
		            </a>
		        </span>
		    </button>
		</div>

        <div>
         <button class="nav_button" id="profileBtn" onclick="window.location.href='/main/profile'">
            <span>
                <a>
                    <div style="width: 100%; padding: 10px; margin-bottom: 5px; display: inline-flex; align-items: center;">
                        <div style="vertical-align: middle; margin-bottom: -5px;">
                            <img src="/resources/images/account.png" alt="account">
                        </div>
                        <div style="width: 100%; height: 24px; display: flex; align-items: center; padding-left: 10px;">
                            <span>프로필</span>
                        </div>
                    </div>
                </a>
            </span>
            </button>
        </div>
              
    </div>

    <div>
    
		        <div id="menuContent" style="display: none; border-radius: 10px; background-color: white; padding: 10px; padding-right: 10px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);" >
		            <!-- Content of the menu goes here -->
		            <button class="nav_button" id="resetUserInfoBtn" onclick="window.location.href='/user/update'">프로필 수정</button>
		            <button class="nav_button" id="probReportBtn" name="probReportBtn">문제 신고</button>
		            <button class="nav_button" id="logOutBtn" onclick="fn_logout()">로그아웃</button>
		        </div><br />
		        
		        
     <button class="nav_button" id="ectBtn">
        <span>
            <a>

                <div style="width: 100%; padding: 10px; margin-bottom: 5px; display: inline-flex; align-items: center;">
                    
                    <div style="vertical-align: middle; margin-bottom: -5px;">
                        <img src="/resources/images/menu.png" alt="home">
                    </div>
                    <div style="width: 100%; height: 24px; display: flex; align-items: center; padding-left: 10px;">
                        <span>더 보기</span>
                    </div>
                </div>
            </a>
        </span>
        </button>
    </div>
</div>
</nav>



<div id ="first-modal" class="modal_overlay">
	<div class="modal_window">
		<div class="modal-title">
			<div class="modal-title-side"></div>
			<div style="margin:5px;">새 게시물 만들기</div>
			<div class="modal-title-side">
				<span id ="modal-close" class="material-icons-outlined">  <!-- onClick="closeModal()"  -->
				X
				</span>
			</div>
		</div>
		<hr class="black-line"><br /><br />

<form id="boardForm" name="boardForm" method="post" enctype="multipart/form-data">
		<div class="additional-section">
			<div style="text-align: center;">
				${user.userId}
				<img id="previewImg" class="boardUpload-image" onclick="$('#boardImg').click();" src="" onerror="this.src='/resources/images/fileUploadd.jpg';" alt="Image" >
				<input type="file" id="boardImg" name="boardImg" onchange="previewImage(this);" accept="image/*" value="" style="display:none">
			</div>
			
			<textarea id="boardContent" name="boardContent" class="content-style" placeholder="내용을 입력해주세요." style="font-size: 13px; margin: auto;" ></textarea>
			<button class="button-submit" id="submitBoard" >공유하기</button>		<!-- onclick="submitBoard()" -->
		</div>
</form>
	</div>
</div>




<!------------------------------------------------------------ 스크립트 ---------------------------------------------------------------->


<script src="/resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		
		//console.log(${cookieUserId});
		
		//글쓰기 버튼 클릭시 모달창 열기
		$("#writeBtn").on("click", function(){
	    	var scrollTop = $(window).scrollTop();
	    	
			$('#first-modal').css({
				display : 'flex',
				top: scrollTop + 'px'
			});
			
			$(document.body).css({
				overflow : 'hidden'
			});
		});
		
		//X 클릭시 게시물 쓰기 취소
		$("#modal-close").on("click", function(){
			if(!confirm("\n                      작성중인 게시물을 삭제하시겠습니까?\n")){
	    		return;
	    	}
			
			$('#first-modal').css({
				display : 'none'
			});	
			$(document.body).css({
				overflow : 'auto'
			});
			//닫을 때 내용 삭제
			document.getElementById('previewImg').src = "";
			document.getElementById('boardContent').value = "";
		});
		
		//게시물 공유 버튼 클릭시
		$("#submitBoard").on("click", function(event){
			
		    // 폼 제출을 막음
		    event.preventDefault();
		    
	    	var img = document.getElementById('boardImg');
			
	    	if(img.files.length <= 0){
				alert("사진 첨부는 필수입니다.");
				return;
			}
	    	
			if(document.getElementById('boardContent').value.length <= 0){
				if(!confirm("게시글 내용 없이 공유하시겠습니까?")){
					return;
				}
			}
			
			fn_boardUpdate();
		});
		
	});

	//더보기 클릭시 menuContent창 띄움
    document.getElementById('ectBtn').addEventListener('click', function () {
        var menuContent = document.getElementById('menuContent');
        menuContent.style.display = (menuContent.style.display === 'block') ? 'none' : 'block';
    });
    
    //menuContent 열려있을 경우 아무곳 클릭시 닫힘
    document.addEventListener('click', function (event) {
        var menuContent = document.getElementById('menuContent');
        var ectBtn = document.getElementById('ectBtn');

        // 더 보기 버튼이나 메뉴 내부를 클릭한 경우는 무시
    	if (!ectBtn.contains(event.target) && !menuContent.contains(event.target)) {
            menuContent.style.display = 'none';
        }
    });
	
    //로그아웃 클릭시
    function fn_logout(){
    	if(confirm("로그아웃 하시겠습니까?😊")){
    		window.location.href = "/user/logout";
    	}
    	
    }
    
    //게시물 이미지 파일 선택시 
    function previewImage(input){
   		var reader = new FileReader();
   		
   		reader.onload = function(e){
   			document.getElementById('previewImg').src = e.target.result;
   			console.log = e.target.result;
   		};
   		
   		reader.readAsDataURL(input.files[0]);
    }
    
    
    //게시물 update ajax 함수
    function fn_boardUpdate(){
    	
    	var formData = new FormData($("#boardForm")[0]);
    
    	
    	$.ajax({
    		type:"POST",
    		enctype:"multipart/form-data",
    		url:"/main/writeProc",
    		data:formData,
    		processData:false,
    		contentType:false,
    		cache:false,
    		beforeSend:function(xhr){
    			xhr.setRequestHeader("AJAX", "true");
    		},
    		success:function(res){
    			if(res.code == 200){
    				alert("게시글이 등록되었습니다.");
    				location.href = "/main/home";
    			}else if(res.code == 400){
    				alert("파라미터값이 올바르지 않습니다.");
    				return;
    			}
    			else{
    				alert("게시물 등록 중 오류가 발생하였습니다.");
    				return;
    			}
    		},
    		error:function(xhr, status, error){
    			alert("게시물 등록 중 예상치 못한 오류가 발생하였습니다.");
    			icia.common.error(error);
    		}
    		
    	});
    }
    
    
//     //모달창 열기(만들기 클릭시)
//     function showModal() {
    	
//     	var scrollTop = $(window).scrollTop();
    	
// 		$('#first-modal').css({
// 			display : 'flex',
// 			top: scrollTop + 'px'
// 		});
		
// 		$(document.body).css({
// 			overflow : 'hidden'
// 		});
//     }
	
//     //게시글 쓰기 취소
// 	function closeModal() {
		
// 		if(!confirm("\n                      작성중인 게시물을 삭제하시겠습니까?\n")){
//     		return;
//     	}
		
// 		$('#first-modal').css({
// 			display : 'none'
// 		});	
// 		$(document.body).css({
// 			overflow : 'auto'
// 		});
// 		//닫을 때 내용 삭제
// 		document.getElementById('previewImg').src = "";
// 		document.getElementById('boardContent').value = "";
// 	}
    
    
    
//     //게시물 공유 클릭시
//    	function submitBoard(){
//     	var img = document.getElementById('boardImg');
		
//     	if(img.files.length <= 0){
// 			alert("사진 첨부는 필수입니다.");
// 			return;
// 		}
    	
// 		if(document.getElementById('boardContent').value.length <= 0){
// 			if(!confirm("게시글 내용 없이 공유하시겠습니까?")){
// 				return;
// 			}
// 		}
//     }
	
	



</script>





