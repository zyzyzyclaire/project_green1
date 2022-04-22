<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		String id = request.getParameter("id");
		String email = request.getParameter("email");
			
		UserDBBean db = UserDBBean.getInstance();
		String pwd = db.tryToFinPwd(id, email);
		
		if(pwd==null) {
	%>
			<script>
			alert("존재하지 않는 회원");
			history.go(-1);
			</script>
	<%
		} else {	// 이메일이 존재할 시 - 0416 근지
	%>
			비밀번호는 <%= pwd %> 입니다.
			<input type="button" value="로그인 하기" onclick="location='login.jsp'">
			
	<%
		}
	%>
</body>
</html>