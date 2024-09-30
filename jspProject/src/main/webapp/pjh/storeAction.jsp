<%@ page import="com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" autoFlush="true" %>
<%@ page import="java.sql.*, pjh.DBConnectionMgr" %>
<%@ page import="java.io.File, java.nio.file.Files, java.nio.file.StandardCopyOption" %>
<html>
<body>
<%
    // 파일 저장 경로 설정 - miniroom 안의 img 및 path 폴더
    String SAVEFOLDER = application.getRealPath("./miniroom");
    String imgFolder = SAVEFOLDER + "/img";
    String pathFolder = SAVEFOLDER + "/path";
    int MAXSIZE = 1024 * 1024 * 50; // 50MB 제한
    String ENCODING = "UTF-8";

    // 디렉토리 존재 여부 확인 및 생성
    File imgDir = new File(imgFolder);
    File pathDir = new File(pathFolder);

    if (!imgDir.exists()) imgDir.mkdirs();
    if (!pathDir.exists()) pathDir.mkdirs();

    Connection conn = null;
    PreparedStatement pstmt = null;
    DBConnectionMgr pool = DBConnectionMgr.getInstance();
    boolean flag = false;

    try {
        // 파일 업로드 처리
        MultipartRequest multi = new MultipartRequest(request, SAVEFOLDER, MAXSIZE, ENCODING, new DefaultFileRenamePolicy());

        String itemName = multi.getParameter("item_name");
        int itemPrice = Integer.parseInt(multi.getParameter("item_price"));
        String itemType = multi.getParameter("item_type");

        String itemImage = multi.getFilesystemName("item_image");
        String itemPath = multi.getFilesystemName("item_path");

        // 이미지 파일을 imgFolder에 저장
        if (itemImage != null) {
            File sourceImage = new File(SAVEFOLDER, itemImage);
            File destinationImage = new File(imgFolder, itemImage);
            Files.move(sourceImage.toPath(), destinationImage.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }

        // 경로 파일을 pathFolder에 저장
        if (itemPath != null) {
            File sourcePath = new File(SAVEFOLDER, itemPath);
            File destinationPath = new File(pathFolder, itemPath);
            Files.move(sourcePath.toPath(), destinationPath.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }

        // 데이터베이스에 저장
        conn = pool.getConnection();
        String sql = "INSERT INTO item (item_name, item_image, item_price, item_type, item_path) VALUES (?, ?, ?, ?, ?)";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, itemName);
        pstmt.setString(2, "./miniroom/img/" + itemImage);  // img 폴더에 저장된 경로
        pstmt.setInt(3, itemPrice);
        pstmt.setString(4, itemType);
        pstmt.setString(5, "./miniroom/path/" + itemPath);  // path 폴더에 저장된 경로

        int result = pstmt.executeUpdate();

        if (result > 0) {
            out.println("<script>alert('상품이 성공적으로 추가되었습니다.'); window.opener.location.reload(); window.close();</script>");
        } else {
            out.println("<script>alert('상품 추가에 실패했습니다.'); history.back();</script>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('데이터 처리 중 오류가 발생했습니다: " + e.getMessage() + "'); history.back();</script>");
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
