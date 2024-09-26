<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, pjh.DBConnectionMgr" %>

<%
String user_id = (String) session.getAttribute("idKey");
int item_num = Integer.parseInt(request.getParameter("item_num"));
int item_price = Integer.parseInt(request.getParameter("item_price"));

DBConnectionMgr pool = DBConnectionMgr.getInstance();
Connection conn = null;
PreparedStatement pstmt = null;

try {
    // DB 연결
    conn = pool.getConnection();

    // 클로버 환불: 해당 아이템의 가격만큼 클로버 추가
    String updateCloverSQL = "UPDATE user SET user_clover = user_clover + ? WHERE user_id = ?";
    pstmt = conn.prepareStatement(updateCloverSQL);
    pstmt.setInt(1, item_price);
    pstmt.setString(2, user_id);
    pstmt.executeUpdate();
    pstmt.close();

    // itemhold에서 아이템 삭제
    String deleteItemSQL = "DELETE FROM itemhold WHERE user_Id = ? AND item_num = ?";
    pstmt = conn.prepareStatement(deleteItemSQL);
    pstmt.setString(1, user_id);
    pstmt.setInt(2, item_num);
    pstmt.executeUpdate();
    pstmt.close();

    out.print("SUCCESS");
} catch (Exception e) {
    e.printStackTrace();
    out.print("ERROR");
} finally {
    try {
        if (pstmt != null) pstmt.close();
        if (conn != null) pool.freeConnection(conn);
    } catch (SQLException e) {
        e.printStackTrace();  // 예외 발생 시 로그로 출력하여 문제 파악
    }
}
%>
