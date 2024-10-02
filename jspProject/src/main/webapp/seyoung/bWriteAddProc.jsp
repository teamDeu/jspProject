<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="board.BoardWriteMgr" %>
<%@ page import="board.BoardWriteBean" %>
<jsp:useBean id="mgr" class="board.BoardWriteMgr" scope="request"/>

<%
	out.clear();
    request.setCharacterEncoding("UTF-8");

    // 세션에서 사용자 ID 가져오기 (로그인된 사용자라 가정)
    String boardId = (String) session.getAttribute("idKey");

    // 폼 데이터 가져오기
    String boardFolderStr = request.getParameter("board_folder");
    String boardTitle = request.getParameter("board_title");
    String boardContent = request.getParameter("board_content_text");
    String boardVisibilityStr = request.getParameter("board_visibility");
    String boardAnswerTypeStr = request.getParameter("board_answertype");

    if (boardTitle == null || boardTitle.trim().isEmpty()) {
        out.println("<script>alert('제목을 입력해주세요.'); history.back();</script>");
        return; // 폼 제출 중단
    }
    
    
    // 폴더 번호 및 기타 데이터 처리
    int boardFolder = (boardFolderStr != null && !boardFolderStr.isEmpty()) ? Integer.parseInt(boardFolderStr) : -1;
    int boardVisibility = (boardVisibilityStr != null && !boardVisibilityStr.isEmpty()) ? Integer.parseInt(boardVisibilityStr) : 0;
    int boardAnswerType = (boardAnswerTypeStr != null && !boardAnswerTypeStr.isEmpty()) ? Integer.parseInt(boardAnswerTypeStr) : 0;

    // 이미지 업로드 처리
    Part imageFilePart = request.getPart("image_file");
    String uploadPath = getServletContext().getRealPath("/") + "img"; // 파일 업로드 경로 설정
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) {
        uploadDir.mkdirs(); // 디렉토리가 없으면 생성
    }

    String imagePath = null; // 이미지 파일이 없을 경우 null로 처리
    if (imageFilePart != null && imageFilePart.getSize() > 0) {
        String fileName = imageFilePart.getSubmittedFileName();
        if (fileName != null && !fileName.isEmpty()) {
            imagePath = "uploads/" + fileName;
            imageFilePart.write(uploadPath + File.separator + fileName); // 파일 저장
        }
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
    boolean isAdded = boardMgr.addBoard(boardBean);

    // 저장 결과 처리
    if (isAdded) {
        out.println("<script>alert('게시글이 성공적으로 등록되었습니다.'); location.href='boardList.jsp';</script>");
    } else {
        out.println("<script>alert('게시글 등록에 실패했습니다. 다시 시도해주세요.'); history.back();</script>");
    }
%>
