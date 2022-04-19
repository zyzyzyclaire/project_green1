<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%	
	String user_id = (String)session.getAttribute("user_id");
	UserDBBean db = UserDBBean.getInstance();
	int re = db.outUser(user_id);
%>
<%
	if(re==1) {
%>
		<script>
			alert("회원 탈퇴퇴었습니다.");
			document.location.href="login.jsp";	// sendRedirect써도 됨 - 0415 근지
		</script>
<%
	} else {
%>
		<script>
			alert("탈퇴 실패되었습니다.");
			history.go(-1);
		</script>
<%
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>