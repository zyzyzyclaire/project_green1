<%@page import="login.UserBean"%>
<%@page import="login.UserDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String user_id = null;
    if (session.getAttribute("user_id") != null) {
    	user_id = (String) session.getAttribute("user_id");
    }
%>
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리</title>
</head>
<script type="text/javascript" src="../login/script.js" charset="utf-8"></script>
<body>
       <h4>Members</h4>
	<%
		UserDBBean udb = null;
		boolean isAdmin = false;
		if (user_id == null) {
	%>
		<script>
			alert("잘못된 접근입니다.");
			location.href = "../main/main.jsp";
		</script>
	<%	
		} else {
			udb = new UserDBBean();
			isAdmin = udb.isAdmin(user_id);
		}
	
		if (!isAdmin) {
	%>
		<script>
			alert("잘못된 접근입니다.");
			location.href = "../main/main.jsp";
		</script>
	<%
		} else {
	%>
		<table border="1" width="800" cellspacing="0">
			<thead>
				<tr>
					<th>아이디</th>
					<th>이름</th>
					<th>번호</th>
					<th>이메일</th>
					<th>주소</th>
					<th>주문량</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
			<%
				ArrayList<UserBean> uList = udb.listUsers();
				for (UserBean user : uList) {
					String u_id = user.getUser_id();
					if (udb.isAdmin(u_id)) {
			%>
				<tr style="font-size: small; background-color: aqua;">
			<%			
					} else if (udb.defineUserId(u_id).getUser_grade().equals("D")) {
			%>
				<tr style="font-size: small; background-color: grey;">
			<%			
					} else {
			%>
				<tr style="font-size: small;">
			<%
					}
			%>
					<td><%= u_id %></td>
					<td><%= user.getUser_name() %></td>
					<td><%= user.getUser_phone() %></td>
					<td><%= user.getUser_email() %></td>
					<td><%= user.getUser_addr() %></td>
					<td><%= user.getUserPurchase() %></td>
					<td><input type="button" onClick="delete_check_admin('<%= user.getUser_id() %>')" value="탈퇴"></td>
				</tr>	
			<%					
				}
		}
			%>
			</tbody>
		</table>
</body>
</html>