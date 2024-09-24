<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="pjh.DBConnectionMgr, java.sql.*" %>
<%
    String email = request.getParameter("email");
    String cloverAmountStr = request.getParameter("cloverAmount");
    int cloverAmount = Integer.parseInt(cloverAmountStr); // 충전할 클로버 양

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        DBConnectionMgr dbMgr = DBConnectionMgr.getInstance();
        conn = dbMgr.getConnection();

        // 사용자의 현재 클로버 수 조회
        String selectSql = "SELECT user_clover FROM members WHERE user_email = ?";
        pstmt = conn.prepareStatement(selectSql);
        pstmt.setString(1, email);
        rs = pstmt.executeQuery();

        int currentClover = 0;
        if (rs.next()) {
            currentClover = rs.getInt("user_clover");
        }

        // 클로버 수 업데이트
        int newClover = currentClover + cloverAmount;
        String updateSql = "UPDATE members SET user_clover = ? WHERE user_email = ?";
        pstmt = conn.prepareStatement(updateSql);
        pstmt.setInt(1, newClover);
        pstmt.setString(2, email);
        pstmt.executeUpdate();

        // DB 업데이트 성공 시 'SUCCESS' 응답 전송
        out.print("SUCCESS");

    } catch (Exception e) {
        e.printStackTrace();
        out.print("ERROR");
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
