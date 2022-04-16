<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script type="text/javascript" src="script.js" charset="UTF-8"></script>
</head>
<body>
	<table border="1">
		<form name="reg_frm" method="post" action="registerOk.jsp">
			<tr>
				<td colspan="2" align="center">
					<h1>회원 가입 신청</h1>
					'*' 표시 항목은 필수 입력 항목입니다.
				</td>
			</tr>
			<tr>
				<td width="80">
					ID
				</td>
				<td>
					<input type="text" size="20" name="user_id">*
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
					PASSWORD 중복 확인
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
					<input type="text" size="20" name="user_name">*
				</td>
			</tr>
			<tr>
				<td width="80">
					E-mail
				</td>
				<td>
					<input type="text" size="30" name="user_email">*
				</td>
			</tr>
			<tr>
				<td width="80">
					휴대폰 번호
				</td>
				<td>
					<input type="text" size="40" name="user_phone">
				</td>
			</tr>
			<tr>
				<td width="80">
					주    소
				</td>
				<td>
					<input type="text" size="40" name="user_addr">
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="button" value="등록" onclick="check_ok()">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="reset" value="다시입력">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="가입안함" onclick="javascript:window.location='login.jsp'">
				</td>
			</tr>
		</form>
	</table>
</body>
</html>