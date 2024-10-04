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
	width: 40px;
	height: 40px;
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
	display: flex; /* 이미지와 텍스트를 가로로 배치 */
	align-items: flex-start;
	background-color: #f9f9f9;
	border: 1px solid #BAB9AA;
	padding: 10px;
	width: 600px;
	box-sizing: border-box;
}

/* 댓글 헤더 스타일 (이름과 시간) */
.answer-header {
	display: flex;
	align-items: center;
	width: 100%;
}

/* 사용자 이름 스타일 */
.user-name {
	font-weight: bold;
	font-size: 16px;
	margin-right: 10px;
}

/* 댓글 시간 스타일 */
.answer-time {
	font-size: 14px;
	color: #666;
	margin-left: auto; /* 자동으로 오른쪽에 정렬 */
}

/* 삭제 버튼 스타일 */
.delete-btn {
	color: #FF5A5A;
	cursor: pointer;
	border: none;
	background: none;
	font-size: 15px;
}

/* 댓글 내용 텍스트 스타일 */
.answer-text {
	font-size: 18px;
	color: black;
	margin-top: 5px;
	text-align: left;
}

/* 답글 입력 폼 스타일 */
.reanswer-form {
	display: flex;
	flex-direction: row;
	align-items: flex-start;
	padding: 10px;
	width: 620px;
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
	width: 548px;
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
	font-size: 15px;
	color: black;
}

.reply-text {
	font-size: 18px;
	color: black;
	margin-top: 5px;
	text-align: left;
}

</style>

</head>

<%
String boardNum = request.getParameter("board_num"); // 게시글 번호를 받음

Vector<BoardAnswerBean> answers = null;

//게시글 번호가 유효한지 확인
if (boardNum != null && !boardNum.isEmpty()) {
	try {
		answers = mgr.bgetAnswers(Integer.parseInt(boardNum));
	} catch (NumberFormatException e) {
		System.out.println("유효하지 않은 게시글 번호: " + boardNum);
	}
} else {
	System.out.println("게시글 번호가 전달되지 않았습니다.");
}
%>



<%
if (answers != null && answers.size() > 0) {
%>
<%
for (BoardAnswerBean answer : answers) {
	Vector<BoardReAnswerBean> reanswerList = rMgr.getReAnswerList(answer.getAnswerNum());
%>
<div class="answer-item" data-answer-num="<%=answer.getAnswerNum()%>">
	<!-- 사용자 이미지 -->
	<img src="<%=request.getContextPath()%>/seyoung/img/character2.png"
		alt="사용자 이미지" class="user-image" />

	<div class="answer-content-container">
		<!-- 댓글 내용 -->
		<div class="answer-content">
			<div class="answer-header">
				<!-- 사용자 이름 -->
				<div class="user-name">
					<%=answer.getAnswerId()%>
				</div>

				<!-- 댓글 시간 -->
				<div class="answer-time">
					<%=answer.getAnswerAt()%>
				</div>

				<!-- 삭제 버튼 -->
				<div class="answer-time-container">
					<button class="delete-btn"
						onclick="bdeleteAnswer(<%=answer.getAnswerNum()%>)">삭제
					</button>
				</div>
			</div>

			<!-- 댓글 내용 텍스트 -->
			<div class="answer-text">
				<%=answer.getAnswerContent()%>
			</div>
		</div>
		<%
		for (BoardReAnswerBean reAnswerBean : reanswerList) {
			
			String content = reAnswerBean.getReanswer_content();
			String at = reAnswerBean.getReanswer_at();
			GuestbookprofileBean pBean = pMgr.getProfileByUserId(reAnswerBean.getReanswer_id());
			String name = pBean.getProfileName();
			String img = pBean.getProfilePicture();
			int reAnswerNum = reAnswerBean.getReanswer_num();
		%>
		<div class="reply-item">
			<img class="reply-icon" src="../seyoung/img/reanswer.png"
				alt="reply icon">
			<div class="reply-content">
				<div class="reply-header">
					<img class="reuser-image" src="../miniroom/<%=img%>">
					<div class="reuser-name"><%=name %></div>
					<div class="reply-time"><%=at %></div>
					<!-- 예시 시간 -->
				</div>
				<div class="reply-text"><%=content %></div>
				<!-- replyText에 해당하는 내용 -->
			</div>
		</div>
		<%
		}
		%>
		<!-- 답글 입력 폼 -->
		<div class="reanswer-form">
			<input type="text" class="reanswer-input" placeholder="답글을 입력하세요" />
			<button class="reanswer-button"
				onclick="baddReAnswer(<%=answer.getAnswerNum()%>, this.previousElementSibling.value)">
				등록</button>
		</div>
	</div>
</div>
<%
}
%>
<%
} else {
%>
<div class="no-comments">댓글이 없습니다.</div>
<%
}
%>