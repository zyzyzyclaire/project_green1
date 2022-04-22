<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%
	// user_id가 한글일 때 정상적으로 로그인 될 수 있도록 login.jsp, loginOk.jsp 캐릭터 전부 UTF-8로 맞춤 - 0416 근지
	// 영문으로만 작성 원하면 나중에 삭제 요망 - 0416 근지
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
				if(id != null) {	// 아이디 찾기를 통해 아이디를 찾은 후 로그인 한 경우 - 0416 근지
	%>				
				<td><input type="text" name="user_id" value="<%= id %>"></td>
	<%				
				} else {	// 일반 로그인 경우 - 0416 근지
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
				<input type="submit" value="로그인">
				<input type="button" value="회원가입" 
						onclick="location='register.jsp'">
				</td>
			</tr>
		</form>
		
		<!-- 전달할 값이 없기 때문에 form 밖에 작성 - 0416 근지 -->
		<tr>
			<td>
				<input type="button" value="아이디 찾기" onclick="location='findId.jsp'">
			</td>
			<td>
				<input type="button" value="비밀번호  찾기" onclick="location='findPwd.jsp'">
			</td>
		</tr>
	</table>
</body>
</html>