<%@page import="pjh.AItemMgr"%>
<%@ page import="com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" autoFlush="true" %>
<%@ page import="java.sql.*, pjh.DBConnectionMgr" %>
<%@ page import="java.io.File, java.nio.file.Files, java.nio.file.StandardCopyOption" %>

<%
    AItemMgr mgr = new AItemMgr();
    String msg = "상품 수정 실패!";
    if (mgr.updateProduct(request)) {
        msg = "상품 수정 성공!";
        response.sendRedirect("adminStore.jsp?type=store");
    }
%>
<script>
    alert('<%=msg%>');
    opener.location.href = "adminStore.jsp?type=store";
</script>
