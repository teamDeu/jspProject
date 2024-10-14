<%@page import="miniroom.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="Category.CategoryMgr, Category.CategoryBean" %>

<%
    // 세션에서 userId 가져오기
    String userId = (String) session.getAttribute("userId");

    // 파라미터로 전달된 값 가져오기
    String categoryType = request.getParameter("categoryType");
    String categoryName = request.getParameter("categoryName");
    String categorySecretParam = request.getParameter("categorySecret");

    // categoryIndex는 제대로 된 이름으로 가져옴 (오타 수정)
    int categoryIndex = UtilMgr.parseInt(request, "categoryIndex"); // 'catogoryIndex' -> 'categoryIndex'
    int categorySecret = (categorySecretParam != null && categorySecretParam.equals("1")) ? 1 : 0;

    // 로그 출력
    System.out.println("updateCategory.jsp - Received categoryType: " + categoryType);
    System.out.println("updateCategory.jsp - Received categoryName: " + categoryName);
    System.out.println("updateCategory.jsp - Received categorySecret: " + categorySecret);
    System.out.println("updateCategory.jsp - Received categoryIndex: " + categoryIndex); // 로그에 categoryIndex 추가

    // CategoryBean 객체 생성 및 값 설정
    CategoryBean category = new CategoryBean();
    category.setUserId(userId); 
    category.setCategoryType(categoryType);
    category.setCategoryName(categoryName);
    category.setCategorySecret(categorySecret);
    category.setCategoryIndex(categoryIndex); // categoryIndex 설정

    // CategoryMgr 객체를 통해 DB 업데이트
    CategoryMgr categoryMgr = new CategoryMgr();
    boolean success = false;
    if((categoryIndex == 1 && !categoryType.equals("홈")) || (categoryType.equals("홈") && (categoryIndex != 1 || categorySecret == 1))){
		success = false;
    }
    else{
    	success = categoryMgr.updateCategory(category);
    }
    

    // 성공 여부에 따라 응답 반환
    if (success) {
        out.print("success");
    } else {
        out.print("fail");
    }
%>
