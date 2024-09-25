<%@page import="item.ItemBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="mgr" class ="item.ItemMgr"/>
<% 
	Vector<ItemBean> vlist = mgr.getAllItems();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
        @font-face {
            font-family: 'NanumTobak';
            src: url('나눔손글씨 또박또박.TTF') format('truetype');
        }
        .store {
            font-family: 'NanumTobak';
            background-color: #F5F5F5;
            text-align: center;
            margin: 0;
            padding: 0;
            overflow: scroll;
            
        }
        .storecontainer {
            width: 95%;
            margin: 0 auto;
            padding: 20px;
            background-color: #FFF;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            position: relative;
            
        }
        /* 상점 제목 */
        .store-title {
            font-size: 30px;
            color: black;
            font-weight: bold;
            text-align: left;
            margin-bottom: 10px;
            position: absolute;
            top: 20px;
            left: 20px;
            border-bottom: 2px solid #ccc; /* 제목 아래 줄 추가 */
        }
        /* 클로버 금액 */
        .clover-amount {
            font-size: 18px;
            color: green;
            position: absolute;
            top: 20px;
            right: 60px;
            
        }
        /* 카테고리 탭 */
        .nav-tabs {
            display: flex;
            justify-content: left;
            list-style: none;
            padding: 0;
            margin-bottom: 20px;
            margin-top: 80px;
            border-bottom: 2px solid #ccc; /* 카테고리 아래 줄 추가 */
        }
        .nav-tabs li {
            padding: 10px 30px;
            cursor: pointer;
            font-size: 18px;
            color: #888;
            transition: color 0.3s ease;
        }
        .nav-tabs li.active {
            color: green;
            border-bottom: 2px solid green;
        }
        /* 인기순, 가격순, 클로버 충전 */
        .sort-options {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 20px;
            margin-bottom: 20px;
            margin-right: 20px;
            
        }
        .sort-buttons {	
            display: flex;
            gap: 20px;
        }
        .sort-buttons span {
            font-size: 18px;
            cursor: pointer;
            color: #888;
        }
        .sort-buttons span.active {
            color: green;
        }
        .search button {
            padding: 10px 20px;
            background-color: #90EE90;
            border: none;
            color: white;
            cursor: pointer;
            border-radius: 20px;
        }
        /* 상품 목록 */
        .items-container {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            padding: 20px;
            border: 1px solid #ccc;
        }
        .item {
            background-color: #FFF;
            border-radius: 10px;
            padding: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            border: 1px solid #ccc; /* 상품에 네모난 테두리 추가 */
        }
        .item img {
            width: 100%;
            height: 70%;
            border-radius: 10px;
        }
        .item-title {
            font-size: 16px;
            margin-top: 10px;
        }
        .item-price {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 10px;
        }
        .item-price img {
            width: 20px;
            margin-right: 5px;
        }
        /* 페이지네이션 */
        .pagination {
            display: flex;
            justify-content: center;
            padding: 20px;
        }
        .pagination span {
            padding: 5px 10px;
            margin: 0 5px;
            cursor: pointer;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .pagination span.active {
            background-color: green;
            color: #FFF;
            border-color: green;
        }
    </style>
<script>
	itemArray = [];
	<%
		for(int i = 0 ; i < vlist.size() ; i ++){
			ItemBean bean = vlist.get(i);
	%>
		itemArray.push(
				{
					item_num : <%=bean.getItem_num()%>,
					item_name : <%=bean.getItem_name()%>,
					item_image : <%=bean.getItem_image()%>,
					item_type : <%=bean.getItem_type()%>,
					item_price : <%=bean.getItem_price()%>,
					item_path : <%=bean.getItem_path()%>
				})
	<%}%>
	
</script>
</head>
<body>
<div id="allItems" class="items-container">
	<%for(int i = 0; i< vlist.size() ; i++){
	ItemBean bean = vlist.get(i);%>
	<jsp:include page="shopItem.jsp">
		<jsp:param value="<%=bean.getItem_image() %>" name="item_img"/>
		<jsp:param value="<%=bean.getItem_name() %>" name="item_name"/>
		<jsp:param value="<%=bean.getItem_price() %>" name="item_price"/>
	</jsp:include>
	<%} %>
</div>
</body>
</html>