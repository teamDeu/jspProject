<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="board.BoardFolderBean"%>
<%@page import="board.BoardFolderMgr"%>  
<jsp:useBean id="mgr" class ="board.BoardFolderMgr"/>
<jsp:useBean id="bean" class ="board.BoardFolderBean"/>      

<%
    // 클라이언트에서 전달된 폴더 번호를 파라미터로 받음
    String folderNumStr = request.getParameter("folderNum");
    int folderNum = 0;

    if (folderNumStr != null && !folderNumStr.trim().isEmpty()) {
        try {
            folderNum = Integer.parseInt(folderNumStr);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }

    // 결과 메시지를 저장할 변수
    String result = "error";

    // 폴더 번호가 유효할 때만 삭제 작업 수행
    if (folderNum > 0) {
        BoardFolderMgr folderMgr = new BoardFolderMgr();
        if (folderMgr.deleteFolder(folderNum)) {
            result = "success";
        } else {
            result = "fail";
        }
    } else {
        result = "invalid";
    }

    // 클라이언트에 결과 반환
    response.setContentType("text/plain");
    PrintWriter outt = response.getWriter();
    outt.print(result);
    outt.close();
%>