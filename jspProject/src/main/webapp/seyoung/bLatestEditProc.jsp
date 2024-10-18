<%@ page import="board.BoardWriteBean"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="board.BoardWriteMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="mgr" class="board.BoardWriteMgr" />

<%
    String saveFolder = application.getRealPath("/img");
    int maxSize = 10 * 1024 * 1024; // 최대 10MB 파일 허용
    String encType = "UTF-8";
    MultipartRequest multi = null;

    try {
        // MultipartRequest 객체 생성
        multi = new MultipartRequest(request, saveFolder, maxSize, encType, new DefaultFileRenamePolicy());

        // 수정할 게시글 번호 가져오기
        int boardNum = Integer.parseInt(multi.getParameter("board_num"));
        
        // 게시글 수정에 필요한 정보들 가져오기
        String boardTitle = multi.getParameter("board_title");
        String boardContent = multi.getParameter("board_content");
        String boardImage = multi.getFilesystemName("board_image"); // 파일명 가져오기
        
        // 해당 게시글을 DB에서 가져옴
        BoardWriteBean board = mgr.getBoard(boardNum);
        board.setBoard_title(boardTitle);
        board.setBoard_content(boardContent);
        
        // 이미지 파일이 있을 경우 수정
        if (boardImage != null && !boardImage.isEmpty()) {
            board.setBoard_image("./img/" + boardImage); // 이미지 경로 설정
        }

        // 게시글 업데이트 처리
        boolean result = mgr.updateBoard(board, multi);
        
        if (result) {
            out.print("success");
        } else {
            out.print("fail");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.print("error");
    }
%>
