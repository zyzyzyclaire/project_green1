<%@page import="login.UserBean"%>
<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String user_id = null;
    
    
	if(((String)session.getAttribute("user_id"))!=null){
		user_id =(String)session.getAttribute("user_id");
		
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<table border="1" align="center">
		<form method="post" action="userOutOk.jsp">
			<tr>
				<td colspan="2" align="center">
					<h1>회원 탈퇴</h1>
				</td>
			</tr>
			<tr>
				<td width="80">
					ID
				</td>
				<td>
					<%= user_id %>
				</td>
			</tr>
			<tr>
				<td width="80">
					PASSWORD
				</td>
				<td>
					<input type="password" size="20" name="user_pwd">*
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="탈퇴">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="탈퇴안함" onclick="javascript:window.location='../userPage/userPage.jsp'">
				</td>
			</tr>			
		</form>
	</table>
</body>
</html>