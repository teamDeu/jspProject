<%@page import="friend.UtilMgr"%>
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
    int cloverAmount = UtilMgr.parseInt(request, "cloverAmount");
	int totalPrice = UtilMgr.parseInt(request, "totalPrice");
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
        var IMP = window.IMP; // 생략가능
        IMP.init('iamport'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
        var msg;
        
        IMP.request_pay({
            pg : 'inicis',
            pay_method : 'card',
            merchant_uid : 'merchant_' + new Date().getTime(),
            name : '주문명:결제테스트',
            amount : <%=totalPrice%>,
            buyer_email : '<%=email%>',
            buyer_name : '<%=name%>',
            buyer_tel : '<%=phone%>',
            buyer_addr : '<%=address%>',
            buyer_postcode : '123-456',
            //m_redirect_url : 'http://www.naver.com' //결제후 리디렉션 될 URL
        }, function(rsp) {
            if (rsp.success ) {
                //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
                jQuery.ajax({
                    url: "/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        imp_uid : rsp.imp_uid
                        //기타 필요한 데이터가 있으면 추가 전달
                    }
                }).done(function(data) {
                    //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
                    if ( everythings_fine ) {
                        msg = '결제가 완료되었습니다.';
                        msg += '\n고유ID : ' + rsp.imp_uid;
                        msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                        msg += '\결제 금액 : ' + rsp.paid_amount;
                        msg += '카드 승인번호 : ' + rsp.apply_num;
                        alert(msg);
                    } else {
                        //[3] 아직 제대로 결제가 되지 않았습니다.
                        //[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
                    }
                });
                //성공시 이동할 페이지
                document.complete.submit();
            } else {
                msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
                alert(msg);
                //실패시 이동할 페이지
                location.href="<%=request.getContextPath()%>/iamport/../pjh/pay.jsp";
            }
        });
    });
    </script> 
    <form name = "complete" method = "POST" action = "../pjh/paymentProc.jsp">
		<input type = "hidden" name ="totalPrice" value ='<%=totalPrice %>'>
		<input type = "hidden" name ="cloverAmount" value ='<%=cloverAmount %>'>
	</form>
</body>
</html>
