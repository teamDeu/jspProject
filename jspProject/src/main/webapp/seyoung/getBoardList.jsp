
<%@page import="miniroom.UtilMgr"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.BoardWriteMgr"%>
<%@ page import="board.BoardWriteBean"%>
<%@ page import="java.util.Vector"%>
<html>



<%
    
    int currentPage = 1; // 기본값은 1페이지
    if(request.getParameter("page") == null){
    	
    }
    else{
    	currentPage = UtilMgr.parseInt(request, "page");
    }
    int folderNum = 0;
    if(request.getParameter("folderNum") != null){
    	folderNum = UtilMgr.parseInt(request, "folderNum");
    }
    
    int entriesPerPage = 12; // 한 페이지당 12개의 게시글
    String pageParam = request.getParameter("page");
    if (pageParam != null && !pageParam.isEmpty()) {
        try {
            currentPage = Integer.parseInt(pageParam);
        } catch (NumberFormatException e) {
            currentPage = 1; // 페이지 번호가 잘못된 경우 기본값으로 설정
        }
    }
	System.out.println("folderNum = " + folderNum);
    int startIndex = (currentPage - 1) * entriesPerPage;
    
    BoardWriteMgr boardMgr = new BoardWriteMgr();
    int totalPages = boardMgr.getTotalPagesByFolder(folderNum, entriesPerPage); // 총 페이지 수 계산

    if (folderNum > 0) {
        
        Vector<BoardWriteBean> boardList = boardMgr.getBoardList(folderNum, startIndex, entriesPerPage);

        if (boardList != null && boardList.size() > 0) {
            for (BoardWriteBean board : boardList) {
                String formattedDate = "";
                try {
                    Timestamp timestamp = Timestamp.valueOf(board.getBoard_at());
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    formattedDate = sdf.format(timestamp);
                } catch (Exception e) {
                    formattedDate = board.getBoard_at();
                }
%>

                <tr class ="boardlist_item">
                    <td><input type="checkbox" name="boardNum" value="<%= board.getBoard_num() %>"></td>
                    <td>
                        <span onclick="clickBoard_boardNum('<%= board.getBoard_num() %>')"><%= board.getBoard_title() %></span>
                    </td>
                    <td><%= board.getBoard_id() %></td>
                    <td><%= formattedDate %></td>
                    <td><%= board.getBoard_views() %></td>
                </tr>
<%
            }
        } else {
%>
        <tr>
            <td colspan="5" style="text-align: center;">등록된 게시물이 없습니다.</td>
        </tr>
<%
        }
    } else {
%>
    <tr>
        <td colspan="5" style="text-align: center;">유효한 폴더를 선택하세요.</td>
    </tr>
<%
    }
%>
<input type ="hidden" id = "boardList_totalPages" name ="boardList_totalPages" value =<%=totalPages %>>
</html>

<script>

</script>