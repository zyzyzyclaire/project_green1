<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%	
	
	String user_id = null,user_pwd=null;
	user_id = (String)session.getAttribute("user_id");
	user_pwd =request.getParameter("user_pwd");
	
	
	UserDBBean db = UserDBBean.getInstance();
	
	int re = db.outUser(user_id,user_pwd);

%>
<%
	if(re==1) {
%>
		<script>
			alert("ȸ�� Ż��������ϴ�.");
			document.location.href="../login/logOut.jsp";	// sendRedirect�ᵵ �� - 0415 ����
		</script>
<%
	} else if(re==0){
%>
		<script>
			alert("��й�ȣ��Ʋ�Ƚ��ϴ�.");
			history.go(-1);
		</script>
<%
	}else{
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