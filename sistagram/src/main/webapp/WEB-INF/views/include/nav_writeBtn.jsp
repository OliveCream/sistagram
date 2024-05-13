<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<script src="/resources/js/jquery-3.5.1.min.js"></script>

<style>
.modal_overlay {
    display: none;
    width: 100%;
    height: 100%;
    position: fixed;
    left: 0;
    top: 0;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    background: rgba(0, 0, 0, 0.8);
    backdrop-filter: blur(1.5px);
    -webkit-backdrop-filter: blur(1.5px);
}

.modal_window {
    background: white;
    backdrop-filter: blur(13.5px);
    -webkit-backdrop-filter: blur(13.5px);
    border-radius: 10px;
    border: 1px solid rgba(255, 255, 255, 0.18);
    width: 400px; /* 모달 너비 조절 */
    height: 300px; /* 모달 높이 조절 */
    position: relative;
    padding: 10px;
    margin: auto;
}
</style>

<div>
    <button class="nav_button" id="add_feed">
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

<div class="modal_overlay" id="modal">
    <div class="modal_window">
        <!-- 모달 내용 -->
        <button onclick="closeModal()">닫기</button>
    </div>
</div>

<script>
$(document).ready(function() {
    // 버튼 클릭 시 모달 열기
    $("#add_feed").click(function() {
        openModal();
    });

    // 모달 열기 함수
    function openModal() {
        $("#modal").css({
            display: "flex"
        });
        $("body").css({
            overflow: "hidden"
        });
    }

    // 모달 닫기 함수
    function closeModal() {
        $("#modal").css({
            display: "none"
        });
        $("body").css({
            overflow: "auto"
        });
    }
});
</script>
