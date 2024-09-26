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
    boolean cloverDeducted = false;

    try {
        conn = pool.getConnection();

        // 1. 이미 해당 아이템을 구매했는지 확인
        String checkAlreadyPurchasedSQL = "SELECT COUNT(*) FROM itemhold WHERE user_id = ? AND item_num = ?";
        pstmt = conn.prepareStatement(checkAlreadyPurchasedSQL);
        pstmt.setString(1, user_id);
        pstmt.setInt(2, item_num);
        rs = pstmt.executeQuery();

        int purchaseCount = 0;
        if (rs.next()) {
            purchaseCount = rs.getInt(1);
        }
        rs.close();
        pstmt.close();

        // 이미 구매한 경우 처리
        if (purchaseCount > 0) {
            out.print("ALREADY_PURCHASED");
        } else {
            // 2. 현재 클로버 잔액 가져오기
            String getUserCloverSQL = "SELECT user_clover FROM user WHERE user_id = ?";
            pstmt = conn.prepareStatement(getUserCloverSQL);
            pstmt.setString(1, user_id);
            rs = pstmt.executeQuery();

            int current_clover = 0;
            if (rs.next()) {
                current_clover = rs.getInt("user_clover");
            }
            rs.close();
            pstmt.close();

            // 3. 클로버가 충분한지 체크
            if (current_clover >= item_price) {
                // 4. 구매한 아이템을 itemhold 테이블에 저장
                String insertItemSQL = "INSERT INTO itemhold (user_Id, item_num, item_using) VALUES (?, ?, 0)";
                pstmt = conn.prepareStatement(insertItemSQL);
                pstmt.setString(1, user_id);
                pstmt.setInt(2, item_num);
                pstmt.executeUpdate();
                pstmt.close();

                purchaseSuccess = true;

                // 5. 아이템 구매 성공 후 클로버 차감
                String updateCloverSQL = "UPDATE user SET user_clover = user_clover - ? WHERE user_id = ?";
                pstmt = conn.prepareStatement(updateCloverSQL);
                pstmt.setInt(1, item_price);
                pstmt.setString(2, user_id);
                pstmt.executeUpdate();
                pstmt.close();
                
                cloverDeducted = true;
            } else {
                out.print("NOT_ENOUGH_CLOVER");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) pool.freeConnection(conn);
    }

    // 구매 성공 또는 실패에 따른 처리
    if (purchaseSuccess && cloverDeducted) {
        out.print("SUCCESS");
    } else if (!purchaseSuccess) { // 단순히 구매가 실패한 경우
        out.print("FAIL");
    }
%>
