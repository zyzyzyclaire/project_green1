<%@page import="login.UserBean"%>
<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%
	// user_id�� �ѱ��� �� ���������� �α��� �� �� �ֵ��� login.jsp, loginOk.jsp ĳ���� ���� UTF-8�� ���� - 0416 ����
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
		String user_id = request.getParameter("user_id");
		String user_pwd = request.getParameter("user_pwd");
			
		UserDBBean db = UserDBBean.getInstance();
		int check = db.userCheck(user_id, user_pwd);
		String pwd = db.bannedUser(user_id);
		UserBean user = db.getUser(user_id);
		
		if(user==null) {
	%>
			<script>
			alert("�������� �ʴ� ȸ��");
			history.go(-1);
			</script>
	<%		
		} else {	// ȸ���� ������ �� - 0415 ����
			String user_name = user.getUser_name();
			if(check==1) {
				session.setAttribute("user_id", user_id);
				session.setAttribute("user_name", user_name);
				session.setAttribute("user", "yes");	// url�� ������ �� ������ - 0415 ����
				response.sendRedirect("../main/main.jsp");
			} else if(check==0) {
				if(pwd.equals("-1")){ //Ż���� ȸ�� �˾�â ó�� -0426 ����
	%>			
				<script>
				alert("Ż��ó���� ȸ���Դϴ�.");
				history.go(-1);
				</script>
	<% 
				}
	%>				
				<script>
				alert("��й�ȣ�� ���� �ʽ��ϴ�.");
				history.go(-1);
				</script>
	<%					
			} else {	// ���� ���� ��� - 0415 ����
	%>
				<script>
				alert("���̵� ���� �ʽ��ϴ�.");
				history.go(-1);
				</script>
	<%					
			}
		}
	%>
</body>
</html>