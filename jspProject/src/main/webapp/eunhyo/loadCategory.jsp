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
	    margin-top:10px;
	    padding: 5px;
	    font-size: 17px;
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
	
    /* 드롭다운 스타일 수정 */
    select.content-input {
        font-size: 17px;
	    border-radius: 5px;
	    border: 1px solid #ccc;
	    background-color: #fff;
	    width: 315px;
	    position: absolute;
	    left: 52px;
	    height: 32px;
	    text-align: left;
	    line-height:32px;
    }

    .content-item {
        position: relative;

    }
    
    /*카테고리 리스트*/
    .category-item {
	    position: relative; /* 삭제 버튼의 위치 설정을 위한 상대 위치 */
	    padding: 7px;
	    border-bottom: 1px dashed #ccc;
	    font-size: 19px;
	    justify-content: space-between; 
	    margin-bottom: 5px; 
	    margin-top: 5px;
	    margin-left: 10px;
	    width: 80%;
    }
	.category-item:hover {
	    background-color: #f0f0f0; /* 마우스를 올렸을 때 배경색 변경 */
	    cursor: pointer; /* 마우스를 올렸을 때 커서 모양 변경 */
	}
    .category-item-number {
        margin-right: 0px; /* 번호와 내용 사이 간격 */
    }
    
    
</style>
</head>
<body>
<form id="category-form" action="../eunhyo/categoryAdd.jsp" method="POST" onsubmit="event.preventDefault();">

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
		        <div class="content-item">카테고리
		            <!-- 카테고리 선택 드롭다운 -->
		            <select name="categoryType" class="content-input">
					    <option value="" disabled selected>카테고리를 선택해주세요.</option> <!-- 안내 문구 추가 -->
					    <option value="홈" disabled>홈</option>
					    <option value="프로필">프로필</option>
					    <option value="미니룸">미니룸</option>
					    <option value="게시판">게시판</option>
					    <option value="방명록">방명록</option>
					    <option value="상점">상점</option>
					    <option value="게임">게임</option>
					    <option value="음악">음악</option>
					</select>


		        </div>
		        <div class="content-item">카테고리명
		            <input type="text" name="categoryName" class="content-input">
		        </div>
		        <div class="content-item">공개설정
		            <!-- 공개설정 체크박스 -->
					<div class="checkbox-group">
					    <label><input type="checkbox" name="categorySecret" value="0" onclick="toggleCheckbox(this)"> 전체</label>
					    <label><input type="checkbox" name="categorySecret" value="1" onclick="toggleCheckbox(this)"> 일촌</label>
					</div>
		        </div>
		    </div>
		    <button type="button" class="category-button" onclick="addCategory()">추가</button>

		</div>

        <!-- 카테고리 수정 -->
        <div class="category-edit category-box">
            <div class="category-label">카테고리 수정</div>
			<div class="category-box-content">
			    <div class="content-item">카테고리명
			        <input type="text" id="edit-category-name" class="content-input">
			    </div>
			    <div class="content-item">공개설정
			        <div class="checkbox-group">
			            <label><input type="checkbox" id="public-check" name="categorySecret" value="0" onclick="toggleCheckbox(this)"> 전체</label>
			            <label><input type="checkbox" id="private-check" name="categorySecret" value="1" onclick="toggleCheckbox(this)"> 일촌</label>
			        </div>
			    </div>
			</div>

            <button type="button" class="category-button" onclick="updateCategory()">저장</button>

        </div>
    </div>
</form>

</body>
</html>
