<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	// url로 들어오는 것 차단하기 위해 - 0415 근지
	if(session.getAttribute("user")==null) {
		response.sendRedirect("login.jsp");
	}
%>
<%
	// getAttribute() 반환타입 Object - 0415 근지
	String user_id = (String)session.getAttribute("user_id");
	String user_name = (String)session.getAttribute("user_name");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<table border=1 align="center">
		<form method="post" action="logOut.jsp">
			<tr>
				<td>
					안녕하세요. <%= user_name %>(<%= user_id %>)님
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="로그아웃">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="회원정보변경" 
					onclick="javascript:window.location='userUpdate.jsp'">
					<input type="button" value="회원탈퇴" 
					onclick="javascript:window.location='userOut.jsp'">					
				</td>			
			</tr>
		</form>		
	</table>
</body>
</html>