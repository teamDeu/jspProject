
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.BoardWriteMgr"%>
<%@ page import="board.BoardWriteBean"%>
<%@ page import="java.util.Vector"%>
<html>
<head>
	<script>
	
	</script>
</head>


<%
    
    String folderName = request.getParameter("folderName"); // 폴더 이름 받기
    System.out.println("getBoardList 폴더 이름: " + folderName);
    
    int folderNum = 0;
    try {
        folderNum = Integer.parseInt(request.getParameter("folderNum"));
    } catch (NumberFormatException e) {
        folderNum = 0;
    }

    if (folderNum > 0) {
        BoardWriteMgr boardMgr = new BoardWriteMgr();
        Vector<BoardWriteBean> boardList = boardMgr.getBoardList(folderNum);

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

                <tr>
                
                    <td><input type="checkbox" name="boardNum" value="<%= board.getBoard_num() %>"></td>
                    <td>
                        <button onclick="clickBoard_boardNum('<%= board.getBoard_num() %>')"><%= board.getBoard_title() %></button>
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
</html>