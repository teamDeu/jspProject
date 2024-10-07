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

int currentPage = 1; // 기본값은 1페이지
int entriesPerPage = 3; // 한 페이지당 방명록 항목 수
int totalPages = mgr.getTotalPages(ownerId);  // 총 페이지 수 가져오기 
// page 파라미터가 있을 경우 해당 값을 현재 페이지로 사용
if (request.getParameter("page") != null) {
    currentPage = Integer.parseInt(request.getParameter("page"));
}

// 가져올 항목의 시작 인덱스를 계산
int startIndex = (currentPage - 1) * entriesPerPage;

ArrayList<GuestbookBean> entries = mgr.getGuestbookEntries(ownerId, startIndex, entriesPerPage);
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
dateFormat.setTimeZone(seoulTimeZone);
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
}
/* 리스트 스타일 제거 */
#guestbookList {
   list-style-type: none; /* 동그라미 모양 제거 */
   padding: 0; /* 리스트의 기본 패딩 제거 */
   margin-top: 90px; /* 리스트의 기본 마진 제거 */
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
#paginationButtons {
    position: absolute; 
    bottom: 70px; /* 버튼과 리스트 사이의 간격 조정 */
    left: 50%; /* 부모 요소의 왼쪽 50% 위치 */
    transform: translateX(-50%); /* 자신의 폭의 절반만큼 왼쪽으로 이동 */
    text-align: center; /* 버튼들을 중앙 정렬 */
}

/* 페이지 버튼 스타일 */
.pagination-button {
    background-color: #ffffff; /* 배경색 */
    color: #000000; /* 글자색 */
    border: 1px solid #DCDCDC;
    border-radius: 5px; /* 둥근 모서리 */
    padding: 2px 8px; /* 안쪽 여백 */
    margin: 0 5px; /* 버튼 간 간격 */
    cursor: pointer; /* 커서 변경 */
    font-size: 16px; /* 글자 크기 */
}

/* 현재 페이지 버튼 스타일 */
.guestbook-active {
    background-color: #DCDCDC;
    color: #000000;
}

