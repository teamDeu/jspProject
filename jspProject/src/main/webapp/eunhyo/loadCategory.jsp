<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
    #category-form {
        display: flex;
        width: 100%;
    }
    
    /* 현재 카테고리 스타일 */
    .category-current {
        width: 20%;
        height: 400px;
        border: 1px solid #ccc;
        padding: 10px;
        background-color: #f9f9f9;
        margin-right: 50px; 
        margin-left: 30px;
    }

    /* 현재 카테고리 박스 */
    .category-list {
        height: 350px;
        width: 95%;
        border: 1px solid #ccc;
        margin-top: 15px;
        margin-left: 5px;
    }

    /* 카테고리 추가 및 수정 스타일 */
    .category-section {
        width: 65%;
        display: flex;
        flex-direction: column;
        gap: 30px;
    }

    /* 카테고리 추가/수정 박스 */
    .category-box {
        border: 1px solid #ccc;
        height: 175px;
        border-radius: 10px;
        padding: 10px;
        background-color: #f9f9f9;
        position: relative; /* 버튼 위치 조정을 위해 설정 */
    }

    /* 추가/수정 버튼 스타일 */
    .category-button {
        background-color: #e3e3e3;
        border: 1px solid #e3e3e3;
        border-radius: 10px;
        padding: 5px 10px;
        cursor: pointer;
        position: absolute;
        bottom: 30px;
        right: 30px;
        width: 50px;
        font-size: 15px;
    }

    .category-label {
        margin-left: 5px;
        margin-bottom: 5px;
        color: #80A46F;
    }
    
    /* 추가/수정 박스 내용 */
    .category-box-content {
        width: 97%;
        height: 130px;
        margin-left: 8px;
        border-radius: 10px;
        border: 1px solid #ccc;
        background-color: #fff;
        display: flex;
        flex-direction: column; /* 세로 배치 */
    }

    /* 각 텍스트 스타일 */
    .content-item {
	    font-size: 22px;
	    color: #333;
	    margin-top: 10px;
	    margin-left: 10px;
	    display: flex; /* 수평 정렬을 위해 flex 사용 */
    	align-items: center; /* 텍스트와 입력 요소를 세로 가운데 정렬 */
    }
    
    .category-edit .content-item {
	    margin-top: 20px; /* 원하는 마진 값으로 조정 */
	}
    .content-input {
	    margin-left: 20px;
	    padding: 5px;
	    font-size: 14px;
	    border-radius: 5px;
	    border: 1px solid #ccc;
	    width:300px;
	}
    .checkbox-group {
	    margin-left: 31px;
	    display: flex;
	    gap: 10px;
	    font-size: 20px;
	    
	}
	.checkbox-group input[type="checkbox"] {
	    transform: scale(1.2);
	    margin-right: 2px; 
	}
    
</style>
</head>
<body>
<form id="category-form">
    <!-- 현재 카테고리 -->
    <div class="category-current">
        <div class="category-label">현재 카테고리</div>
        <div class="category-list"></div>
    </div>

    <!-- 카테고리 추가 및 수정 섹션 -->
    <div class="category-section">
        <!-- 카테고리 추가 -->
        <div class="category-add category-box">
            <div class="category-label">카테고리 추가</div>
            <div class="category-box-content">
                <div class="content-item">카테고리</div>
                <div class="content-item">카테고리명
                	<input type="text" class="content-input">
                </div>
                <div class="content-item">공개설정
                	<div class="checkbox-group">
				        <label><input type="checkbox"> 전체</label>
				        <label><input type="checkbox"> 일촌</label>
				    </div>
                </div>
            </div>
            <button type="button" class="category-button">추가</button>
        </div>

        <!-- 카테고리 수정 -->
        <div class="category-edit category-box">
            <div class="category-label">카테고리 수정</div>
            <div class="category-box-content">
                <div class="content-item">카테고리명
                	<input type="text" class="content-input">
                </div>
                <div class="content-item">공개설정
                	<div class="checkbox-group">
				        <label><input type="checkbox"> 전체</label>
				        <label><input type="checkbox"> 일촌</label>
				    </div>
                </div>

            </div>
            <button type="button" class="category-button">저장</button>
        </div>
    </div>
</form>
</body>
</html>
