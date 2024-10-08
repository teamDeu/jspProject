<%@page import="Category.CategoryBean"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" %>
<%@ page import="java.sql.*, Category.CategoryMgr, java.util.*" %>

<%
    response.setContentType("application/json; charset=UTF-8");
    String userId = (String) session.getAttribute("userId");
    CategoryMgr categoryMgr = new CategoryMgr(); 
    
    // userId를 기준으로 카테고리 리스트를 가져옴
    List<CategoryBean> categoryList = categoryMgr.getCategoriesByUserId(userId);

    // JSON 형식으로 데이터 반환
    out.print("[");
    for (int i = 0; i < categoryList.size(); i++) {
        CategoryBean category = categoryList.get(i);
        if (i > 0) out.print(",");
        out.print("{");
        out.print("\"type\":\"" + category.getCategoryType() + "\",");
        out.print("\"name\":\"" + category.getCategoryName() + "\",");
        out.print("\"secret\":" + category.getCategorySecret() + ",");
        out.print("\"index\":" + category.getCategoryIndex()); // category_index 추가
        out.print("}");
    }
    out.print("]");
%>
