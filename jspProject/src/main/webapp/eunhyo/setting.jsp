<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPage Settings</title>
<style>
    .custom-box {
        position: relative;
        margin: 100px auto;
        width: 80%; 
        height: 450px; 
        background-color: #f7f7f7; 
        border: 1px solid #BAB9AA; 
        padding: 20px;
        font-size: 24px;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        overflow-y: auto;
    }
    .s-button-container {
        position: relative;
        top: 105px;
        left: 101px;
        text-align: left;
    }
    .mypage-btn, .category-btn {
        margin-right: -10px;
        padding: 10px 20px;
        font-size: 22px;
        background-color: #f7f7f7;
        border: 1px solid #BAB9AA;
        cursor: pointer;
        width: 100px;
    }
    .active-btn {
        background-color: #e3e3e3;
    } 
    
</style>
<script>
document.addEventListener("DOMContentLoaded", function() {
    // 기본적으로 마이페이지 내용 로드
    loadContent("../eunhyo/loadMypage.jsp");
    
    var mypageBtn = document.querySelector(".mypage-btn");
    var categoryBtn = document.querySelector(".category-btn");

    // 버튼 클릭 이벤트 설정
    mypageBtn.addEventListener("click", function() {
        setActiveButton(mypageBtn, categoryBtn);
        loadContent("../eunhyo/loadMypage.jsp");
    });

    categoryBtn.addEventListener("click", function() {
        setActiveButton(categoryBtn, mypageBtn);
        loadContent("../eunhyo/loadCategory.jsp");
    });
    //loadCategoryList(); //카테고리 리스트 로드
});

// 활성화 버튼 설정 함수
function setActiveButton(activeBtn, inactiveBtn) {
    activeBtn.classList.add("active-btn");
    inactiveBtn.classList.remove("active-btn");
}


// custom-box에 페이지 내용을 로드하는 함수
function loadContent(url) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            document.getElementById("custom-box").innerHTML = xhr.responseText;

            // loadCategory.jsp를 로드했을 때만 카테고리 리스트 로드
            if (url.includes("loadCategory.jsp")) {
                loadCategoryList();
            }
        }
    };
    xhr.open("GET", url, true);
    xhr.send();
}

function enableEditing() {
    // userIdDisplay를 제외한 모든 input 필드를 활성화
    var inputs = document.querySelectorAll("#mypage-form input:not([name='userIdDisplay'])");
    inputs.forEach(function(input) {
        input.removeAttribute("readonly");
    });

    document.getElementById("edit-btn").style.display = "none";
    document.getElementById("save-btn").style.display = "inline-block";
}


function updateMypage(event) {
    event.preventDefault(); // 폼 제출 기본 동작 중단

    var form = document.getElementById("mypage-form");
    var formData = new FormData(form);

    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            if (xhr.responseText.trim() === "success") {
                alert("정보가 성공적으로 업데이트되었습니다.");
                disableEditing(); // 저장 후 필드 비활성화
            } else {
                alert("업데이트에 실패했습니다.");
            }
        }
    };
    xhr.open("POST", "../eunhyo/updateMypage.jsp", true);
    xhr.send(new URLSearchParams(formData));
}

function disableEditing() {
    // 모든 input 필드를 다시 비활성화
    var inputs = document.querySelectorAll("#mypage-form input");
    inputs.forEach(function(input) {
        input.setAttribute("readonly", "readonly");
    });

    document.getElementById("edit-btn").style.display = "inline-block";
    document.getElementById("save-btn").style.display = "none";
}

