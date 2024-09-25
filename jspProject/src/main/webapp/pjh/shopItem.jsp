<%@page import="friend.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String item_img = request.getParameter("item_img");
	String item_name = request.getParameter("item_name");
	int item_price = UtilMgr.parseInt(request, "item_price");
%>

<div class="item">
                <img src="<%=item_img %>">
                <div class="item-title"><%=item_name %></div>
                <div class="item-price">
                    <img src="./img/clover_icon.png" alt="클로버"> <%=item_price %>개
                </div>
            </div>
