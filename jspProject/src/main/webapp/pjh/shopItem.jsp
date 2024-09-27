<%@page import="friend.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String item_img = request.getParameter("item_img");
	String item_name = request.getParameter("item_name");
	int item_price = UtilMgr.parseInt(request, "item_price");
%>

<div class="item">
    <img src="<%=item_img %>" class="product-img"> <!-- 상품 이미지에 별도 클래스 적용 -->
    <div class="item-title"><%=item_name %></div>
    <div class="item-price">
        <img src="./img/clover_icon.png" alt="클로버" class="clover-icon"> <!-- 클로버 이미지에 별도 클래스 적용 -->
        <%=item_price %>개
    </div>
</div>   