function addCategory() {
    // 폼 데이터 가져오기
    var formData = new FormData(document.getElementById('category-form'));

    // Debugging: formData 내용 확인
    console.log("FormData - categoryType:", formData.get("categoryType"));
    console.log("FormData - categoryName:", formData.get("categoryName"));

    var categoryType = formData.get("categoryType");
    var categoryName = formData.get("categoryName");
    var categorySecret = formData.get("categorySecret");

    // 카테고리 선택이 되었는지 확인
    if (!categoryType) {
        alert("카테고리를 선택해주세요.");
        return; // 함수 종료
    }

    // 카테고리 명이 입력되었는지 확인
    if (!categoryName || categoryName.trim() === "") {
        alert("카테고리명을 입력해주세요.");
        return; // 함수 종료
    }

    var checkboxes = document.querySelectorAll('.checkbox-group input[type="checkbox"]');
    var isChecked = Array.from(checkboxes).some(checkbox => checkbox.checked);

    // 공개 설정이 선택되지 않았다면 경고창을 띄움
    if (!isChecked) {
        alert("공개설정을 선택해주세요.");
        return; // 함수 종료
    }

    // AJAX 요청 생성
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            // 서버 응답에 따라 알림창 띄우기
            if (xhr.responseText.trim() === "success") {
                alert("카테고리가 성공적으로 추가되었습니다.");

                // 카테고리 항목 생성
                var categoryItem = document.createElement('div');
                categoryItem.classList.add('category-item');
                
                var categoryListDiv = document.querySelector(".category-list");
                var categoryIndex = categoryListDiv.children.length + 1; // Index 값을 리스트 길이로 계산
                categoryItem.setAttribute('data-category-index', categoryIndex); // Index 값 저장
                categoryItem.setAttribute('data-category-name', categoryName); // Name 값 저장
                categoryItem.setAttribute('data-category-type', categoryType); // Type 값 저장

                // 카테고리 번호
                var number = document.createElement('span');
                number.classList.add('category-item-number');
                number.innerText = categoryIndex + " . ";

                // 카테고리 내용
                var content = document.createElement('span');
                content.innerText = categoryType + ": " + categoryName;

                // 삭제 버튼 생성
                var deleteButton = document.createElement('img');
                deleteButton.src = "../eunhyo/img/bin.png"; // 이미지 경로 설정
                deleteButton.alt = "삭제";
                deleteButton.classList.add('delete-button');
                deleteButton.style.cursor = "pointer";
                deleteButton.style.width = "12px"; // 원하는 크기로 조정
                deleteButton.style.height = "15px"; // 원하는 크기로 조정
                deleteButton.style.position = "absolute"; // 절대 위치로 설정
                deleteButton.style.right = "0px"; 
                deleteButton.style.top = "50%"; // 수직 가운데 정렬을 위해 설정
                deleteButton.style.transform = "translateY(-50%)"; // 수직 가운데 정렬을 위한 변환

                // deleteButton.onclick 함수에서 categoryType, categoryName 직접 참조
                deleteButton.onclick = (function(type, name, item) {
                    return function() {
                        deleteCategory(type, name, item);
                    };
                })(categoryType, categoryName, categoryItem);
        
                // 항목에 번호, 내용, 삭제 버튼 추가
                categoryItem.appendChild(number);
                categoryItem.appendChild(content);
                categoryItem.appendChild(deleteButton);

                // 리스트의 맨 아래에 항목 추가
                categoryListDiv.appendChild(categoryItem);

                // 리스트 스크롤을 맨 아래로 이동
                categoryListDiv.scrollTop = categoryListDiv.scrollHeight;
                
              
                

                    // 현재 선택된 카테고리에 'selected' 클래스 추가
                    categoryItem.classList.add('selected');

                    // 카테고리 수정 영역에 'category_name (category_index)' 형태로 표시
                    var selectedName = categoryItem.getAttribute('data-category-name');
                    var selectedIndex = categoryItem.getAttribute('data-category-index');
                    var selectedType = categoryItem.getAttribute('data-category-type'); // 카테고리 타입 추가
                    document.querySelector('.category-edit .content-input').value = selectedName + " (" + selectedIndex + ")";

                    // 카테고리 타입도 표시하고 싶다면 여기에 추가적으로 반영
                    document.querySelector('select[name="categoryType"]').value = selectedType;
                });

                // 입력 필드 및 체크박스 초기화
                document.querySelector('select[name="categoryType"]').selectedIndex = 0;
                document.querySelector('input[name="categoryName"]').value = '';
                mainCategoryLoad();
                checkboxes.forEach(function(checkbox) {
                    checkbox.checked = false;
                });
            } else {
                alert("카테고리가 이미 존재합니다.");
            }
        }
    };

    // POST 요청으로 categoryAdd.jsp에 데이터 전송
    xhr.open("POST", "../eunhyo/categoryAdd.jsp", true);
    xhr.send(new URLSearchParams(formData));
}





