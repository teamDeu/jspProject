<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="pjh.DBConnectionMgr, pjh.MemberBean, java.sql.*" %>

<%
    // 결제 페이지에서 전달된 데이터를 받아 처리
    String cloverAmountStr = request.getParameter("cloverAmount");
    String quantityStr = request.getParameter("quantity");
    String totalPriceStr = request.getParameter("totalPrice");

    // null 값이 전달될 경우 기본값 설정
    if (cloverAmountStr == null || cloverAmountStr.isEmpty()) {
        cloverAmountStr = "0";
    }
    if (quantityStr == null || quantityStr.isEmpty()) {
        quantityStr = "0";
    }
    if (totalPriceStr == null || totalPriceStr.isEmpty()) {
        totalPriceStr = "0";
    }

    // 정수로 변환
    int cloverAmount = Integer.parseInt(cloverAmountStr);
    int quantity = Integer.parseInt(quantityStr);
    int totalPrice = Integer.parseInt(totalPriceStr);

    // 클로버 갯수 총합 계산
    int totalClover = cloverAmount * quantity;

    // 로그인된 사용자 가져오기
    MemberBean member = (MemberBean) session.getAttribute("loggedInUser");

    if (member != null) {
        // 현재 클로버 갯수와 결제된 클로버 합산
        int currentClover = member.getUser_clover();
        member.setUser_clover(currentClover + totalClover);

        // DB에 클로버 수량 업데이트
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBConnectionMgr.getInstance().getConnection();
            String sql = "UPDATE user SET user_clover = ? WHERE user_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, member.getUser_clover());
            pstmt.setString(2, member.getUser_id());
            pstmt.executeUpdate();

            // 결제 성공 페이지로 이동
            response.sendRedirect("pay.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            out.print("ERROR");
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) DBConnectionMgr.getInstance().freeConnection(conn);
        }
    } else {
        out.print("사용자 세션이 만료되었습니다. 다시 로그인 해주세요.");
    }
%>
