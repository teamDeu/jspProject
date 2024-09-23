<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CloverStory</title>
<!-- Linking the CSS file -->
<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/guestbook.css">
</head>

<body>
    <div class="container">
        <div class="header">
            <img src="img/logo2.png" alt="CloverStory Logo2" class="logo2">
            <div class="settings">
                <span></span> <a href="#">설정</a> <a href="#">로그아웃</a>
            </div>
        </div>
        <!-- 큰 점선 테두리 상자 -->
        <div class="dashed-box">
            <!-- 테두리 없는 상자 -->
            <div class="solid-box">
                <div class="inner-box-1"></div>
                <!-- 이미지가 박스 -->
                <div class="image-box">
                    <img src="img/img1.png" alt="Image between boxes 1"
                        class="between-image"> <img src="img/img1.png"
                        alt="Image between boxes 2" class="between-image">
                </div>
                <div align="center" class="inner-box-2">
                    <h1 class="guestbook-title">방명록</h1>
                    <div class="guestbook-line"></div>
                    <!-- 실선 -->

                    <!-- 방명록 작성 폼 -->
                    <div class="guestbook-form">
                        <input type="text" id="guestbook-input" class="guestbook-input"
                            placeholder="일촌에게 방문 기록을 남겨보세요~ !" /> <label for="private"><input
                            type="checkbox" id="private" /> 비밀글</label>
                        <button id="submit-button" class="submit-button">등록</button>
                    </div>

                    <!-- 방명록 항목들이 나타나는 네모 상자 -->
                    <div class="entry-container">
                        <div class="guestbook-entries"></div>
                    </div>

                    <!-- 페이지네이션 영역 -->
                    <div class="pagination-container"></div>

                </div>
            </div>
            <!-- 버튼 -->
            <div class="button-container">
                <button class="custom-button">홈</button>
                <button class="custom-button">프로필</button>
                <button class="custom-button">미니룸</button>
                <button class="custom-button">게시판</button>
                <button class="custom-button"
                    style="background-color: #F7F7F7; font-weight: 600;">방명록</button>
                <button class="custom-button">상점</button>
                <button class="custom-button">게임</button>
                <button class="custom-button">음악</button>
            </div>
        </div>
    </div>

    <!-- 자바스크립트 코드 -->
    <script>
        let entries = []; // 모든 방명록 항목을 저장할 배열
        const itemsPerPage = 3; // 페이지당 항목 수
        let currentPage = 1; // 현재 페이지 번호
        const maxPageButtons = 5; // 한 번에 표시할 페이지 수
        let totalPages = 0;
        let pageGroup = 1; // 페이지 그룹

     // 방명록 작성 후 deleteIcon에 이벤트 추가
        document.getElementById('submit-button').addEventListener('click', function () {
            var inputField = document.getElementById('guestbook-input');
            var content = inputField.value.trim();
            var isSecret = document.getElementById('private').checked; // 비밀글 체크박스 상태 확인

            // 입력된 글의 길이가 70자를 초과하면 경고 메시지 표시
            if (content.length > 70) {
                alert('70글자 이하로 작성해주세요.');
                return; // 글이 70자를 넘으면 방명록 항목을 추가하지 않음
            }

            if (content) {
                // 새로운 방명록 항목 생성
                var newEntry = document.createElement('div');
                newEntry.className = 'guestbook-entry';

                // 비밀글 아이콘 추가 (비밀글 체크박스가 체크된 경우)
                if (isSecret) {
                    var secretIcon = document.createElement('img');
                    secretIcon.src = 'img/secret.png'; // secret.png 파일 경로
                    secretIcon.className = 'secret-icon'; // 아이콘 클래스
                    newEntry.appendChild(secretIcon); // 비밀글 아이콘을 추가
                }

                // 삭제 아이콘 추가 (오른쪽 상단)
                var deleteIcon = document.createElement('img');
                deleteIcon.src = 'img/bin.png'; // bin.png 파일 경로
                deleteIcon.className = 'delete-icon';
                newEntry.appendChild(deleteIcon);

                // 프로필, 이름 추가
                var profileSection = document.createElement('div');
                profileSection.className = 'profile-section';
                profileSection.innerHTML = `
                    <img src="img/p1.png" alt="프로필 사진" class="profile-image" />
                    <span class="profile-name">홍길동</span>
                `;
                newEntry.appendChild(profileSection);

                // 방명록 내용을 담는 컨테이너 생성
                var contentContainer = document.createElement('div');
                contentContainer.className = 'guestbook-content-container';
                var entryContent = document.createElement('p');
                entryContent.className = 'guestbook-content';
                entryContent.textContent = content;

                contentContainer.appendChild(entryContent);
                newEntry.appendChild(contentContainer);

                // 답글을 표시할 컨테이너 추가
                var replyContainer = document.createElement('div');
                replyContainer.className = 'reply-container';
                newEntry.appendChild(replyContainer);

                // 답글 입력 폼 생성
                var replyForm = document.createElement('div');
                replyForm.className = 'reply-form';
                replyForm.innerHTML = `
                    <input type="text" class="reply-input" placeholder="답글을 입력하세요" />
                    <button class="reply-button">답글</button>
                `;

                // 답글 버튼 클릭 시 동작하는 이벤트 핸들러
                replyForm.querySelector('.reply-button').addEventListener('click', function () {
                    var replyInput = replyForm.querySelector('.reply-input');
                    var replyText = replyInput.value.trim();
                    // 답글의 길이가 70자를 초과하면 경고 메시지 표시
                    if (replyText.length > 70) {
                        alert('70글자 이하로 작성해주세요.');
                        return; // 답글이 70자를 넘으면 추가하지 않음
                    }

                    if (replyText) {
                        var replyEntry = document.createElement('p');
                        replyEntry.className = 'reply-content';
                        replyEntry.textContent = '└ 유리 : ' + replyText;

                        // 방명록 항목에 답글 추가 (replyContainer 안에 답글을 추가)
                        replyContainer.appendChild(replyEntry);

                        // 답글 입력 필드 초기화
                        replyInput.value = '';
                    } else {
                        alert('답글을 입력하세요.');
                    }
                });

                // 방명록 항목에 답글 폼 추가
                newEntry.appendChild(replyForm);

                // entries 배열에 항목 추가
                entries.unshift(newEntry);

                // 삭제 아이콘 클릭 이벤트 (해당 인덱스를 전달하여 삭제)
                deleteIcon.addEventListener('click', function () {
                    const confirmDelete = confirm("삭제하시겠습니까?");
                    if (confirmDelete) {
                        deleteEntry(newEntry, entries.indexOf(newEntry));
                    }
                });

                // 현재 페이지와 페이지 그룹을 1로 설정 (새 게시글 추가 시 1페이지로 이동)
                currentPage = 1;
                pageGroup = 1;

                // 페이지 업데이트
                updatePagination();

                // 입력 필드 초기화
                inputField.value = '';
            } else {
                alert('내용을 입력하세요.');
            }
        });


        // 방명록 항목을 삭제하는 함수
