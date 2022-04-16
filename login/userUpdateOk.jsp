<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="user" class="login.UserBean"></jsp:useBean>
<jsp:setProperty property="*" name="user"/>
<%	
	String user_id = (String)session.getAttribute("user_id");
	user.setUser_id(user_id);	// user_id는 세팅 안되어있으니까 -  0415 근지
	UserDBBean db = UserDBBean.getInstance();
	int re = db.updateUser(user);
%>
<%
	if(re==1) {
%>
		<script>
			alert("입력하신대로 회원 정보가 수정되었습니다.");
			document.location.href="main.jsp";	// sendRedirect써도 됨 -  0415 근지
		</script>
<%
	} else {
%>
		<script>
			alert("수정이 실패되었습니다.");
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