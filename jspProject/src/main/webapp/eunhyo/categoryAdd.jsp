<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="Category.CategoryMgr, Category.CategoryBean" %>

<%
    // 세션에서 userId 가져오기
    String userId = (String) session.getAttribute("userId"); 
    String categoryType = request.getParameter("categoryType");
    String categoryName = request.getParameter("categoryName");
    String categorySecretParam = request.getParameter("categorySecret");
    int categorySecret = (categorySecretParam != null && categorySecretParam.equals("1")) ? 1 : 0;
    
    System.out.println("categoryType: " + categoryType);
    System.out.println("categoryName: " + categoryName);
    // CategoryBean 객체 생성 및 값 설정
    if (categoryType == null || categoryName == null) {
        System.out.println("Error: categoryType or categoryName is null");
    }
    CategoryBean category = new CategoryBean();
    category.setUserId(userId);
    category.setCategoryType(categoryType); 
    category.setCategoryName(categoryName);
    category.setCategorySecret(categorySecret);

    // CategoryMgr 객체를 통해 데이터베이스에 삽입
    CategoryMgr categoryMgr = new CategoryMgr();
    boolean success = categoryMgr.insertCategory(category);

    // 응답을 통해 성공 여부 반환
    if (success) {
        out.print("success");
    } else {
        out.print("fail");
    }
%>
