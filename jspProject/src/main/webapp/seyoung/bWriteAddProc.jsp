
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardWriteMgr" %>
<%@ page import="board.BoardWriteBean" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Collection" %>
<%@ page import="javax.servlet.http.Part" %>
<jsp:useBean id="mgr" class="board.BoardWriteMgr"/>

<%
	//multipart/form-data 요청 처리 설정
	if (request.getContentType() != null && request.getContentType().toLowerCase().startsWith("multipart/")) {
	
	    // 세션에서 사용자 ID 가져오기
	    String boardId = (String)session.getAttribute("idKey");
	
	    // multipart/form-data의 Part를 사용하여 데이터를 가져오기
	    Collection<Part> parts = request.getParts();
	
	    String boardFolderStr = null;
	    String boardTitle = null;
	    String boardContent = null;
	    String boardVisibilityStr = null;
	    String boardAnswerTypeStr = null;
	    Part imageFilePart = null;
	
	    // 각 파트에서 폼 필드와 파일을 처리
	    for (Part part : parts) {
	        String partName = part.getName();
	        if (partName.equals("board_folder")) {
	            boardFolderStr = request.getParameter(partName);
	        } else if (partName.equals("board_title")) {
	            boardTitle = request.getParameter(partName);
	        } else if (partName.equals("board_content_text")) { // contenteditable에서 작성한 내용을 받기 위함
	            boardContent = request.getParameter(partName);
	        } else if (partName.equals("board_visibility")) {
	            boardVisibilityStr = request.getParameter(partName);
	        } else if (partName.equals("board_answertype")) {
	            boardAnswerTypeStr = request.getParameter(partName);
	        } else if (partName.equals("image_file")) {
	            imageFilePart = part;
	        }
	    }
	
	    // 폴더 번호 및 공개 설정과 댓글 허용 여부는 정수로 변환
	    int boardFolder = (boardFolderStr != null && !boardFolderStr.isEmpty()) ? Integer.parseInt(boardFolderStr) : -1;
	    int boardVisibility = (boardVisibilityStr != null && !boardVisibilityStr.isEmpty()) ? Integer.parseInt(boardVisibilityStr) : 0;
	    int boardAnswerType = (boardAnswerTypeStr != null && !boardAnswerTypeStr.isEmpty()) ? Integer.parseInt(boardAnswerTypeStr) : 0;
	
	    // 이미지 업로드 처리
	    String uploadPath = getServletContext().getRealPath("/") + "uploads"; // 실제 저장 경로 설정
	    File uploadDir = new File(uploadPath);
	    if (!uploadDir.exists()) {
	        uploadDir.mkdirs(); // 경로가 없으면 생성
	    }
	
	    String imagePath = null;
	    if (imageFilePart != null && imageFilePart.getSize() > 0) {
	        String fileName = imageFilePart.getSubmittedFileName();
	        imagePath = "uploads/" + fileName;
	        imageFilePart.write(uploadPath + File.separator + fileName); // 이미지 파일을 해당 경로에 저장
	    }
	
	    BoardWriteMgr boardMgr = new BoardWriteMgr();
	    BoardWriteBean boardBean = new BoardWriteBean();
	
	    // BoardWriteBean 객체에 값 설정
	    boardBean.setBoard_id(boardId);
	    boardBean.setBoard_folder(boardFolder);
	    boardBean.setBoard_title(boardTitle);
	    boardBean.setBoard_content(boardContent);
	    boardBean.setBoard_visibility(boardVisibility);
	    boardBean.setBoard_answertype(boardAnswerType);
	    boardBean.setBoard_image(imagePath);
	
	    // 게시글 DB에 저장
	    boolean isAdded = boardMgr.addBoard(boardBean);
	
	    // 저장 결과에 따른 처리
	    if (isAdded) {
	        out.println("<script>alert('게시글이 성공적으로 등록되었습니다.'); location.href='boardList.jsp';</script>");
	    } else {
	        out.println("<script>alert('게시글 등록에 실패했습니다. 다시 시도해주세요.'); history.back();</script>");
	    }
	
	} else {
	    out.println("<script>alert('잘못된 요청입니다.'); history.back();</script>");
	}
	

    /* // 폼에서 전송된 데이터 가져오기
    
    String boardId = (String)session.getAttribute("idKey");
    String boardFolderStr = request.getParameter("board_folder");
    String boardTitle = request.getParameter("board_title");
    String boardContent = request.getParameter("board_content");
    String boardVisibilityStr = request.getParameter("board_visibility");
    String boardAnswerTypeStr = request.getParameter("board_answertype");
	
    System.out.println("boardTitle" + boardTitle);
    // 폴더 번호 및 공개 설정과 댓글 허용 여부는 정수로 변환
    int boardFolder = (boardFolderStr != null && !boardFolderStr.isEmpty()) ? Integer.parseInt(boardFolderStr) : -1;
    int boardVisibility = (boardVisibilityStr != null && !boardVisibilityStr.isEmpty()) ? Integer.parseInt(boardVisibilityStr) : 0;
    int boardAnswerType = (boardAnswerTypeStr != null && !boardAnswerTypeStr.isEmpty()) ? Integer.parseInt(boardAnswerTypeStr) : 0;

    // 이미지 업로드 처리
    Part imageFilePart = request.getPart("image_file");
    String uploadPath = getServletContext().getRealPath("/") + "uploads"; // 실제 저장 경로 설정
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) {
        uploadDir.mkdirs(); // 경로가 없으면 생성
    }

    String imagePath = null;
    if (imageFilePart != null && imageFilePart.getSize() > 0) {
        String fileName = imageFilePart.getSubmittedFileName();
        imagePath = "uploads/" + fileName;
        imageFilePart.write(uploadPath + File.separator + fileName); // 이미지 파일을 해당 경로에 저장
    }

    
    BoardWriteMgr boardMgr = new BoardWriteMgr();
    BoardWriteBean boardBean = new BoardWriteBean();
    
    // BoardWriteBean 객체에 값 설정
    boardBean.setBoard_id(boardId);
    boardBean.setBoard_folder(boardFolder);
    boardBean.setBoard_title(boardTitle);
    boardBean.setBoard_content(boardContent);
    boardBean.setBoard_visibility(boardVisibility);
    boardBean.setBoard_answertype(boardAnswerType);
    boardBean.setBoard_image(imagePath);

    // 게시글 DB에 저장
    boolean isAdded = boardMgr.addBoard(boardBean);

    // 저장 결과에 따른 처리
    if (isAdded) {
        out.println("<script>alert('게시글이 성공적으로 등록되었습니다.'); location.href='boardList.jsp';</script>");
    } else {
        out.println("<script>alert('게시글 등록에 실패했습니다. 다시 시도해주세요.'); history.back();</script>");
    } */
%>

