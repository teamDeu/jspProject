<%@ page import="java.sql.*, pjh.DBConnectionMgr" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<body>
<%
    int item_num = Integer.parseInt(request.getParameter("item_num"));
    Connection conn = null;
    PreparedStatement pstmt = null;
    DBConnectionMgr pool = DBConnectionMgr.getInstance();

    try {
        conn = pool.getConnection();
        String sql = "DELETE FROM item WHERE item_num = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, item_num);
        int result = pstmt.executeUpdate();

        if (result > 0) {	
            // 성공적으로 삭제되었을 경우 알림을 띄우고, 상점 관리 페이지로 리다이렉트
            out.println("<script>alert('상품이 성공적으로 삭제되었습니다.'); location.href='adminMain.jsp';</script>");
        } else {
            out.println("<script>alert('상품 삭제에 실패했습니다.'); history.back();</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류가 발생했습니다. 관리자에게 문의하세요.'); history.back();</script>");
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) pool.freeConnection(conn);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
</body>
</html>
