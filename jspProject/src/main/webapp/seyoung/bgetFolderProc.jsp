<%@ page import="board.BoardFolderMgr" %>
<%@ page import="board.BoardFolderBean" %>
<%@ page contentType="application/json; charset=UTF-8" %>
<%
    String folderNumStr = request.getParameter("folderNum");
    int folderNum = -1;
    try {
        folderNum = Integer.parseInt(folderNumStr);
    } catch (NumberFormatException e) {
        folderNum = -1;
    }

    if (folderNum == -1) {
        out.print("{\"error\": \"Invalid folder number\"}");
        return;
    }

    BoardFolderMgr mgr = new BoardFolderMgr();
    BoardFolderBean folderInfo = mgr.getFolderInfo(folderNum);

    if (folderInfo != null) {
        // 폴더 정보 JSON 형식으로 출력
        out.println("{");
        out.println("\"folder_num\": " + folderInfo.getFolder_num() + ",");
        out.println("\"user_id\": \"" + folderInfo.getUser_id() + "\",");
        out.println("\"folder_name\": \"" + folderInfo.getFolder_name() + "\"");
        out.println("}");
    } else {
        // 폴더 정보가 없을 때
        out.println("{\"error\": \"Folder not found\"}");
    }
%>

