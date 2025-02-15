<%@page import="alarm.AlarmMgr"%>
<%@page import="board.BoardAnswerMgr"%>
<%@page import="alarm.AlarmBean"%>
<%@page import="pjh.MemberMgr"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="board.BoardWriteMgr" %>
<%@ page import="board.BoardWriteBean" %>
<jsp:useBean id="mgr" class="board.BoardWriteMgr" scope="request"/>

<%
	
    // 세션에서 사용자 ID 가져오기 (로그인된 사용자라 가정)
    String boardId = (String) session.getAttribute("idKey");
	String saveFolder = application.getRealPath("/miniroom/img");
    // 폼 데이터 가져오기 (MultipartRequest를 사용하여 파일 업로드와 폼 데이터 처리)
    MultipartRequest multi = new MultipartRequest(request, saveFolder, 1024*1024*10, "UTF-8", new DefaultFileRenamePolicy());

    String boardFolderStr = multi.getParameter("board_folder");
    String boardTitle = multi.getParameter("board_title");
    String boardContent = multi.getParameter("board_content_text");
    String boardVisibilityStr = multi.getParameter("board_visibility");
    String boardAnswerTypeStr = multi.getParameter("board_answertype");

    if (boardTitle == null || boardTitle.trim().isEmpty()) {
        out.println("<script>alert('제목을 입력해주세요.'); history.back();</script>");
        return; // 폼 제출 중단
    }

    // 폴더 번호 및 기타 데이터 처리
    int boardFolder = (boardFolderStr != null && !boardFolderStr.isEmpty()) ? Integer.parseInt(boardFolderStr) : -1;
    int boardVisibility = (boardVisibilityStr != null && !boardVisibilityStr.isEmpty()) ? Integer.parseInt(boardVisibilityStr) : 0;
    int boardAnswerType = (boardAnswerTypeStr != null && !boardAnswerTypeStr.isEmpty()) ? Integer.parseInt(boardAnswerTypeStr) : 0;

    // 이미지 업로드 처리
    String imagePath = null; // 이미지 파일이 없을 경우 null로 처리
    String fileName = multi.getFilesystemName("image_file");
    if (fileName != null && !fileName.isEmpty()) {
        imagePath = "img/" + fileName; // 이미지 파일 경로 설정
    }

    // BoardWriteBean 객체 생성 및 데이터 설정
    BoardWriteMgr boardMgr = new BoardWriteMgr();
    BoardWriteBean boardBean = new BoardWriteBean();
    boardBean.setBoard_id(boardId);
    boardBean.setBoard_folder(boardFolder);
    boardBean.setBoard_title(boardTitle);
    boardBean.setBoard_content(boardContent);
    boardBean.setBoard_visibility(boardVisibility);
    boardBean.setBoard_answertype(boardAnswerType);
    boardBean.setBoard_image(imagePath); // 이미지 경로 설정 (없을 경우 null로 저장)

    // 게시글 DB에 저장
    boolean isAdded = boardMgr.addBoard(multi); // multi 객체 전달

    // 저장 결과 처리
    if (isAdded) {
        out.println("<script>alert('게시글이 성공적으로 등록되었습니다.'); </script>");
        
      //알람기능
        AlarmBean alarmBean = new AlarmBean();
        BoardWriteMgr bMgr = new BoardWriteMgr();
        int boardNum = bMgr.getLatestBoard().getBoard_num();
        String id = bMgr.getBoard(boardNum).getBoard_id();
        alarmBean.setAlarm_content_num(boardNum);
        alarmBean.setAlarm_type("게시판");
        alarmBean.setAlarm_user_id(id);
        AlarmMgr alarmMgr = new AlarmMgr();
        alarmMgr.insertAlarm(alarmBean);
        
    } else {
        out.println("<script>alert('게시글 등록에 실패했습니다. 다시 시도해주세요.'); history.back();</script>");
    }
%>
