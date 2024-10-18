<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="board.BoardWriteBean"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="board.BoardWriteMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="mgr" class="board.BoardWriteMgr" />

<%
    String saveFolder = application.getRealPath("/miniroom/img");

    try {
        // MultipartRequest 객체 생성
        MultipartRequest multi = new MultipartRequest(request, saveFolder, 1024*1024*10, "UTF-8", new DefaultFileRenamePolicy());

        // 수정할 게시글 번호 가져오기
        int boardNum = Integer.parseInt(multi.getParameter("board_num"));
        
        // 게시글 수정에 필요한 정보들 가져오기
        String boardTitle = multi.getParameter("board_title");
        String boardContent = multi.getParameter("board_content");
        String boardImage = multi.getFilesystemName("board_image"); // 새로 업로드된 파일명 가져오기
        
        // 기존 게시글을 DB에서 가져옴
        BoardWriteBean board = mgr.getBoard(boardNum);
        board.setBoard_title(boardTitle);
        board.setBoard_content(boardContent);
        
        // 수정된 날짜를 현재 시간으로 설정
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String currentDate = formatter.format(new Date());
        board.setBoard_updated_at(currentDate);  // 수정된 날짜 설정
        
        // 이미지 파일이 없는 경우 기존 이미지를 유지하도록 수정
        if (boardImage != null && !boardImage.isEmpty()) {
            board.setBoard_image("./img/" + boardImage); // 새 이미지 경로 설정
        } else {
            board.setBoard_image(board.getBoard_image()); // 기존 이미지 유지
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
