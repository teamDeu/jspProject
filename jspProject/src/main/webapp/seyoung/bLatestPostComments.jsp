<%@page import="miniroom.UtilMgr"%>
<%@page import="board.BoardWriteBean"%>
<%@page import="guestbook.GuestbookprofileBean"%>
<%@page import="board.BoardReAnswerBean"%>
<%@page import="board.BoardAnswerBean"%>
<%@page import="board.BoardAnswerMgr"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:useBean id="mgr" class="board.BoardAnswerMgr" />
<jsp:useBean id="rMgr" class="board.BoardReAnswerMgr" />
<jsp:useBean id="pMgr" class="guestbook.GuestbookprofileMgr"/>
<jsp:useBean id="wmgr" class="board.BoardWriteMgr" />
<head>
<style>
/* 댓글 항목 스타일 */
.answer-item {
	display: flex;
	align-items: flex-start;
	margin: 5px 0px;
	width: 100%;
}

/* 사용자 이미지 스타일 */
.user-image {
	width: 30px;
	height: 30px;
	margin-right: 10px;
	border-radius: 50%;
}

/* 댓글 컨텐츠 컨테이너 */
.answer-content-container {
	display: flex;
	flex-direction: column;
	width: 100%;
}

/* 댓글 컨텐츠 스타일 */
.answer-content {
	display: flex;
    flex-direction: column; /* 댓글 내용과 헤더를 세로로 배치 */
    background-color: #f9f9f9;
    border: 1px solid #BAB9AA;

    width: 690px;
    box-sizing: border-box;
}

/* 댓글 헤더 스타일 */
.answer-header {
	display: flex;
	align-items: center;
	margin-bottom: 5px;
}

/* 사용자 이름 스타일 */
.user-name {
	font-weight: bold;
	font-size: 18px;
	margin-right: 10px;
}

/* 댓글 시간 스타일 */
.answer-time {
	font-size: 18px;
	color: black;
	margin-left: 0px; /* 자동으로 오른쪽에 정렬 */
}

/* 삭제 버튼 스타일 */
.delete-btn {
	color: #FF5A5A;
	cursor: pointer;
	border: none;
	background: none;
	font-size: 20px;
	margin-left: -50px;
	
}

.delete-btn2 {
	color: #FF5A5A;
	cursor: pointer;
	border: none;
	background: none;
	font-size: 20px;
	margin-left: 400px;
	
}

.answer-time-container {
    margin-left: auto; /* 삭제 버튼을 오른쪽으로 정렬 */
}

/* 댓글 내용 텍스트 스타일 */
.answer-text {
	font-size: 20px;
	color: black;
	margin-top: 5px;
	text-align: left;
	width: 100%; /* 왼쪽 정렬을 위해 100% 너비 설정 */
}

/* 답글 입력 폼 스타일 */
.reanswer-form {
	display: flex;
	flex-direction: row;
	align-items: flex-start;
	padding: 10px;
	width: 670px;
	margin-top: 5px;
	margin-bottom: 5px;
	border: 1px solid #BAB9AA;
	background-color: #f9f9f9;
}

.reanswer-input {
	width: 90%;
	padding: 5px;
	border: 1px solid #BAB9AA;
	border-radius: 5px;
	font-size: 15px;
}

.reanswer-button {
	padding: 5px 10px;
	border: 1px solid #BAB9AA;
	border-radius: 5px;
	background-color: #f2f2f2;
	cursor: pointer;
	margin-left: 10px;
	font-size: 15px;
}

/* 답글 컨텐츠 스타일 */
.reply-item {
	display: flex;
	align-items: flex-start;
	margin: 5px 0px;
	width: 100%;
}

.reply-content {
	background-color: #f9f9f9;
	border: 1px solid #BAB9AA;
	padding: 10px;
	width: 620px;
	display: flex;
	flex-direction: column;
}

.reply-header {
	display: flex;
	align-items: center;
	margin-bottom: 5px;
}

.reuser-image {
	width: 30px;
	height: 30px;
	margin-right: 10px;
	border-radius: 50%;
}

.reuser-name {
	font-weight: bold;
	font-size: 16px;
	margin-right: 10px;
}

.reply-time {
	font-size: 16px;
	color: black;
	margin-left: 0px; /* 자동으로 오른쪽에 정렬 */
}

.reply-text {
	font-size: 19px;
	color: black;
	margin-top: 5px;
	text-align: left;
}

</style>

</head>