</style>
<meta charset="UTF-8">
<title>Guestbook</title>
<script>
//AJAX를 이용한 방명록 작성 함수
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

                        // 방명록이 작성되면 전체 페이지를 다시 로드
                        loadGuestbookPage(1);

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
    answerList.id = "a-List-" + guestbookNum;
    answerList.classList.add('a-list'); // 클래스 추가

    // 답글 작성 폼
    var answerForm = document.createElement("div");
    answerForm.classList.add('a-form');

    var answerTextarea = document.createElement("textarea");
    answerTextarea.id = "aContent-" + guestbookNum;
    answerTextarea.classList.add('a-textarea'); // 클래스 추가
    answerTextarea.placeholder = "답글 내용을 입력하세요";

    var answerButton = document.createElement("button");
    answerButton.type = "button";
    answerButton.textContent = "등록";
    answerButton.classList.add('a-submit-btn');
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
    
 // 새로 생성된 li 요소에 대해 리렌더링 강제
    li.offsetHeight; // 리플로우 강제 트리거

}



     
      //AJAX를 이용한 방명록 삭제 함수
      function deleteGuestbookEntry(guestbookNum) {
          if (confirm("정말 삭제하시겠습니까?")) {
              var xhr = new XMLHttpRequest();
              var cPath = "<%=cPath%>";
              xhr.open("POST", cPath + "/eunhyo/deleteguestbook.jsp", true);
              xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
              xhr.onreadystatechange = function() {
                  if (xhr.readyState === 4 && xhr.status === 200) {
                      // 삭제 성공 시 해당 목록을 새로 로드
                      alert("방명록이 삭제되었습니다.");
                      // 현재 페이지를 가져와서 새로 고침
                      loadGuestbookPage(<%=currentPage%>);
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
          var comment = document.getElementById("aContent-" + guestbookNum).value;
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
                              document.getElementById("aContent-" + guestbookNum).value = '';
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
                              document.getElementById("answer-" + answerNum).remove();
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

      // 페이지 버튼 클릭 시 페이지 로드
      function loadGuestbookPage(pageNumber) {
          console.log("Requesting page:", pageNumber);
          var ownerId = "<%=ownerId%>";
          var xhr = new XMLHttpRequest();
          var cPath = "<%=cPath%>";

          xhr.open("GET", cPath + "/eunhyo/guestbookData.jsp?ownerId=" + ownerId + "&page=" + pageNumber, true);
          xhr.onreadystatechange = function() {
              if (xhr.readyState === 4) {
                  console.log("Loading page:", pageNumber);
                  if (xhr.status === 200) {
                      try {
                          var response = JSON.parse(xhr.responseText);
                          console.log("Response data:", response);
                          updateGuestbookEntries(response.entries);
                          // entries 배열의 길이를 전달
                          updatePaginationButtons(response.totalPages, pageNumber, response.entries.length);
                      } catch (e) {
                          console.error("응답 처리 중 오류 발생:", e);
                      }
                  } else {
                      console.error("AJAX 요청 실패:", xhr.status, xhr.statusText);
                  }
              }
          };
          xhr.send();
      }


      // 방명록 목록을 업데이트하는 함수
      function updateGuestbookEntries(entries) {
          var ul = document.getElementById("guestbookList");
          ul.innerHTML = ""; // 기존 항목 초기화

          // 최신 방명록이 위로 오도록 하기 위해
          entries.reverse().forEach(function(entry) {
              appendGuestbookEntry(
                  entry.guestbookNum, 
                  entry.writerId, 
                  entry.content, 
                  entry.writtenAt, 
                  entry.isSecret, 
                  entry.profileName, 
                  entry.profilePicture
              );
          });
      }



      // AJAX를 이용한 페이지 버튼 업데이트
      function updatePaginationButtons(totalPages, currentPage, entriesLength) {
          var paginationContainer = document.getElementById("paginationButtons");
          paginationContainer.innerHTML = ""; // 기존 버튼 초기화

          console.log("Total pages:", totalPages);

          for (var i = 1; i <= totalPages; i++) {
              var button = document.createElement("button");
              button.textContent = i;
              button.classList.add('pagination-button');

              button.disabled = false; // 모든 페이지 버튼 활성화
              button.onclick = (function(pageNumber) {
                  return function() {
                      loadGuestbookPage(pageNumber); // 클릭 시 해당 페이지 로드
                  };
              })(i);

              if (i === currentPage) {
                  button.classList.add('guestbook-active'); // 현재 페이지 스타일 추가
              }

              paginationContainer.appendChild(button);
          }

          // 현재 페이지가 마지막 페이지일 때
          if (currentPage === totalPages) {
              // 마지막 페이지 항목 수가 2개 이상일 경우
              if (entriesLength < 3) {
                  // 이전 페이지 버튼은 활성화
                  paginationContainer.childNodes.forEach(function(btn) {
                      if (btn.textContent === (currentPage - 1).toString()) {
                          btn.disabled = false;
                      }
                  });
              }
          }
      }





      // 페이지가 로드될 때 버튼 초기화
      document.addEventListener("DOMContentLoaded", function() {
          console.log("DOM fully loaded and parsed.");
          updatePaginationButtons(<%= totalPages %>, <%= currentPage %>); // 현재 페이지 설정
      });


    </script>
</head>
<body>
   <h1 class="guestbook-title">방명록</h1>
   <div class="guestbook-line"></div>

   <div class="entry-container" style="display: flex; flex-direction: column; justify-content: space-between; height: 100%;">
       <!-- 방명록 항목 리스트 -->
      <ul id="guestbookList">
          <% for (GuestbookBean entry : entries) { 
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
                          <p class="author" >
                              <%=profile.getProfileName()%> (<%=entry.getWriterId()%>) 
                              <span class="date"><%= entry.getWrittenAt() != null ? new SimpleDateFormat("yyyy-MM-dd").format(entry.getWrittenAt()) : ""%></span>

                          </p>
                      <% } else { %>
                          <!-- 프로필이 null인 경우 작성자 아이디와 날짜만 표시 -->
                          <p class="author">
                              <%=entry.getWriterId()%> 
                              <span class="date"><%= entry.getWrittenAt() != null ? new SimpleDateFormat("yyyy-MM-dd").format(entry.getWrittenAt()) : ""%></span>

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
                          String answerProfileName = (answerProfile != null) ? answerProfile.getProfileName() : "";
                          String ganswerId = answer.getGanswerId();
                      %>
                          <li id="a-<%=answer.getGanswerNum()%>" class="a-item">
                              <!-- 프로필 이름이 있을 때와 없을 때 각각의 형식으로 출력 -->
                              <p>
                                  ↳ <%= !answerProfileName.isEmpty() ? answerProfileName + " (" + ganswerId + ") :" : ganswerId + " :" %> 
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
                      <textarea id="aContent-<%=entry.getGuestbookNum()%>" class="a-textarea" placeholder="답글 내용을 입력하세요"></textarea>
                      <button type="button" class="a-submit-btn" onclick="adAnswer(<%=entry.getGuestbookNum()%>)">등록</button>
                  </div>

                  <% } %>
              </li>
          <% } %>
      </ul>
   <div id="paginationButtons"></div> <!-- 페이지 버튼 -->

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