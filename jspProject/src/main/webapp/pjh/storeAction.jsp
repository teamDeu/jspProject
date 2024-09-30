<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, pjh.DBConnectionMgr" %>
<%
    // Form에서 넘어온 데이터 받기
    String itemName = request.getParameter("item_name");
    String itemImage = request.getParameter("item_image");
    String itemPriceParam = request.getParameter("item_price");
    int itemPrice = 0;

    try {
        if (itemPriceParam != null && !itemPriceParam.trim().isEmpty()) {
            itemPrice = Integer.parseInt(itemPriceParam);
        } else {
            throw new NumberFormatException("가격 값이 비어있습니다.");
        }
    } catch (NumberFormatException e) {
        out.println("<script>alert('가격 값이 잘못되었습니다. 숫자를 입력해 주세요.'); history.back();</script>");
        return;
    }

    String itemType = request.getParameter("item_type");
    String itemPath = request.getParameter("item_path");

    // 데이터베이스 연결 및 저장 로직
    Connection conn = null;
    PreparedStatement pstmt = null;
    DBConnectionMgr pool = DBConnectionMgr.getInstance();

    try {
        conn = pool.getConnection();
        String sql = "INSERT INTO item_table (item_name, item_image, item_price, item_type, item_path) VALUES (?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, itemName);
        pstmt.setString(3, itemImage);
        pstmt.setInt(2, itemPrice);        
        pstmt.setString(4, itemType);
        pstmt.setString(5, itemPath);

        int result = pstmt.executeUpdate();
        if (result > 0) {
            out.println("<script>alert('상품이 성공적으로 추가되었습니다.'); location.href='adminMain.jsp';</script>");
        } else {
            out.println("<script>alert('상품 추가에 실패했습니다.'); history.back();</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류가 발생했습니다. 관리자에게 문의하세요.'); history.back();</script>");
    } finally {
        pool.freeConnection(conn, pstmt);
    }
%>
