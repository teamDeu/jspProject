<%@page import="guestbook.GuestbookprofileBean"%>
<%@page import="java.util.TimeZone"%>
<%@page import="guestbook.GuestbookMgr"%>
<%@page import="guestbook.GuestbookBean"%>
<%@page import="guestbook.GuestbookanswerMgr"%>
<%@page import="guestbook.GuestbookanswerBean"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>


<jsp:useBean id="mgr" class="guestbook.GuestbookMgr" />
<jsp:useBean id="answerMgr" class="guestbook.GuestbookanswerMgr" />
<jsp:useBean id="profileMgr" class="guestbook.GuestbookprofileMgr" />

<%
TimeZone seoulTimeZone = TimeZone.getTimeZone("Asia/Seoul");
TimeZone.setDefault(seoulTimeZone);

String cPath = request.getContextPath();
String ownerId = request.getParameter("ownerId");
String sessionUserId = (String) session.getAttribute("idKey"); // 현재 로그인한 사용자 ID

ArrayList<GuestbookBean> entries = mgr.getGuestbookEntries(ownerId);
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
dateFormat.setTimeZone(seoulTimeZone);

int itemsPerPage = 4; // 페이지당 방명록 개수
int currentGuestbookPage = 1; // 현재 페이지
int totalEntries = entries.size(); // 전체 방명록 수
int totalPages = (int) Math.ceil((double) totalEntries / itemsPerPage); // 총 페이지 수

// 현재 페이지 파라미터를 가져와서 설정
if (request.getParameter("page") != null) {
    currentGuestbookPage = Integer.parseInt(request.getParameter("page")); // URL 파라미터로 페이지 번호 받기
}

// 방명록 항목의 시작 인덱스 계산
int startIndex = (currentGuestbookPage - 1) * itemsPerPage;
int endIndex = Math.min(startIndex + itemsPerPage, totalEntries);

// 현재 페이지에 해당하는 방명록만 표시
ArrayList<GuestbookBean> currentEntries;
if (startIndex < totalEntries) {
    currentEntries = new ArrayList<>(entries.subList(startIndex, endIndex));
} else {
    currentEntries = new ArrayList<>(); // 페이지 수가 초과할 경우 빈 리스트
}
%>


<!DOCTYPE html>
<html lang="ko">
<head>
<!-- 캐시 방지 메타 태그 추가 -->
<meta http-equiv="Cache-Control"
   content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<style>
/*방명록 텍스트 스타일*/
.guestbook-title {
   color: #80A46F;
   text-align: center;
   font-size: 36px;
   font-weight: 600;
   position: absolute;
   top: 0px;
   left: 30px;
}
/* 실선 스타일 */
.guestbook-line {
   border-bottom: 2px solid #BAB9AA; /* 실선 색상 및 두께 */
   width: 95%; /* 실선의 너비 */
   position: absolute;
   top: 80px;
   left: 25px;
}
/* 작성 폼 스타일 */
.guestbook-form {
   display: flex;
   align-items: center;
   position: absolute;
   left: 30px;
   bottom: 30px;
   width: 90%;
   height: 30px;
   justify-content: space-between;
   background-color: #F2F2F2;
   padding: 10px;
   border: 1px solid #e0e0d1;
   border-radius: 5px;
   margin-bottom: -20px;
}
/* textarea 스타일 */
#guestbookContent {
    margin-top:5px;
   height: 20px;
   width: 660px;
   flex: 1;
   padding: 8px;
   border: 1px solid #DCDCDC;
   border-radius: 5px;
   color: #000000;
   background-color: #FFFFFF;
   font-family: 'NanumTobak', sans-serif;
   font-size: 20px;
}
/* submit 버튼 스타일 */
#submitButton {
   display: flex;
   background-color: #FFFFFF;
   color: #666;
   border: 1px solid #DCDCDC;
   border-radius: 10px;
   padding: 5px 10px;
   margin-left: 10px;
   cursor: pointer;
   font-size: 20px;
   position: absolute;
   right: 10px; 
   bottom: 7px;
}
/* 방명록 전체 container */
.entry-container {
   width: 100%;
   height: 560px;
   margin-top: 0px;
   background-color: #F7F7F7;
   overflow-y: auto; /* 세로 스크롤 활성화 */
   overflow-x: hidden; /* 가로 스크롤 숨김 */
}
/* 리스트 스타일 제거 */
#guestbookList {
   list-style-type: none; /* 동그라미 모양 제거 */
   padding: 0; /* 리스트의 기본 패딩 제거 */
   margin: 0px; /* 리스트의 기본 마진 제거 */
}

