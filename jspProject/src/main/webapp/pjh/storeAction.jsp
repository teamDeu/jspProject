<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" autoFlush="true" %>
<%@ page import="java.sql.*, pjh.DBConnectionMgr" %>
<%@ page import="java.io.File, java.nio.file.Files, java.nio.file.StandardCopyOption" %>
<html>
<body>
<%
    // 파일 저장 경로 설정
    String uploadRoot = application.getRealPath("/uploads");
    String imgPath = application.getRealPath("/img");
    String pathFolder = application.getRealPath("/path");

    int maxSize = 1024 * 1024 * 10;  // 10MB 제한

    // 디렉토리 존재 여부 확인 및 생성
    File uploadDir = new File(uploadRoot);
    File imgDir = new File(imgPath);
    File pathDir = new File(pathFolder);

    if (!uploadDir.exists()) uploadDir.mkdirs();
    if (!imgDir.exists()) imgDir.mkdirs();
    if (!pathDir.exists()) pathDir.mkdirs();

    String itemName = null;
    String itemImage = null;
    String itemPath = null;
    int itemPrice = 0;
    String itemType = null;

    try {
        // 파일 업로드 처리
        MultipartRequest multi = new MultipartRequest(request, uploadRoot, maxSize, "UTF-8");

        itemName = multi.getParameter("item_name");
        itemImage = multi.getFilesystemName("item_image");
        itemPrice = Integer.parseInt(multi.getParameter("item_price"));
        itemType = multi.getParameter("item_type");
        itemPath = multi.getFilesystemName("item_path");

        if (itemImage == null || itemPath == null) {
            throw new Exception("파일 업로드 실패");
        }

        // 파일 복사 작업 (item_image -> img 폴더, item_path -> path 폴더)
        File sourceImage = new File(uploadRoot, itemImage);
        File destinationImage = new File(imgDir, itemImage);
        Files.copy(sourceImage.toPath(), destinationImage.toPath(), StandardCopyOption.REPLACE_EXISTING);

        File sourcePath = new File(uploadRoot, itemPath);
        File destinationPath = new File(pathDir, itemPath);
        Files.copy(sourcePath.toPath(), destinationPath.toPath(), StandardCopyOption.REPLACE_EXISTING);

        out.println("파일 업로드 및 복사 성공<br>");

    } catch (Exception e) {
        e.printStackTrace();
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
        pstmt.setString(2, "./img/" + itemImage);  // img 폴더에 저장된 경로
        pstmt.setInt(3, itemPrice);
        pstmt.setString(4, itemType);
        pstmt.setString(5, "./path/" + itemPath);  // path 폴더에 저장된 경로

        int result = pstmt.executeUpdate();

        if (result > 0) {
            out.println("<script>alert('상품이 성공적으로 추가되었습니다.'); window.opener.location.reload(); window.close();</script>");
        } else {
            out.println("<script>alert('상품 추가에 실패했습니다.'); history.back();</script>");
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
