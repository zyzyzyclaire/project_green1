<%@page import="login.UserBean"%>
<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%	
	// �Ϲ������δ� id������ getUser() �޼��带 ���� ������ ���� �� �̸� ���� ���� ��ȯ������,
	// findId�� �̸����� ���� id�� ã�� ������ getUser() �޼��带 ������� �ʰ� trytoFindId() �޼��忡�� �ٷ� id���� ������ �� - 0416 ����

	// user_id�� �ѱ��� �� ���������� �α��� �������� �� �� �ֵ���  ĳ���� ���� UTF-8�� ���� - 0416 ����
	// �������θ� �ۼ� ���ϸ� ���߿� ���� ��� - 0416 ����
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
			alert("�������� �ʴ� �̸���");
			history.go(-1);
			</script>
	<%
		} else {	// �̸����� ������ �� - 0416 ����
	%>
			���̵�� <%= user_id %> �Դϴ�.
	
	<%-- �̸����� ������ �� ������Ʈ������ Ȯ���� ���̵� ���� �α��� �������� ���ư� - 0416 ���� --%>		
	<form method="post" action="login.jsp?id=<%=user_id%>">
		<input type="submit" value="�α��� �������� ���ư���">
	</form>
	
	<%
		}
	%>
</body>
</html>