#guestbookList li {
   margin-bottom: 45px; /* 리스트 항목 간 간격 */
   padding: 10px; /* 클릭 가능한 영역 확보 */
   background-color: #FFFFFF;
   border: 1px solid #DCDCDC;
   border-radius: 8px;
   position: relative; /* 자식 요소 위치 조정 */
   font-size: 21.5px;
   margin-left: 20px;
   width: 820px;
   height: 125px;
   margin-left: 25px;
}

/* 삭제 이미지 스타일 */
.delete-icon {
   width: 13px;
   height: 15px;
   position: absolute;
   top: 20px;
   right: 20px;
   cursor: pointer;
}

.author-container {
   display: inline-block; /* 컨테이너가 텍스트와 밑줄을 함께 감싸도록 함 */
   position: relative; /* 밑줄 위치를 조절하기 위해 설정 */
   margin-left: 0px; /* 텍스트를 왼쪽에 여백 주기 */
}

.author {
   margin-left: 35px;
   margin-top: 0px;
   font-size: 22px;
   font-weight: bold;
   display: inline; /* 같은 줄에 표시 */
   cursor : pointer;
}

.author-underline {
   height: 1px; /* 밑줄의 두께 */
   width: 820px; /* 밑줄의 길이 */
   background-color: #ccc; /* 밑줄 색상 */
   margin-top: 5px;
}

.content {
   margin-left: 5px;
   margin-top: 0px;
   font-size: 25px;
}

.date {
   margin-left: 5px;
    font-size: 20px;
    font-weight: normal;
}

/* li에 적용될 기본 스타일 */
.guestbook-entry {
   margin-bottom: 20px;
   padding: 10px;
   background-color: #FFFFFF;
   border: 1px solid #DCDCDC;
   border-radius: 8px;
   position: relative;
   font-size: 21.5px;
}

/* 비밀글 체크박스 스타일 */
#secretCheckbox {
   margin-right: 13px;
   position: absolute;
   right: 90px;
   top: 15px;
}

label[for="secretCheckbox"] {
   margin-right: 5px;
   font-size: 22px;
   position: absolute;
   right: 60px;
   top: 10px;
   color: #666;
}

/* 비밀글 아이콘 스타일 */
.secret-icon {
   width: 12px;
   height: 15px;
   position: absolute;
   top: 20px;
   right: 50px;
}
/* 비밀글 안내 컨테이너 스타일 */
.secret-container {
    display: flex; /* 이미지와 텍스트를 가로로 나란히 배치 */
    align-items: center; /* 이미지와 텍스트를 수직으로 중앙 정렬 */
    justify-content: center; /* 컨테이너 중앙에 배치 */
    position: absolute;
    top: 50%; /* 수직 중앙 정렬 */
    left: 50%; /* 수평 중앙 정렬 */
    transform: translate(-50%, -50%); /* 정확한 중앙으로 이동 */
}

/* 비밀글 안내 이미지 스타일 */
.secret-image {
    width: 15px; /* 이미지 크기 */
    height: auto;
    margin-right: 10px; /* 이미지와 텍스트 사이 간격 */
}

/* 비밀글 안내 텍스트 스타일 */
.secret-text {
    font-size: 22px; /* 텍스트 크기 */
    color: #000000; /* 텍스트 색상 */
    margin: 0;
}
/* 프로필 사진 스타일 */
.profile-image {
    width: 30px; /* 프로필 사진 크기 */
    height: 30px;
    border-radius: 50%; /* 원형으로 만들기 */
    margin-right: 10px; /* 사진과 텍스트 사이 간격 */
    vertical-align: middle; /* 텍스트와 수직 중앙 정렬 */
    position: absolute;
    top:0px;
    
}

