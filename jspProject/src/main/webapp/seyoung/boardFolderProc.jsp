<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<jsp:useBean id="mgr" class ="board.BoardFolderMgr"/>
<jsp:useBean id="bean" class ="board.BoardFolderBean"/>    

<%
    // 폴더 추가 결과를 나타내는 변수 초기화
    String result = "error"; // 기본 결과 값 설정

    try {
        // 클라이언트에서 전달된 폴더명과 사용자 ID를 파라미터로 받음
        String userId = request.getParameter("user_id");
        String folderName = request.getParameter("folder_name");

        // 파라미터가 유효한지 확인
        if (userId != null && folderName != null && !userId.trim().isEmpty() && !folderName.trim().isEmpty()) {
            // BoardFolderBean 객체에 폴더 정보 설정
            bean.setUser_id(userId);
            bean.setFolder_name(folderName);

            // 폴더 추가 메서드 호출
            if (mgr.addFolder(bean)) { // addFolder 메서드에 bean 객체 전달
                result = "success";
            } else {
                result = "failure";
            }
        } else {
            result = "invalid";
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // 결과를 클라이언트에 반환
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        out.print(result); // 결과 출력
    }
%>