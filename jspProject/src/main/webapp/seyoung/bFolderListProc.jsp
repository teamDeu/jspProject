<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="board.BoardFolderBean"%>
<%@ page import="board.BoardFolderMgr"%>

<%
    // 클라이언트에서 전달된 user_id 파라미터를 가져옴
    String user_id = request.getParameter("user_id");

    try {
        // user_id가 null이 아니고 비어있지 않을 때만 처리
        if (user_id != null && !user_id.trim().isEmpty()) {
            BoardFolderMgr folderMgr = new BoardFolderMgr(); // BoardFolderMgr 인스턴스 생성
            
            // user_id에 해당하는 폴더 목록 가져오기
            Vector<BoardFolderBean> folderList = folderMgr.getFolderList(user_id);

            if (folderList != null && !folderList.isEmpty()) {
                // 폴더 목록을 JSON 형식으로 변환하여 반환
                StringBuilder json = new StringBuilder("[");
                for (int i = 0; i < folderList.size(); i++) {
                    BoardFolderBean folder = folderList.get(i);
                    
                    // 폴더명에 특수 문자가 포함된 경우 안전하게 인코딩
                    String folderName = folder.getFolder_name().replace("\"", "\\\"");

                    json.append("{")
                        .append("\"folder_num\":").append(folder.getFolder_num()).append(",")
                        .append("\"folder_name\":\"").append(folderName).append("\"")
                        .append("}");
                    
                    if (i < folderList.size() - 1) {
                        json.append(","); // 마지막 요소 뒤에는 쉼표를 추가하지 않음
                    }
                }
                json.append("]");
                out.print(json.toString()); // JSON 문자열을 출력
            } else {
                // 폴더 목록이 없을 때 빈 배열 반환
                out.print("[]");
                System.out.println("폴더 목록이 없습니다."); // 디버그 메시지 출력
            }
        } else {
            // user_id가 없거나 유효하지 않을 때 빈 배열 반환
            out.print("[]");
            System.out.println("유효하지 않은 user_id 입니다: " + user_id); // 디버그 메시지 출력
        }
    } catch (Exception e) {
        e.printStackTrace(); // 예외 발생 시 콘솔에 출력
        // 예외가 발생한 경우에도 클라이언트에 빈 배열을 반환
        out.print("[]");
        System.out.println("폴더 목록을 불러오는 중 오류가 발생했습니다."); // 디버그 메시지 출력
    }
%>

