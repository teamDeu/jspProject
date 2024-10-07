<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="Category.CategoryMgr" %>

<%
    String categoryType = request.getParameter("categoryType");
    String categoryName = request.getParameter("categoryName");
    String userId = (String) session.getAttribute("userId");

    CategoryMgr categoryMgr = new CategoryMgr();

    System.out.println("deleteCategory.jsp - Received categoryType: " + categoryType);
    System.out.println("deleteCategory.jsp - Received categoryName: " + categoryName);
    System.out.println("deleteCategory.jsp - Received userId: " + userId);

    boolean success = categoryMgr.deleteCategory(userId, categoryType, categoryName);
    if (success) {
        out.print("success");
        System.out.println("Category deletion successful.");
    } else {
        out.print("failure");
        System.out.println("Category deletion failed.");
    }
%>
