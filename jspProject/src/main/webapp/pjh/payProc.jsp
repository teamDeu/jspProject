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

    // 클로버 충전 수량 계산 (100원당 1클로버)
    int cloverAmount = totalPrice / 100; 
    
    // DB 연동을 위해 DBConnectionMgr 사용
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // 결제 성공 후 클로버 수 업데이트 및 DB 저장 로직 추가
        DBConnectionMgr dbMgr = DBConnectionMgr.getInstance();
        conn = dbMgr.getConnection();

        // 현재 사용자의 클로버 수 업데이트
        String sql = "UPDATE members SET user_clover = user_clover + ? WHERE user_email = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, totalPrice / 100); // 결제 금액에 따른 클로버 양 계산 (100원당 1개)
        pstmt.setString(2, email);
        pstmt.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
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

        var msg;

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
                    url: "<%= request.getContextPath() %>/processPayment.jsp", // 결제 처리용 JSP 파일
                    type: "POST",
                    data: {
                        imp_uid: rsp.imp_uid,
                        merchant_uid: rsp.merchant_uid,
                        apply_num: rsp.apply_num,
                        paid_amount: rsp.paid_amount,
                        cloverAmount: <%= cloverAmount %>,
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
                        console.log("Error:", xhr, status, error);
                    }
                });
            } else {
                msg = '결제에 실패하였습니다. 에러 내용: ' + rsp.error_msg;
                alert(msg);
                location.href = "<%= request.getContextPath() %>/pjh/pay.jsp";
            }
        });
    });
    </script>
</body>
</html>
