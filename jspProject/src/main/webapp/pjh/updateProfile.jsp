<%@page import="java.nio.file.Paths"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pjh.MemberMgr, pjh.ProfileBean, org.json.JSONObject" %>
<%@ page import="com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%
    response.setContentType("application/json");
    JSONObject jsonResponse = new JSONObject();

    try {
        MemberMgr mgr = new MemberMgr();
        
        // 세션에서 유저 ID 가져오기
        String userId = (String) session.getAttribute("idKey");
        if (userId == null) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "로그인 상태가 아닙니다.");
            out.print(jsonResponse);
            return;
        }

        // 파일이 저장될 실제 경로 설정 (프로젝트 내의 "img" 폴더)
        String saveFolder = application.getRealPath("/miniroom/img"); // 실제 저장 경로
        
        // MultipartRequest를 사용하여 파일을 처리
        MultipartRequest multi = new MultipartRequest(request, saveFolder, MemberMgr.MAXSIZE, MemberMgr.ENCTYPE, new DefaultFileRenamePolicy());

        // 업로드된 파일 이름을 가져옴
        String fileName = multi.getFilesystemName("profile_picture");
        String filePath = null;

        // 파일이 업로드된 경우 경로를 설정
        if (fileName != null) {
            filePath = "miniroom/img/" + fileName; // 상대 경로 설정
        }
		
        // MultipartRequest에서 가져온 파라미터들을 사용하여 프로필 업데이트 수행
        boolean result = mgr.updateProfile(multi, userId, filePath); // 이미지 경로를 매개변수로 넘김

        if (result) {
            jsonResponse.put("success", true);
            jsonResponse.put("message", "수정이 완료되었습니다.");
            if (filePath != null) {
                jsonResponse.put("updatedImagePath", filePath);
            }
        } else {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "프로필 업데이트에 실패했습니다.");
        }
    } catch (Exception e) {
        jsonResponse.put("success", false);
        jsonResponse.put("message", e.getMessage());
        e.printStackTrace();
    }

    out.print(jsonResponse);  // JSON 응답 반환
%>
