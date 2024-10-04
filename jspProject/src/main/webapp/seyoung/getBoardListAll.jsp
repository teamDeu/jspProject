<%@page import="board.BoardWriteMgr"%>
<%@page import="board.BoardWriteBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="board.BoardWriteMgr" />

<%

	String board_id = request.getParameter("board_id");
	String UserId = (String) session.getAttribute("idKey"); // 현재 로그인한 사용자 ID

    // 모든 게시글을 불러오기
    Vector<BoardWriteBean> boardListAll = mgr.getBoardListByUser(UserId); 
%>

<% 
    if (boardListAll.size() > 0) {
        for (BoardWriteBean board : boardListAll) { 
%>
        <tr>
            <td><input type="checkbox" name="boardNum" value="<%= board.getBoard_num() %>"></td>
            <td><a href="boardDetail.jsp?board_num=<%= board.getBoard_num() %>"><%= board.getBoard_title() %></a></td>
            <td><%= board.getBoard_id() %></td>
            <td><%= board.getBoard_at() %></td>
            <td><%= board.getBoard_views() %></td>
        </tr>
<% 
        }
    } else { 
%>
    <tr>
            <td colspan="5" style="text-align: center;">등록된 게시물이 없습니다.</td>
    </tr>
<% } %>