// 방명록 항목을 삭제하는 함수
function deleteEntry(entryElement, index) {
    entries.splice(index, 1); // entries 배열에서 해당 항목 삭제
    entryElement.remove(); // DOM에서 해당 방명록 항목 삭제
    
    // 삭제 후 현재 페이지의 항목이 0개 남았다면 이전 페이지로 이동
    const totalEntriesOnCurrentPage = entries.slice((currentPage - 1) * itemsPerPage, currentPage * itemsPerPage).length;

    if (totalEntriesOnCurrentPage === 0 && currentPage > 1) {
        currentPage--; // 이전 페이지로 이동
    }

    updatePagination(); // 삭제 후 페이지네이션 업데이트
}

// 페이지 번호 업데이트 및 표시 함수
function updatePagination() {
    const entriesContainer = document.querySelector('.guestbook-entries');
    const paginationContainer = document.querySelector('.pagination-container');

    // 방명록 항목을 페이지당 3개씩 나눠서 표시
    entriesContainer.innerHTML = ''; // 기존 항목 초기화
    const startIndex = (currentPage - 1) * itemsPerPage;
    const endIndex = startIndex + itemsPerPage;
    const itemsToDisplay = entries.slice(startIndex, endIndex);

    // 현재 페이지에 해당하는 항목을 표시
    itemsToDisplay.forEach(item => entriesContainer.appendChild(item));

    // 페이지 버튼 생성
    paginationContainer.innerHTML = ''; // 기존 페이지 버튼 초기화
    totalPages = Math.ceil(entries.length / itemsPerPage);
    const startPage = (pageGroup - 1) * maxPageButtons + 1;
    const endPage = Math.min(startPage + maxPageButtons - 1, totalPages);

    // 이전 버튼 추가 (1페이지 그룹보다 크면 이전 버튼 표시)
    if (pageGroup > 1) {
        const prevButton = document.createElement('button');
        prevButton.textContent = '이전';
        prevButton.classList.add('page-button', 'nav-button');
        prevButton.addEventListener('click', function () {
            pageGroup--;
            currentPage = (pageGroup - 1) * maxPageButtons + 1; // 이전 페이지 그룹의 첫 번째 페이지로 이동
            updatePagination();
        });
        paginationContainer.appendChild(prevButton);
    }

    // 현재 페이지 그룹에 해당하는 페이지 번호만 표시
    for (let i = startPage; i <= endPage; i++) {
        const pageButton = document.createElement('button');
        pageButton.textContent = i;
        pageButton.classList.add('page-button');
        if (i === currentPage) {
            pageButton.classList.add('active'); // 현재 페이지 표시
        }

        // 페이지 버튼 클릭 시 해당 페이지로 이동
        pageButton.addEventListener('click', function () {
            currentPage = i;
            updatePagination();
        });

        paginationContainer.appendChild(pageButton);
    }

    // 다음 버튼 추가 (더 많은 페이지가 있으면 다음 버튼 표시)
    if (endPage < totalPages) {
        const nextButton = document.createElement('button');
        nextButton.textContent = '다음';
        nextButton.classList.add('page-button', 'nav-button');
        nextButton.addEventListener('click', function () {
            pageGroup++;
            currentPage = (pageGroup - 1) * maxPageButtons + 1; // 다음 페이지 그룹의 첫 번째 페이지로 이동
            updatePagination();
        });
        paginationContainer.appendChild(nextButton);
    }
}


    </script>

</body>
</html>
