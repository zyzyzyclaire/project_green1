<%@page import="java.sql.Timestamp"%>
<%@page import="notice.NoticeBean"%>
<%@page import="notice.NoticeDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String pageNum = request.getParameter("pageNum");
	
	String user_id = (String)session.getAttribute("user_id");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	int num = Integer.parseInt(request.getParameter("n_num"));
	NoticeDBBean db = NoticeDBBean.getInstance();
	NoticeBean board = db.getBoard(num, true);
%>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<center>
		<h1>Notice</h1>
		<table border="1" width="600" cellspacing="0">
			<tr height="30" align="center">
				<td width="100">�۹�ȣ</td>
				<td width="200">
					<%= board.getN_num() %>
				</td>
				<td width="100">��ȸ��</td>
				<td width="200">
					<%= board.getN_hit() %>
				</td>
			</tr>
			<tr height="30" align="center">
				<td width="100">�ۼ���</td>
				<td width="200">
					<%= user_id %>
				</td>
				<td width="100">�ۼ���</td>
				<td width="200">
					<%= sdf.format(board.getN_date()) %>
				</td>
			</tr>
			<tr height="30" align="center">
				<td width="100">������</td>
				<td colspan="3" align="left">
					<%= board.getN_title() %>
				</td>
			</tr>
			<tr height="30" align="center">
				<td width="100">�۳���</td>
				<td colspan="3" align="left">
					<%= board.getN_content() %>
				</td>
			</tr>
			<tr height="30">
				<td colspan="5" align="right">
					<%  if(user_id.equals("admin")) {  //������ ���̵�� ������ ���� �ۼ���, ���� ��ư ���� %>
					<input type="button" id="editbtn" value="�ۼ���" onclick="location.href='notice_edit.jsp?n_num=<%= board.getN_num() %>&pageNum=<%= pageNum %>'">&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" id="delbtn" value="�ۻ���" onclick="location.href='notice_delete.jsp?n_num=<%= board.getN_num() %>&pageNum=<%= pageNum %>'">&nbsp;&nbsp;&nbsp;&nbsp;
					<% } %>
					<input type="button" value="�۸��" onclick="location.href='notice_list_se.jsp?pageNum=<%= pageNum %>'">
				</td>
			</tr>
		</table>
	</center>
</body>
</html>