<%
int boardNum = -1;
if(request.getParameter("board_num") != null){
	boardNum = UtilMgr.parseInt(request, "board_num"); // 게시글 번호를 받음
}
String answerNum = request.getParameter("answer_num");
String userId = (String) session.getAttribute("idKey"); // 현재 로그인한 사용자 ID
String board_id = request.getParameter("board_id");

String type = request.getParameter("type");


BoardWriteBean latestBoard = wmgr.getBoard(boardNum);


if (latestBoard != null) {
    // 댓글 허용 여부를 latestBoard가 null이 아닐 때만 확인
    int answerType = latestBoard.getBoard_answertype();

    Vector<BoardAnswerBean> answers = null;

    // 게시글 번호가 유효한지 확인
    if (boardNum != -1) {
        try {
            answers = mgr.bgetAnswers(boardNum);
        } catch (NumberFormatException e) {
            System.out.println("유효하지 않은 게시글 번호: " + boardNum);
        }
    } else {
        System.out.println("게시글 번호가 전달되지 않았습니다.");
    }

    // 댓글 허용 여부 확인 후 처리
    if (answerType == 0) { %>
        <div class="Prohibited">댓글 비허용 글입니다.</div>
    <% } else { 
        // 댓글이 있을 경우 처리
        if (answers != null && answers.size() > 0 && latestBoard != null && userId != null && userId.equals(latestBoard.getBoard_id())) { %>
            <% for (BoardAnswerBean answer : answers) { 
                Vector<BoardReAnswerBean> reanswerList = rMgr.getReAnswerList(answer.getAnswerNum());
                GuestbookprofileBean pBean = pMgr.getProfileByUserId(answer.getAnswerId());  // 작성자 프로필 정보 가져오기
                String name2 = pBean.getProfileName();  // 작성자 이름
                String img2 = pBean.getProfilePicture();  // 작성자 이미지
            %>
            <div class="answer-item" data-answer-num="<%=answer.getAnswerNum()%>">
                <div class="answer-content-container">
                    <!-- 댓글 내용 -->
                    <div class="answer-content">
                        <div class="answer-header">
                            <!-- 사용자 이미지 -->
                            <img class="user-image" src="../miniroom/<%=img2 %>" >
                            <!-- 사용자 이름 -->
                            <div class="user-name"><%=name2 %></div>
                            <!-- 댓글 시간 -->
                            <div class="answer-time"><%=answer.getAnswerAt()%></div>
                            <!-- 삭제 버튼 -->
                            <div class="answer-time-container">
                                <% if (userId != null && userId.equals(answer.getAnswerId())) { %>
                                    <button class="delete-btn" onclick="bdeleteAnswer(<%=answer.getAnswerNum()%>)">삭제</button>
                                <% } %>
                            </div>
                        </div>
                        <!-- 댓글 내용 텍스트 -->
                        <div class="answer-text"><%=answer.getAnswerContent()%></div>
                    </div>
                    <% for (BoardReAnswerBean reAnswerBean : reanswerList) { 
                        String content = reAnswerBean.getReanswer_content();
                        String at = reAnswerBean.getReanswer_at();
                        GuestbookprofileBean repBean = pMgr.getProfileByUserId(reAnswerBean.getReanswer_id());
                        String name = repBean.getProfileName();
                        String img = repBean.getProfilePicture();
                        int reAnswerNum = reAnswerBean.getReanswer_num();
                    %>
                    <div class="reply-item">
                        <img class="reply-icon" src="../seyoung/img/reanswer.png" alt="reply icon">
                        <div class="reply-content">
                            <div class="reply-header">
                                <img class="reuser-image" src="../miniroom/<%=img%>">
                                <div class="reuser-name"><%=name %></div>
                                <div class="reply-time"><%=at %></div>
                                <% if (userId != null && userId.equals(reAnswerBean.getReanswer_id())) { %>
                                    <button class="delete-btn2" onclick="bdeleteReAnswer(<%=reAnswerNum%>)">삭제</button>
                                <% } %>
                            </div>
                            <div class="reply-text"><%=content %></div>
                        </div>
                    </div>
                    <% } %>
                    <!-- 답글 입력 폼 -->
                    <div class="reanswer-form">
                        <input type="text" class="reanswer-input" placeholder="답글을 입력하세요" />
                        <button class="reanswer-button" onclick="baddReAnswer(<%=answer.getAnswerNum()%>, this.previousElementSibling.value)">등록</button>
                    </div>
                </div>
            </div>
            <% } %>
        <% } else { %>
            <div class="no-comments">댓글이 없습니다.</div>
        <% } 
    } 
} else { %>
    <div>해당 게시물을 찾을 수 없습니다.</div>
<% } %>