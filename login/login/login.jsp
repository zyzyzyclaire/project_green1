<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%
	// user_id�� �ѱ��� �� ���������� �α��� �� �� �ֵ��� login.jsp, loginOk.jsp ĳ���� ���� UTF-8�� ���� - 0416 ����
	// �������θ� �ۼ� ���ϸ� ���߿� ���� ��� - 0416 ����
	request.setCharacterEncoding("UTF-8");
%>
<%
	String id = request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border=1 align="center">
		<form method="post" action="loginOk.jsp">
			<tr>
				<td align="center">ID</td>
	<%
				if(id != null) {	// ���̵� ã�⸦ ���� ���̵� ã�� �� �α��� �� ��� - 0416 ����
	%>				
				<td><input type="text" name="user_id" value="<%= id %>"></td>
	<%				
				} else {	// �Ϲ� �α��� ��� - 0416 ����
	%>			
				<td><input type="text" name="user_id"></td>
	<%
				}
	%>
			</tr>
			<tr>
				<td>PASSWORD</td>
				<td><input type="password" name="user_pwd"></td>
			</tr>
			<tr>
				<td colspan="2">
				<input type="submit" value="�α���">
				<input type="button" value="ȸ������" 
						onclick="location='register.jsp'">
				</td>
			</tr>
		</form>
		
		<!-- ������ ���� ���� ������ form �ۿ� �ۼ� - 0416 ���� -->
		<tr>
			<td>
				<input type="button" value="���̵� ã��" onclick="location='findId.jsp'">
			</td>
			<td>
				<input type="button" value="��й�ȣ  ã��" onclick="location='findPwd.jsp'">
			</td>
		</tr>
	</table>
</body>
</html>