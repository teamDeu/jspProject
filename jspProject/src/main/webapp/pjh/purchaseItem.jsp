<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, pjh.DBConnectionMgr"%>
<%
String userId = (String) session.getAttribute("idKey");
String itemName = request.getParameter("itemName");
String itemPriceStr = request.getParameter("itemPrice");
String itemNumStr = request.getParameter("itemNum");

int itemPrice = 0;
int itemNum = 0;

try {
    // itemPrice와 itemNum이 null이 아닌지 확인
    if (itemPriceStr != null && !itemPriceStr.isEmpty()) {
        itemPrice = Integer.parseInt(itemPriceStr);
    } else {
        throw new NumberFormatException("itemPrice 파라미터가 잘못되었습니다.");
    }

    if (itemNumStr != null && !itemNumStr.isEmpty()) {
        itemNum = Integer.parseInt(itemNumStr);
    } else {
        throw new NumberFormatException("itemNum 파라미터가 잘못되었습니다.");
    }

    DBConnectionMgr pool = DBConnectionMgr.getInstance();
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    int userClover = 0;

    try {
        conn = pool.getConnection();
        
        if (conn == null) {
            throw new SQLException("DB 연결 실패");
        }

        // 1. 유저의 현재 클로버 잔액 가져오기
        String sql = "SELECT user_clover FROM user WHERE user_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userId);
        rs = pstmt.executeQuery();
        
        if (!rs.next()) {
            throw new SQLException("유저 데이터를 찾을 수 없습니다. user_id: " + userId);
        }
        
        userClover = rs.getInt("user_clover");

        // 2. 클로버 잔액이 충분한지 확인
        if (userClover >= itemPrice) {
            // 3. 클로버 잔액 차감
            sql = "UPDATE user SET user_clover = user_clover - ? WHERE user_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, itemPrice);
            pstmt.setString(2, userId);
            pstmt.executeUpdate();
            
            // 4. 구매한 상품을 itemhold 테이블에 저장
            sql = "INSERT INTO itemhold (user_Id, item_num, item_using) VALUES (?, ?, 0)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            pstmt.setInt(2, itemNum);
            pstmt.executeUpdate();
            
            // 성공 메시지와 남은 클로버 반환
            out.print(userClover - itemPrice);
        } else {
            out.print("잔액이 부족합니다.");
        }
    } catch (SQLException e) {
        e.printStackTrace();  // 자세한 오류 메시지 출력
        out.print("서버 오류가 발생했습니다: " + e.getMessage());
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) pool.freeConnection(conn);
    }

} catch (NumberFormatException e) {
    // 파라미터가 잘못된 경우 처리
    out.print("잘못된 파라미터가 전달되었습니다: " + e.getMessage());
    e.printStackTrace();
}
%>
