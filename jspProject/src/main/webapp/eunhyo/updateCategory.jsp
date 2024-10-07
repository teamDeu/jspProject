<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="Category.CategoryMgr, Category.CategoryBean" %>

<%
    // 세션에서 userId 가져오기
    String userId = (String) session.getAttribute("userId");
    String categoryType = request.getParameter("categoryType");
    String categoryName = request.getParameter("categoryName");
    String categorySecretParam = request.getParameter("categorySecret");
    int categorySecret = (categorySecretParam != null && categorySecretParam.equals("1")) ? 1 : 0;

    // 로그 출력
    System.out.println("updateCategory.jsp - Received categoryType: " + categoryType);
    System.out.println("updateCategory.jsp - Received categoryName: " + categoryName);
    System.out.println("updateCategory.jsp - Received categorySecret: " + categorySecret);

    CategoryBean category = new CategoryBean();
    category.setUserId(userId); 
    category.setCategoryType(categoryType);
    category.setCategoryName(categoryName);
    category.setCategorySecret(categorySecret);

    // CategoryMgr 객체를 통해 업데이트
    CategoryMgr categoryMgr = new CategoryMgr();
    boolean success = categoryMgr.updateCategory(category);

    // 응답을 통해 성공 여부 반환
    if (success) {
        out.print("success");
    } else {
        out.print("fail");
    }
%>
