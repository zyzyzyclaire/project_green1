<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String pageNum = request.getParameter("pageNum");

	int n_num = Integer.parseInt(request.getParameter("n_num"));
%>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
	<script type="text/javascript" src="notice.js"></script>
</head>
<body>
	<center>
		<h1>�� �� �� �� �� �� ��</h1>
		<form name="reg_frm" method="post" action="notice_delete_ok.jsp?n_num=<%= n_num %>&pageNum=<%= pageNum %>">
			<table>
				<tr height="50">
					<td colspan="2" align="left">
						<b>
							>> ��ȣ�� �Է��ϼ���. <<
						</b>
					</td>
				</tr>
				<tr height="50">
					<td width="80">
						��&nbsp;&nbsp;ȣ
					</td>
					<td>
						<input type="password" name="n_pwd" size="12" maxlength="12">
					</td>
				</tr>
				<tr height="50">
					<td colspan="2" align="center">
						<input type="button" value="�ۻ���" onclick="delete_ok()">&nbsp;&nbsp;&nbsp;
						<input type="reset" value="�ٽ��ۼ�">&nbsp;
						<input type="button" value="�۸��" onclick="location.href='notice_list.jsp?pageNum=<%= pageNum %>'">
					</td>
				</tr>
			</table>
		</form>
	</center>
</body>
</html>