/* 답글 목록 스타일 */
.a-list {
    width: 95%;
    max-height: 60px; /* 최대 높이 설정 (필요에 따라 높이 조절) */
    list-style-type: none;
    padding: 0px;
    background-color: #ffffff;
    overflow-y: auto; /* 세로 스크롤 활성화 */
    overflow-x: hidden; /* 가로 스크롤 숨김 */
    position: absolute;
    top: 75px;
    left: 20px;
}
/* 답글 항목 스타일 */
.a-item {
    display: flex;
    align-items: center; /* 텍스트를 수직 중앙에 정렬 */
    width: 102% !important;
    height: 30px !important;
    padding: 0 !important;
    margin: 0 !important;
    font-size: 18.5px !important;
    line-height: 1.5;
    border: none !important;
}


/* 답글 작성 폼 스타일 */
.a-form {
    display: flex;
    align-items: center;
    justify-content: flex-start;
    width: 830px;
}

/* 답글 작성 textarea 스타일 */
.a-textarea {
   width: 100%; /* 적당한 너비 */
   height: 20px; /* 높이 조정 */
   padding:5px;
   border: 1px solid #ccc;
   border-radius: 5px;
   font-family: 'NanumTobak', sans-serif;
   font-size: 18px;
   margin-right: 10px;
   margin-left:-10px;
   resize: none; /* 크기 조절 비활성화 */
   outline: none; /* 포커스 시 외곽선 제거 */
   margin-top:55px;
}

/* 답글 등록 버튼 스타일 */
.a-submit-btn {
   background-color: #e4e4e4; /* 강조된 색상 */
   color: #000000;
   border: none;
   border-radius: 5px;
   cursor: pointer;
   font-family: 'NanumTobak', sans-serif;
   font-size: 18px;
   height:30px;
   width:50px;
   margin-top:55px;
}
/* 답글 삭제 버튼 스타일 */
.delete-a-btn {
    background-color: #ffffff; /* 배경색 */
    color: #000000; /* 글자색 */
    border: none; /* 테두리 없음 */
    cursor: pointer; /* 마우스 커서 변경 */
    position: absolute; /* 절대 위치 지정 */
    right: 10px; /* 오른쪽 끝에 10px 간격 */
    top: 50%; /* 세로 중앙에 위치 */
    transform: translateY(-50%); /* 세로 중앙 정렬 */
    font-size: 16px; /* 버튼 글자 크기 */
    padding: 5px 10px; /* 버튼 안쪽 여백 */
}


</style>
<meta charset="UTF-8">
<title>Guestbook</title>
<script>
     // AJAX를 이용한 방명록 작성 함수
        // 방명록 작성 함수 (AJAX 사용)
   function addGuestbookEntry() {
    var content = document.getElementById("guestbookContent").value;
    var ownerId = "<%=ownerId%>";
    var isSecret = document.getElementById("secretCheckbox").checked ? 1 : 0; // 체크박스 상태 (0 또는 1)
    var xhr = new XMLHttpRequest();
    var cPath = "<%=cPath%>";

    xhr.open("POST", cPath + "/eunhyo/guestbookadd.jsp", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                // JSON 응답을 처리하여 방명록에 추가
                try {
                    var response = JSON.parse(xhr.responseText);
                    if (response.guestbookNum !== 0) {
                       alert("방명록이 작성되었습니다.");
                        appendGuestbookEntry(
                              response.guestbookNum, 
                                response.writerId, 
                                response.content, 
                                response.writtenAt, 
                                isSecret,
                                response.profileName, // 프로필 이름 추가
                                response.profilePicture // 프로필 사진 추가
                        );
                        // 입력 필드 초기화
                        document.getElementById("guestbookContent").value = '';
                        document.getElementById("secretCheckbox").checked = false;
                    } else {
                        alert("방명록 작성에 실패하였습니다.");
                    }
                } catch (e) {
                    console.error("응답 처리 중 오류 발생:", e);
                    alert("응답 처리 중 오류가 발생하였습니다.");
                }
            } else {
                console.error("요청 실패:", xhr.status, xhr.statusText);
                alert("방명록 등록 요청이 실패하였습니다.");
            }
        }
    };
    xhr.send("content=" + encodeURIComponent(content) + "&ownerId=" + encodeURIComponent(ownerId) + "&secret=" + isSecret);
}

     
     // 새 방명록 항목을 페이지에 추가하는 함수
