<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="pjh.MemberMgr" %>

<%
    // 결제 페이지에서 전달된 데이터를 받아 처리
    String userId = (String) session.getAttribute("idKey");  // 세션에서 사용자 ID 가져오기
    String cloverAmountStr = request.getParameter("cloverAmount");
    String quantityStr = request.getParameter("quantity");

    // null 값이 전달될 경우 기본값 설정
    if (cloverAmountStr == null || cloverAmountStr.isEmpty()) {
        cloverAmountStr = "0";
    }
    if (quantityStr == null || quantityStr.isEmpty()) {
        quantityStr = "0";
    }

    // 정수로 변환
    int cloverAmount = Integer.parseInt(cloverAmountStr);
    int quantity = Integer.parseInt(quantityStr);
    int totalClover = cloverAmount * quantity;  // 클로버 수량 계산

    // DB에 클로버 수량 업데이트
    MemberMgr memberMgr = new MemberMgr();
    boolean updateSuccess = memberMgr.updateCloverBalance(userId, totalClover);  // 클로버 잔액 업데이트

    if (updateSuccess) {
        out.print("SUCCESS");  // 결제 성공
    } else {
        out.print("ERROR: DB 업데이트에 실패했습니다.");  // 결제 실패
    }
%>
