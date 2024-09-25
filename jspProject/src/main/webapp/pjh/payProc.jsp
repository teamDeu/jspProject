<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="pjh.DBConnectionMgr, java.sql.*, pjh.MemberBean" %>
<%
    request.setCharacterEncoding("UTF-8");

    // 결제 정보를 받아옴
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    String stotalPrice = request.getParameter("totalPrice");
    int totalPrice = Integer.parseInt(stotalPrice);

    // 클로버 충전 수량 계산 
    int cloverAmount = totalPrice / 100; 
    
    // DB 연동을 위해 DBConnectionMgr 사용
%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>결제 시스템</title>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
    <script>
    $(function(){
        var IMP = window.IMP; 
        IMP.init('iamport'); // 가맹점 식별코드 사용

        IMP.request_pay({
            pg: 'inicis', 
            pay_method: 'card',
            merchant_uid: 'merchant_' + new Date().getTime(),
            name: '주문명: 결제 테스트',
            amount: <%= totalPrice %>, // 결제 금액
            buyer_email: '<%= email %>',
            buyer_name: '<%= name %>',
            buyer_tel: '<%= phone %>',
            buyer_addr: '<%= address %>',
            buyer_postcode: '123-456',
        }, function(rsp) {
            if (rsp.success) {
                // 결제 성공 시 DB에 저장 및 페이지 리디렉션
            	$.ajax({
            	    url: "<%= request.getContextPath() %>/pjh/processPayment.jsp",  // 정확한 경로로 수정
            	    type: "POST",
            	    data: {
            	        imp_uid: rsp.imp_uid,
            	        merchant_uid: rsp.merchant_uid,
            	        apply_num: rsp.apply_num,
            	        paid_amount: rsp.paid_amount,
            	        cloverAmount: <%= cloverAmount %>,  // 클로버 양
            	        email: '<%= email %>'
            	    },
            	    success: function(response) {
            	        if (response.trim() === 'SUCCESS') {
            	            alert('결제가 완료되었습니다. 클로버가 충전되었습니다.');
            	            location.href = '<%= request.getContextPath() %>/pjh/paymentProc.jsp?apply_num=' + rsp.apply_num + '&paid_amount=' + rsp.paid_amount;
            	        } else {
            	            alert('DB 저장 중 오류가 발생했습니다.');
            	        }
            	    },
            	    error: function(xhr, status, error) {
            	        alert('결제 후 서버와의 통신 중 오류가 발생했습니다.');
            	        console.log("Error:", xhr, status, error);  // 오류 로그 출력
            	    }
            	});
            } else {
                alert('결제에 실패하였습니다. 에러 내용: ' + rsp.error_msg);
                location.href = "<%= request.getContextPath() %>/pjh/pay.jsp";
            }
        });
    });
    </script>
</body>
</html>
