<%@page import="java.nio.file.Paths"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pjh.MemberMgr, pjh.ProfileBean, org.json.JSONObject" %>
<%
    response.setContentType("application/json");
    JSONObject jsonResponse = new JSONObject();

    try {
        MemberMgr mgr = new MemberMgr();
        ProfileBean profile = new ProfileBean();

        // 세션에서 유저 ID 가져오기
        String userId = (String) session.getAttribute("idKey");
        if (userId == null) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "로그인 상태가 아닙니다.");
            out.print(jsonResponse);
            return;
        }

        // 기존 프로필 정보 불러오기
        profile = mgr.getProfileByUserId(userId);

        // 프로필 데이터 설정
        profile.setUser_id(userId);
        profile.setProfile_name(request.getParameter("profile_name"));
        profile.setProfile_email(request.getParameter("profile_email"));
        profile.setProfile_birth(request.getParameter("profile_birth"));
        profile.setProfile_hobby(request.getParameter("profile_hobby"));
        profile.setProfile_mbti(request.getParameter("profile_mbti"));
        profile.setProfile_content(request.getParameter("profile_content"));

        // 이미지 파일 처리
        String imagePath = profile.getProfile_picture();  // 기본값으로 기존 이미지 경로 설정
        Part filePart = request.getPart("profile_picture");

        if (filePart != null && filePart.getSize() > 0) {
            String uploadDir = application.getRealPath("/img/profile/");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            filePart.write(uploadDir + fileName);
            imagePath = "img/profile/" + fileName;
        }

        profile.setProfile_picture(imagePath);  // 기존 이미지 또는 새로 업로드된 이미지 경로 설정

        boolean result = mgr.updateProfile(profile);
        if (result) {
            jsonResponse.put("success", true);
        } else {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "프로필 업데이트에 실패했습니다.");
        }
    } catch (Exception e) {
        jsonResponse.put("success", false);
        jsonResponse.put("message", e.getMessage());
        e.printStackTrace();
    }

    out.print(jsonResponse);
%>
