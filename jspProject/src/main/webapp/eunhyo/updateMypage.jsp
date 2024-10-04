<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="mypage.MypageMgr, mypage.MypageBean" %>

<%
    try {
        request.setCharacterEncoding("UTF-8");
        
        System.out.println("userId: " + request.getParameter("userId"));
        System.out.println("userName: " + request.getParameter("userName"));
        System.out.println("userEmail: " + request.getParameter("userEmail"));
        System.out.println("userBirth: " + request.getParameter("userBirth"));
        System.out.println("userPhone: " + request.getParameter("userPhone"));

        MypageBean bean = new MypageBean();
        
        // 요청 파라미터 확인 및 값 설정
        bean.setUserId(request.getParameter("userId"));
        bean.setUserName(request.getParameter("userName"));
        bean.setUserEmail(request.getParameter("userEmail"));
        
        // 유효한 날짜 처리
        String userBirthStr = request.getParameter("userBirth");
        if (userBirthStr != null && !userBirthStr.isEmpty()) {
            bean.setUserBirth(java.sql.Date.valueOf(userBirthStr));
        } else {
            bean.setUserBirth(null);
        }
        
        bean.setUserPhone(request.getParameter("userPhone"));
        
        MypageMgr mgr = new MypageMgr();
        boolean isUpdated = mgr.updateUserInfo(bean);
        
        if (isUpdated) {
            response.getWriter().write("success");
            response.getWriter().flush(); // 응답 즉시 전송
        } else {
            response.getWriter().write("fail");
            response.getWriter().flush(); // 응답 즉시 전송
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
    }
%>
