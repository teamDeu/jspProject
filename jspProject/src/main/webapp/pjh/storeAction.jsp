<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" autoFlush="true" %>
<%@ page import="java.sql.*, pjh.DBConnectionMgr" %>
<%@ page import="java.io.File" %>
<html>
<body>
<%
    String savePath = application.getRealPath("/uploads");
    int maxSize = 1024 * 1024 * 10;  // 10MB 제한

    // 디렉토리 존재 여부 확인 및 생성
    File uploadDir = new File(savePath);
    if (!uploadDir.exists()) {
        boolean dirCreated = uploadDir.mkdirs();
        if (!dirCreated) {
            out.println("<script>alert('업로드 디렉토리 생성에 실패했습니다. 관리자에게 문의하세요.'); history.back();</script>");
            return;
        }
    }

    String itemName = null;
    String itemImage = null;
    int itemPrice = 0;
    String itemType = null;
    String itemPath = null;

    try {
        MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "UTF-8");

        itemName = multi.getParameter("item_name");
        itemImage = multi.getFilesystemName("item_image");
        itemPrice = Integer.parseInt(multi.getParameter("item_price"));
        itemType = multi.getParameter("item_type");
        itemPath = multi.getFilesystemName("item_path");

        if (itemImage == null || itemPath == null) {
            throw new Exception("파일 업로드 실패");
        }

    } catch (Exception e) {
        e.printStackTrace();  // 콘솔에 출력
        out.println("<script>alert('데이터 처리 중 오류가 발생했습니다: " + e.getMessage() + "'); history.back();</script>");
        return;
    }

    // 데이터베이스 연결 및 저장
    Connection conn = null;
    PreparedStatement pstmt = null;
    DBConnectionMgr pool = DBConnectionMgr.getInstance();

    try {
        conn = pool.getConnection();

        String sql = "INSERT INTO item (item_name, item_image, item_price, item_type, item_path) VALUES (?, ?, ?, ?, ?)";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, itemName);
        pstmt.setString(2, "/uploads/" + itemImage);
        pstmt.setInt(3, itemPrice);
        pstmt.setString(4, itemType);
        pstmt.setString(5, "/uploads/" + itemPath);

        int result = pstmt.executeUpdate();

        if (result > 0) {
            // 성공적으로 추가된 경우, 창을 닫고 부모 창을 새로고침
            out.println("<script>");
            out.println("alert('상품이 성공적으로 추가되었습니다.');");
            out.println("window.opener.location.reload();");  // 부모 창 새로고침
            out.println("window.close();");  // 현재 창 닫기
            out.println("</script>");
        } else {
            out.println("<script>alert('상품 추가에 실패했습니다.'); history.back();</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();  // 콘솔에 출력
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
