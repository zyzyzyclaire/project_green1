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
			alert("�������� �ʴ� ȸ��");
			history.go(-1);
			</script>
	<%
		} else {	// �̸����� ������ �� - 0416 ����
	%>
			��й�ȣ�� <%= pwd %> �Դϴ�.
			<input type="button" value="�α��� �ϱ�" onclick="location='login.jsp'">
			
	<%
		}
	%>
</body>
</html>