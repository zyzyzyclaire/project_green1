<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="user" class="login.UserBean"></jsp:useBean>
<jsp:setProperty property="*" name="user"/>
<%	
	String user_id = (String)session.getAttribute("user_id");
	user.setUser_id(user_id);	// user_id�� ���� �ȵǾ������ϱ� - 0415 ����
	UserDBBean db = UserDBBean.getInstance();
	int re = db.outUser(user);
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