//카테고리 리스트를 로드하는 함수
function loadCategoryList() {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var categoryListDiv = document.querySelector(".category-list");
            categoryListDiv.innerHTML = ''; // 기존 리스트 비우기

            var categories = JSON.parse(xhr.responseText);

            categories.forEach(function(category) {
                // 카테고리 항목 생성
                var categoryItem = document.createElement('div');
                categoryItem.classList.add('category-item');

                // 카테고리 타입 속성 추가
                categoryItem.setAttribute('data-category-type', category.type);
                categoryItem.setAttribute('data-category-index', category.index); // category_index 속성 추가

                // 카테고리 번호 (index 번호로 설정)
                var number = document.createElement('span');
                number.classList.add('category-item-number');
                number.innerText = category.index + " . "; // index 번호 표시

                // 카테고리 내용
                var content = document.createElement('span');
                content.innerText = category.type + " : " + category.name;

                // deleteButton 생성 및 스타일 설정
                var deleteButton = document.createElement('img');
                deleteButton.src = "../eunhyo/img/bin.png"; // 이미지 경로 설정
                deleteButton.alt = "삭제";
                deleteButton.classList.add('delete-button');
                deleteButton.style.cursor = "pointer";
                deleteButton.style.width = "12px"; // 원하는 크기로 조정
                deleteButton.style.height = "15px"; // 원하는 크기로 조정

                // 버튼을 오른쪽에 배치하기 위해 스타일 설정
                deleteButton.style.position = "absolute"; // 절대 위치로 설정
                deleteButton.style.right = "0px"; 
                deleteButton.style.top = "50%"; // 수직 가운데 정렬을 위해 설정
                deleteButton.style.transform = "translateY(-50%)"; // 수직 가운데 정렬을 위한 변환

                // deleteButton.onclick 함수에서 category.type, category.name 직접 참조
                deleteButton.onclick = (function(type, name, item) {
                    return function() {
                        deleteCategory(type, name, item);
                    };
                })(category.type, category.name, categoryItem);

                // 항목 클릭 시 수정 섹션에 값 반영하는 이벤트 리스너 추가
                categoryItem.addEventListener('click', function() {
                    // 이전 선택 해제
                    document.querySelectorAll('.category-item').forEach(function(item) {
                        item.classList.remove('selected');
                    });

                    // 현재 선택된 카테고리에 'selected' 클래스 추가
                    categoryItem.classList.add('selected');

                    // 카테고리명 필드에 '카테고리명 (번호)' 형태로 표시
                    document.querySelector('.category-edit .content-input').value = category.name + " (" + category.index + ")";

                    // 공개 설정 체크박스 값을 반영
                    if (category.secret === 0) {
                        document.querySelector('.category-edit input[name="categorySecret"][value="0"]').checked = true;
                        document.querySelector('.category-edit input[name="categorySecret"][value="1"]').checked = false;
                    } else if (category.secret === 1) {
                        document.querySelector('.category-edit input[name="categorySecret"][value="0"]').checked = false;
                        document.querySelector('.category-edit input[name="categorySecret"][value="1"]').checked = true;
                    }
                });

                // 항목에 번호, 내용, 삭제 버튼 추가
                categoryItem.appendChild(number);
                categoryItem.appendChild(content);
                categoryItem.appendChild(deleteButton);

                // 리스트에 항목 추가
                categoryListDiv.appendChild(categoryItem);
            });
        }
    };
    xhr.open("GET", "../eunhyo/categoryList.jsp", true);
    xhr.send();
}


function deleteCategory(categoryType, categoryName, categoryItem) {
    if (categoryType === '홈') {
        alert("홈 카테고리는 삭제할 수 없습니다.");
        return; // '홈'은 삭제 불가
    }
    if (confirm("삭제하시겠습니까?")) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                if (xhr.responseText.trim() === "success") {
                    alert("카테고리가 삭제되었습니다.");
                    categoryItem.remove();
                    updateCategoryNumbers();
                    mainCategoryLoad();
                } else {
                    alert("카테고리 삭제에 실패했습니다. 다시 시도해주세요.");
                }
            }
        };
        xhr.open("POST", "../eunhyo/deleteCategory.jsp", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
        xhr.send("categoryType=" + encodeURIComponent(categoryType) + "&categoryName=" + encodeURIComponent(categoryName));
    }
}


