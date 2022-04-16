<%@page import="login.UserBean"%>
<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%	
	// 일반적으로는 id값으로 getUser() 메서드를 통해 정보를 얻은 후 이를 통해 값을 반환하지만,
	// findId는 이메일을 통해 id를 찾기 때문에 getUser() 메서드를 사용하지 않고 trytoFindId() 메서드에서 바로 id값을 가져다 줌 - 0416 근지

	// user_id가 한글일 때 정상적으로 로그인 페이지로 갈 수 있도록  캐릭터 전부 UTF-8로 맞춤 - 0416 근지
	// 영문으로만 작성 원하면 나중에 삭제 요망 - 0416 근지
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String email = request.getParameter("email");
			
		UserDBBean db = UserDBBean.getInstance();
		String user_id = db.tryToFindId(email);
		
		if(user_id==null) {
	%>
			<script>
			alert("존재하지 않는 이메일");
			history.go(-1);
			</script>
	<%
		} else {	// 이메일이 존재할 시 - 0416 근지
	%>
			아이디는 <%= user_id %> 입니다.
	
	<%-- 이메일이 존재할 시 쿼리스트링으로 확인한 아이디를 갖고 로그인 페이지로 돌아감 - 0416 근지 --%>		
	<form method="post" action="login.jsp?id=<%=user_id%>">
		<input type="submit" value="로그인 페이지로 돌아가기">
	</form>
	
	<%
		}
	%>
</body>
</html>