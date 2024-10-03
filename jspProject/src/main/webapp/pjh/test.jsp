<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
table {
    width: 100%;
    border-collapse: collapse;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

th {
    background-color: #4CAF50; /* 헤더 배경 색상 */
    color: white; /* 헤더 글자 색상 */
    padding: 12px;
    text-align: left;
}

td {
    padding: 12px;
    border-bottom: 1px solid #ddd;
}

tr:hover {
    background-color: #f5f5f5; /* 마우스 오버 색상 */
}

button {
    background-color: #008CBA; /* 버튼 배경 색상 */
    color: white;
    border: none;
    padding: 8px 12px;
    cursor: pointer;
    border-radius: 5px; /* 버튼 둥글기 */
}

button:hover {
    background-color: #005f73; /* 버튼 호버 색상 */
}
</style>
<body>
<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>사용자 이름</th>
            <th>이메일</th>
            <th>등록일</th>
            <th>마지막 로그인</th>
            <th>상태</th>
            <th>역할</th>
            <th>수정하기</th>
            <th>삭제하기</th>
        </tr>
    </thead>
    <tbody>
        <!-- 데이터 행 추가 -->
        <tr>
            <td>1</td>
            <td>홍길동</td>
            <td>hong@example.com</td>
            <td>2023-01-01</td>
            <td>2023-10-01</td>
            <td>활성</td>
            <td>관리자</td>
            <td><button>수정</button></td>
            <td><button>삭제</button></td>
        </tr>
        <!-- 추가 데이터 행 -->
    </tbody>
</table>
</body>
</html>