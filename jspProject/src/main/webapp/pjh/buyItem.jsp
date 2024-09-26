<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, pjh.DBConnectionMgr"%>
<%
    String user_id = (String) session.getAttribute("idKey");
    int item_num = Integer.parseInt(request.getParameter("item_num"));
    int item_price = Integer.parseInt(request.getParameter("item_price"));

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    DBConnectionMgr pool = DBConnectionMgr.getInstance();
    boolean purchaseSuccess = false;

    try {
        conn = pool.getConnection();
        // 현재 클로버 잔액 가져오기
        String getUserCloverSQL = "SELECT user_clover FROM user WHERE user_id = ?";
        pstmt = conn.prepareStatement(getUserCloverSQL);
        pstmt.setString(1, user_id);
        rs = pstmt.executeQuery();

        int current_clover = 0;
        if (rs.next()) {
            current_clover = rs.getInt("user_clover");
        }

        // 클로버가 충분한지 체크
        if (current_clover >= item_price) {
            // 클로버 차감
            String updateCloverSQL = "UPDATE user SET user_clover = user_clover - ? WHERE user_id = ?";
            pstmt = conn.prepareStatement(updateCloverSQL);
            pstmt.setInt(1, item_price);
            pstmt.setString(2, user_id);
            pstmt.executeUpdate();

            // 구매한 아이템 itemhold 테이블에 저장
            String insertItemSQL = "INSERT INTO itemhold (user_Id, item_num, item_using) VALUES (?, ?, 0)";
            pstmt = conn.prepareStatement(insertItemSQL);
            pstmt.setString(1, user_id);
            pstmt.setInt(2, item_num);
            pstmt.executeUpdate();

            purchaseSuccess = true;
        } else {
            out.print("NOT_ENOUGH_CLOVER");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) pool.freeConnection(conn);
    }

    if (purchaseSuccess) {
        out.print("SUCCESS");
    } else {
        out.print("FAIL");
    }
%>

