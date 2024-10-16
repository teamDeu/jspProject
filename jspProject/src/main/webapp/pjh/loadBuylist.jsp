<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, pjh.DBConnectionMgr"%>

<%
String user_id = (String) session.getAttribute("idKey");
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
DBConnectionMgr pool = DBConnectionMgr.getInstance();

try {
    conn = pool.getConnection();
    String getUserItemsSQL = "SELECT i.item_name, i.item_image, i.item_price, h.item_num FROM item i JOIN itemhold h ON i.item_num = h.item_num WHERE h.user_Id = ?";
    pstmt = conn.prepareStatement(getUserItemsSQL);
    pstmt.setString(1, user_id);
    rs = pstmt.executeQuery();

    while (rs.next()) {
%>
    <div class="buylistItems" onclick="refundStoreItem(<%= rs.getInt("item_num") %>, <%= rs.getInt("item_price") %>)">
    <img class ="product-img" src="<%= rs.getString("item_image") %>" alt="<%= rs.getString("item_name") %>" style="width:186px;height:145px;"/>
    <div class="item-title"><%= rs.getString("item_name") %></div>
    <div class="item-price">
        <img src="./img/clover_icon.png" alt="클로버" style="width:20px; height:20px;"> <%= rs.getInt("item_price") %>개
    </div>
</div>

<%
    }
} catch (Exception e) {
    e.printStackTrace();
} finally {
    if (rs != null) rs.close();
    if (pstmt != null) pstmt.close();
    if (conn != null) pool.freeConnection(conn);
}
%>