function appendGuestbookEntry(guestbookNum, writerId, content, writtenAt, isSecret, profileName, profilePicture) {
    var ul = document.getElementById("guestbookList");
    if (!ul) {
        console.error("guestbookList가 존재하지 않습니다.");
        return;
    }

    // li 요소 생성 및 클래스 추가
    var li = document.createElement("li");
    li.id = "entry-" + guestbookNum;
    li.classList.add('guestbook-entry');

    // 작성자 컨테이너 생성
    var authorContainer = document.createElement("div");
    authorContainer.classList.add('author-container');

    // 프로필 사진 생성 (profilePicture가 있을 경우에만)
    if (profilePicture) {
        var profileImg = document.createElement("img");
        profileImg.src = profilePicture;
        profileImg.alt = "프로필 사진";
        profileImg.classList.add('profile-image');
        authorContainer.appendChild(profileImg);
    }

    // 작성자 텍스트 생성
    var author = document.createElement("p");
    author.classList.add('author');
    
    // 날짜 텍스트 생성
    var dateElem = document.createElement("span");
    dateElem.classList.add('date'); 
    dateElem.textContent = " " + writtenAt;

    author.textContent = profileName ? profileName + " (" + writerId + ")" : writerId;
    author.appendChild(dateElem);
    
    authorContainer.appendChild(author);

    // 작성자 밑줄 생성
    var underline = document.createElement("div");
    underline.classList.add('author-underline');

    // 컨텐츠 텍스트 생성
    var contentElem = document.createElement("p");
    contentElem.classList.add('content');
    contentElem.textContent = content;

    // 비밀글 아이콘 추가 (조건에 맞는 경우)
    if (isSecret === 1) {
        var secretIcon = document.createElement("img");
        secretIcon.src = 'img/secret.png';
        secretIcon.classList.add('secret-icon');
        li.appendChild(secretIcon);
    }

    // 휴지통 아이콘 생성 및 삭제 함수 연결
    var deleteIcon = document.createElement("img");
    deleteIcon.src = 'img/bin.png';
    deleteIcon.classList.add('delete-icon');
    deleteIcon.onclick = function() {
        deleteGuestbookEntry(guestbookNum);
    };
    li.appendChild(deleteIcon);
    
    // 답글 목록 및 답글 작성 폼 추가
    var answerList = document.createElement("ul");
    answerList.id = "answerList-" + guestbookNum;
    answerList.classList.add('alist'); // 클래스 추가

    // 답글 작성 폼
    var answerForm = document.createElement("div");
    answerForm.classList.add('an-form');

    var answerTextarea = document.createElement("textarea");
    answerTextarea.id = "answerContent-" + guestbookNum;
    answerTextarea.classList.add('a-textarea'); // 클래스 추가
    answerTextarea.placeholder = "답글 내용을 입력하세요";

    var answerButton = document.createElement("button");
    answerButton.type = "button";
    answerButton.textContent = "등록";
    answerButton.classList.add('a-submit-btn'); // 클래스 추가
    answerButton.onclick = function() {
        adAnswer(guestbookNum);
    };

    answerForm.appendChild(answerTextarea);
    answerForm.appendChild(answerButton);

    // li 요소에 모든 생성한 요소 추가
    li.appendChild(authorContainer);
    li.appendChild(underline);
    li.appendChild(contentElem);
    li.appendChild(answerList); // 답글 목록 추가
    li.appendChild(answerForm); // 답글 작성 폼 추가

    ul.prepend(li); // 새 항목을 목록의 맨 위에 추가
}

     
        // AJAX를 이용한 방명록 삭제 함수
        function deleteGuestbookEntry(guestbookNum) {
            if (confirm("정말 삭제하시겠습니까?")) {
                var xhr = new XMLHttpRequest();
                var cPath = "<%=cPath%>";
                xhr.open("POST", cPath + "/eunhyo/deleteguestbook.jsp", true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        // 삭제 성공 시 해당 목록 삭제
                        alert("방명록이 삭제되었습니다.");
                        document.getElementById("entry-" + guestbookNum).remove();
                    }
                };
                xhr.send("guestbookNum=" + guestbookNum);
            }
        }
        
     // 새 답글 항목을 페이지에 추가하는 함수
      function appendAnswer(answerNum, guestbookNum, ganswerId, comment, ganswerAt, profileName) {
          var ul = document.getElementById("a-list-" + guestbookNum);
          if (!ul) {
              console.error("답글 목록이 존재하지 않습니다.");
              return;
          }
      
          // li 요소 생성 및 클래스 추가
          var li = document.createElement("li");
          li.id = "a-" + answerNum;
          li.classList.add('a-item'); // 클래스 변경
          li.style.position = 'relative'; // 버튼 배치를 위한 상대 위치 설정
      
          // 답글 내용 추가
          var contentElem = document.createElement("p");
          contentElem.classList.add('a-content'); // 필요한 경우 클래스 추가
      
          if (profileName && profileName !== "") {
              contentElem.textContent = "↳ " + profileName + " (" + ganswerId + ") : " + comment + " (" + ganswerAt + ")";
          } else {
              contentElem.textContent = "↳ " + ganswerId + " : " + comment + " (" + ganswerAt + ")";
          }
      
          li.appendChild(contentElem);
      
          // 답글 삭제 버튼 추가 (로그인한 사용자가 답글 작성자 또는 방명록 주인인 경우)
          var sessionUserId = "<%=sessionUserId%>"; // 현재 로그인한 사용자 ID
          if (sessionUserId !== null && (sessionUserId === ganswerId || sessionUserId === "<%=ownerId%>")) {
              var deleteButton = document.createElement("button");
              deleteButton.type = "button";
              deleteButton.textContent = "삭제";
              deleteButton.classList.add('delete-a-btn'); // 클래스 변경
              deleteButton.onclick = function() {
                  deleteAnswer(answerNum, guestbookNum);
              };
              
              li.appendChild(deleteButton); // 삭제 버튼을 답글 <li>에 추가
          }
      
          ul.appendChild(li); // 새 답글을 목록에 추가
      
          // 새로 생성된 li 요소에 대해 리렌더링 강제
          li.offsetHeight; // 리플로우 강제 트리거
      }


      // 답글 작성 함수
      function adAnswer(guestbookNum) {
          var comment = document.getElementById("answerContent-" + guestbookNum).value;
          var xhr = new XMLHttpRequest();
          var cPath = "<%=cPath%>";
      
          xhr.open("POST", cPath + "/eunhyo/adAnswer.jsp", true);
          xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
          xhr.onreadystatechange = function() {
              if (xhr.readyState === 4) {
                  if (xhr.status === 200) {
                      try {
                          var response = JSON.parse(xhr.responseText);
                          if (response.answerNum !== 0) {
                              alert("답글이 작성되었습니다.");
                              appendAnswer(
                                  response.answerNum, 
                                  response.guestbookNum, 
                                  response.ganswerId, 
                                  response.ganswerComment, 
                                  response.ganswerAt,
                                  response.profileName // 프로필 이름 추가
                              );
                              // 입력 필드 초기화
                              document.getElementById("answerContent-" + guestbookNum).value = '';
                          } else {
                              alert("답글 작성에 실패하였습니다.");
                          }
                      } catch (e) {
                          console.error("응답 처리 중 오류 발생:", e);
                          alert("응답 처리 중 오류가 발생하였습니다.");
                      }
                  } else {
                      console.error("요청 실패:", xhr.status, xhr.statusText);
                      alert("답글 등록 요청이 실패하였습니다.");
                  }
              }
          };
          xhr.send("guestbookNum=" + guestbookNum + "&comment=" + encodeURIComponent(comment));
      }

      
      // AJAX를 이용한 답글 삭제 함수
      function deleteAnswer(answerNum, guestbookNum) {
          if (confirm("정말 답글을 삭제하시겠습니까?")) {
              var xhr = new XMLHttpRequest();
              var cPath = "<%=cPath%>";
              
              xhr.open("POST", cPath + "/eunhyo/deleteAnswer.jsp", true);
              xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
              xhr.onreadystatechange = function() {
                  if (xhr.readyState === 4) {
                      if (xhr.status === 200) {
                          // 삭제 성공 시 해당 답글 목록에서 제거
                          var response = JSON.parse(xhr.responseText);
                          if (response.success) {
                              alert("답글이 삭제되었습니다.");
                              document.getElementById("a-" + answerNum).remove();
                          } else {
                              alert("답글 삭제에 실패하였습니다.");
                          }
                      } else {
                          console.error("요청 실패:", xhr.status, xhr.statusText);
                          alert("답글 삭제 요청이 실패하였습니다.");
                      }
                  }
              };
              xhr.send("answerNum=" + answerNum + "&guestbookNum=" + guestbookNum);
          }
      }

      function changeGuestbookPage(page) {
           const xhr = new XMLHttpRequest();
           xhr.open("GET", "../eunhyo/guestbook.jsp?page=" + page + "&ownerId=" + '<%=ownerId%>', true); // 페이지 요청
           xhr.onreadystatechange = function() {
               if (xhr.readyState === 4 && xhr.status === 200) {
                   // AJAX 요청의 응답을 HTML로 파싱
                   const response = xhr.responseText;
                   const parser = new DOMParser();
                   const doc = parser.parseFromString(response, "text/html");

                   // 방명록 리스트와 페이지네이션 업데이트
                   document.getElementById("guestbookList").innerHTML = doc.getElementById("guestbookList").innerHTML;
                   document.querySelector('#guestbook_pagination').innerHTML = doc.querySelector('.pagination').innerHTML;

                   updateGuestbookPagination(page); // 현재 페이지를 업데이트
               }
           };
           xhr.send();
       }

       function updateGuestbookPagination(currentPage) {
           const pagination = document.querySelector('#guestbook_pagination');
           pagination.querySelectorAll('.page').forEach(span => {
              if(span.textContent == currentPage){
                  span.classList.add('active'); // 현재 페이지 강조;
              }
              else{
                 span.classList.remove('active');
              }
           });
       }

    </script>
