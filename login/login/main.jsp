<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	// url�� ������ �� �����ϱ� ���� - 0415 ����
	if(session.getAttribute("user")==null) {
		response.sendRedirect("login.jsp");
	}
%>
<%
	// getAttribute() ��ȯŸ�� Object - 0415 ����
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
					�ȳ��ϼ���. <%= user_name %>(<%= user_id %>)��
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="�α׾ƿ�">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="ȸ����������" 
					onclick="javascript:window.location='userUpdate.jsp'">
					<input type="button" value="ȸ��Ż��" 
					onclick="javascript:window.location='userOut.jsp'">					
				</td>			
			</tr>
		</form>		
	</table>
</body>
</html>