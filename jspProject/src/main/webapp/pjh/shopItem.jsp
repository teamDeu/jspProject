<%@ page import="friend.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String item_img = request.getParameter("item_img");
    String item_name = request.getParameter("item_name");
    int item_price = UtilMgr.parseInt(request, "item_price");
    String item_type = request.getParameter("item_type");
%>

<div class="item">
    <img src="<%=item_img %>" class="product-img"> <!-- 상품 이미지 -->
    <div class="item-title"><%=item_name %></div> <!-- 상품 이름 -->
    <div class="item-price">
        <img src="./img/clover_icon.png" alt="클로버" class="clover-icon"> <!-- 클로버 아이콘 -->
        <%=item_price %>개 <!-- 상품 가격 -->
        <input type = "hidden" name = "item-type" value ="<%=item_type %>">
    </div>
</div>
