<%@page import="login.UserBean"%>
<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String user_id = (String)session.getAttribute("user_id");
	
	UserDBBean db = UserDBBean.getInstance();
	UserBean user = db.getUser(user_id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
	<script type="text/javascript" src="script.js" charset="UTF-8"></script>
</head>
<body>
	<table border="1" align="center">
		<form name="upd_frm" method="post" action="userUpdateOk.jsp">
			<tr>
				<td colspan="2" align="center">
					<h1>ȸ�� ���� ����</h1>
					'*' ǥ�� �׸��� �ʼ� �Է� �׸��Դϴ�.
				</td>
			</tr>
			<tr>
				<td width="80">
					ID
				</td>
				<td>
					<%= user.getUser_id() %>
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
				<td width="80">
					��ȣ Ȯ��
				</td>
				<td>
					<input type="password" size="20" name="pwd_check">*
				</td>
			</tr>
			<tr>
				<td width="80">
					��    ��
				</td>
				<td>
					<%= user.getUser_name() %>
				</td>
			</tr>
			<tr>
				<td width="80">
					E-mail
				</td>
				<td>
					<input type="text" size="30" name="user_email"
					value="<%= user.getUser_email() %>">*
				</td>
			</tr>
			<tr>
				<td width="80">
					��    ��
				</td>
				<td>
					<input type="text" size="40" name="user_addr"
					value="<%= user.getUser_addr()%>">
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="button" value="����" onclick="update_check_ok()">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="reset" value="�ٽ��Է�">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="��������" onclick="javascript:window.location='main.jsp'">
				</td>
			</tr>			
		</form>
	</table>
</body>
</html>