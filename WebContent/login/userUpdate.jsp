<%@page import="login.UserBean"%>
<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String user_id = (String)session.getAttribute("user_id");
	
	UserDBBean db = UserDBBean.getInstance();
	UserBean user = db.getUser(user_id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script type="text/javascript" src="script.js" charset="UTF-8"></script>
</head>
<body>
	<table border="1" align="center">
		<form name="upd_frm" method="post" action="userUpdateOk.jsp">
			<tr>
				<td colspan="2" align="center">
					<h1>회원 정보 수정</h1>
					'*' 표시 항목은 필수 입력 항목입니다.
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
					암호 확인
				</td>
				<td>
					<input type="password" size="20" name="pwd_check">*
				</td>
			</tr>
			<tr>
				<td width="80">
					이    름
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
					휴대폰 번호
				</td>
				<td>
					<input type="text" size="40" name="user_phone"
					value="<%= user.getUser_phone() %>">
				</td>
			</tr>
			<tr>
				<td width="80">
					주    소
				</td>
				<td>
					<input type="text" size="40" name="user_addr"
					value="<%= user.getUser_addr()%>">
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="button" value="수정" onclick="update_check_ok()">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="reset" value="다시입력">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="수정안함" onclick="javascript:window.location='../userPage/userPage.jsp'">
				</td>
			</tr>			
		</form>
	</table>
</body>
</html>