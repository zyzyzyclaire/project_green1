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
			alert("ȸ�� Ż��������ϴ�.");
			document.location.href="login.jsp";	// sendRedirect�ᵵ �� - 0415 ����
		</script>
<%
	} else {
%>
		<script>
			alert("Ż�� ���еǾ����ϴ�.");
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