</head>
<body>
   <h1 class="guestbook-title">방명록</h1>
   <div class="guestbook-line"></div>

   <div class="entry-container">
       <!-- 방명록 항목 리스트 -->
      <ul id="guestbookList">
          <% for (GuestbookBean entry : currentEntries) { 
             
              // 작성자의 프로필 정보를 가져옴
              GuestbookprofileBean profile = profileMgr.getProfileByUserId(entry.getWriterId());
              ArrayList<GuestbookanswerBean> answers = answerMgr.getAnswersForGuestbook(entry.getGuestbookNum());
          %>
              <li id="entry-<%=entry.getGuestbookNum()%>">
                  <!-- 비밀글 처리 로직 -->
                  <% if ("1".equals(entry.getGuestbookSecret()) && sessionUserId != null 
                          && !(sessionUserId.equals(entry.getWriterId()) || sessionUserId.equals(ownerId))) { %>
                      <!-- 비밀글이며 작성자 또는 방명록 주인이 아닌 경우 -->
                      <div class="secret-container">
                          <img src="img/secret.png" class="secret-image">
                          <p class="secret-text">비밀글입니다.</p>
                      </div>
                  <% } else { %>
                      <!-- 작성자의 프로필 사진과 이름, 날짜를 표시 -->
                      <div class="author-container" onclick = "onclickMainProfileFriendsDiv(this)">
                      <% if (profile != null) { %>
                          <!-- 프로필 사진 -->
                          <img src="<%=profile.getProfilePicture()%>" alt="프로필 사진" class="profile-image">
                          <!-- 프로필 이름과 작성자 아이디, 날짜 함께 표시 -->
                          <p class="author">
                              <%=profile.getProfileName()%> (<%=entry.getWriterId()%>) 
                              <span class="date"><%=entry.getWrittenAt() != null ? dateFormat.format(entry.getWrittenAt()) : ""%></span>
                          </p>
                      <% } else { %>
                          <!-- 프로필이 null인 경우 작성자 아이디와 날짜만 표시 -->
                          <p class="author">
                              <%=entry.getWriterId()%> 
                              <span class="date"><%=entry.getWrittenAt() != null ? dateFormat.format(entry.getWrittenAt()) : ""%></span>
                          </p>
                      <% } %>
                      <div>
                         <jsp:include page="../miniroom/profileFunctionDiv.jsp">
                        <jsp:param value="<%=entry.getWriterId()%>" name="profileId"/>
                        <jsp:param value="guestbook" name ="type"/>
                     </jsp:include>
                      </div>
                      <div class="author-underline"></div>
                  </div>
      
                      <!-- 비밀글이 아니거나, 작성자 또는 방명록 주인인 경우 내용 표시 -->
                      <p class="content"><%=entry.getGuestbookContent()%></p>
                      
                      <!-- 비밀글이면 방명록 주인 또는 작성자에게만 secret.png 아이콘 표시 -->
                      <% if ("1".equals(entry.getGuestbookSecret()) && sessionUserId != null 
                              && (sessionUserId.equals(entry.getWriterId()) || sessionUserId.equals(ownerId))) { %>
                          <img src="img/secret.png" class="secret-icon" alt="비밀글">
                      <% } %>
      
                      <!-- 로그인한 사용자가 방명록 주인 또는 작성자일 경우에만 휴지통 아이콘 표시 -->
                      <% if (sessionUserId != null && (sessionUserId.equals(entry.getWriterId()) || sessionUserId.equals(ownerId))) { %>
                          <img src="img/bin.png" class="delete-icon"
                          onclick="deleteGuestbookEntry(<%=entry.getGuestbookNum()%>)"
                          alt="삭제">
                      <% } %>
      
                     <!-- 답글 목록 (방명록 항목 내부로 이동) -->
                  <ul id="a-list-<%=entry.getGuestbookNum()%>" class="a-list">
                <% for (GuestbookanswerBean answer : answers) { 
                    // 답글 작성자의 프로필 정보 가져오기
                    GuestbookprofileBean answerProfile = profileMgr.getProfileByUserId(answer.getGanswerId());
                    String answerProfileName = (answerProfile != null) ? answerProfile.getProfileName() : null;
                    String ganswerId = answer.getGanswerId();
                %>
                    <li id="a-<%=answer.getGanswerNum()%>" class="a-item">
                        <!-- 프로필 이름이 있을 때와 없을 때 각각의 형식으로 출력 -->
                        <p>
                            ↳ <%= (answerProfileName != null && !answerProfileName.isEmpty()) ? answerProfileName + " (" + ganswerId + ") :" : ganswerId + " :" %> 
                            <%= answer.getGanswerComment() %> (<%= answer.getGanswerAt() %>)
                            
                            <!-- 삭제 버튼: sessionUserId가 답글 작성자(ganswerId) 또는 방명록 주인(ownerId)인 경우에만 표시 -->
                            <% if (sessionUserId != null && (sessionUserId.equals(ganswerId) || sessionUserId.equals(ownerId))) { %>
                                <button type="button" class="delete-a-btn" onclick="deleteAnswer(<%=answer.getGanswerNum()%>, <%=entry.getGuestbookNum()%>)">삭제</button>
                            <% } %>
                        </p>
                    </li>
                <% } %>
            </ul>
                  
                  <!-- 답글 작성 폼 (방명록 항목 내부로 이동) -->
                  <div class="a-form">
                      <textarea id="answerContent-<%=entry.getGuestbookNum()%>" class="a-textarea" placeholder="답글 내용을 입력하세요"></textarea>
                      <button type="button" class="a-submit-btn" onclick="adAnswer(<%=entry.getGuestbookNum()%>)">등록</button>
                  </div>

                  <% } %>
              </li>
          <% } %>
      </ul>
       <!-- 페이지네이션 -->
    <div class="pagination" id ="guestbook_pagination">
        <% for (int i = 1; i <= totalPages; i++) { %>
            <span class="page <%= (i == 1) ? "active" : "" %>" onclick="changeGuestbookPage(<%= i %>)"><%= i %></span>
        <% } %>
    </div>
      
</div>
   <div class="guestbook-form">
      <form id="guestbookForm" onsubmit="addGuestbookEntry(); return false;">
         <label for="secretCheckbox">비밀글</label> <input type="checkbox"
            id="secretCheckbox" name="secretCheckbox">
         <textarea id="guestbookContent" rows="5" placeholder="방명록 내용을 입력하세요"></textarea>
         <br> <input type="hidden" name="ownerId" value="<%=ownerId%>">
         <input type="submit" id="submitButton" value="등록">

      </form>
   </div>
</body>
</html>