<%@page import="pjh.DBConnectionMgr"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="pjh.MemberBean" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement" %>
<%
    String cloverAmountStr = request.getParameter("cloverAmount");
    String quantityStr = request.getParameter("quantity");
    int cloverAmount = Integer.parseInt(cloverAmountStr); // 선택한 클로버 갯수
    int quantity = Integer.parseInt(quantityStr); // 선택한 수량

    // 클로버 갯수 총합
    int totalClover = cloverAmount * quantity;

    // 현재 사용자의 MemberBean 가져오기 (로그인된 사용자를 가정)
    MemberBean member = (MemberBean)session.getAttribute("loggedInUser");  // 세션에서 가져오는 코드

    if (member != null) {
        // 현재 클로버와 결제된 클로버 합산
        int currentClover = member.getUser_clover();
        member.setUser_clover(currentClover + totalClover); // 클로버 업데이트

        // DB에 클로버 업데이트
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBConnectionMgr.getInstance().getConnection();
            String sql = "UPDATE users SET user_clover = ? WHERE user_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, member.getUser_clover());
            pstmt.setString(2, member.getUser_id());
            pstmt.executeUpdate();

            // 성공 메시지 전송
            out.print("클로버 충전이 완료되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            out.print("결제 처리 중 오류가 발생했습니다.");
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) DBConnectionMgr.getInstance().freeConnection(conn);
        }
    } else {
        out.print("사용자 세션이 만료되었습니다. 다시 로그인 해주세요.");
    }
%>