//카테고리 번호 재할당 함수
function updateCategoryNumbers() {
    var categoryListDiv = document.querySelector(".category-list");
    var categoryItems = categoryListDiv.querySelectorAll('.category-item');

    // 각 카테고리 항목의 번호 업데이트
    categoryItems.forEach(function(item, index) {
        var number = item.querySelector('.category-item-number');
        number.innerText = (index + 1) + " . ";
    });
}

function updateCategory() {
    // 선택된 카테고리 요소 가져오기
    var selectedCategory = document.querySelector('.category-item.selected');
    if (!selectedCategory) {
        console.error("선택된 카테고리를 찾을 수 없습니다.");
        return; // 선택된 카테고리가 없으면 중단
    }

    // `edit-category-name` 필드에서 값을 가져옴
    var categoryFullText = document.getElementById("edit-category-name").value.trim();
    
    // category_name과 category_index 분리
    var categoryName = categoryFullText.substring(0, categoryFullText.lastIndexOf("(")).trim(); // 괄호 전 부분이 카테고리명
    var categoryIndex = categoryFullText.substring(categoryFullText.lastIndexOf("(") + 1, categoryFullText.lastIndexOf(")")).trim(); // 괄호 안이 카테고리 번호

    // categoryType 가져오기 (필요한 경우 수정)
    var categoryType = selectedCategory.getAttribute("data-category-type"); // 선택된 항목의 categoryType

    // 공개 설정 값을 가져옴
    var categorySecret = document.querySelector('.category-edit input[name="categorySecret"]:checked')?.value;

    // 유효성 검사: 모든 필드가 제대로 입력되어 있는지 확인
    if (!categoryName) {
        alert("카테고리명을 입력해주세요.");
        return;
    }

    if (!categoryIndex) {
        alert("카테고리 번호를 입력해주세요.");
        return;
    }

    if (!categoryType) {
        alert("카테고리 타입을 찾을 수 없습니다.");
        return;
    }

    if (!categorySecret) {
        alert("공개설정을 선택해주세요.");
        return;
    }

    // AJAX 요청 생성
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            if (xhr.responseText.trim() === "success") {
                alert("카테고리가 성공적으로 업데이트되었습니다.");
                loadCategoryList(); // 업데이트 후 리스트 새로고침
                document.getElementById('edit-category-name').value = '';
                document.querySelectorAll('.category-edit input[type="checkbox"]').forEach(function(checkbox) {
                    checkbox.checked = false;
                });
                mainCategoryLoad();
            } else {
                alert("카테고리 업데이트에 실패했습니다.");
            }
        }
    };

    // POST 요청으로 데이터 전송
    xhr.open("POST", "../eunhyo/updateCategory.jsp", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); // 데이터 형식 설정
    xhr.send("categoryName=" + encodeURIComponent(categoryName) +
             "&categoryIndex=" + encodeURIComponent(categoryIndex) +
             "&categoryType=" + encodeURIComponent(categoryType) +  // categoryType 전송
             "&categorySecret=" + encodeURIComponent(categorySecret));
}





function toggleCheckbox(currentCheckbox) {
    // 모든 체크박스를 가져옴
    var checkboxes = document.querySelectorAll('.checkbox-group input[type="checkbox"]');
    
    checkboxes.forEach(function(checkbox) {
        // 현재 체크한 체크박스가 아니면 해제
        if (checkbox !== currentCheckbox) {
            checkbox.checked = false;
        }
    });
}



</script>
</head>
<body>
<div class="s-button-container">
    <button class="mypage-btn active-btn">마이페이지</button>
    <button class="category-btn">카테고리</button>
</div>
<div id="custom-box" class="custom-box">
    <!-- 로드된 내용이 이곳에 표시됨 -->
</div>
</body>
</html>
