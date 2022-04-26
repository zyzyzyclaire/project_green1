<%@page import="notice.NoticeDBBean"%>
<%@page import="notice.NoticeBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String pageNum = request.getParameter("pageNum");
	
	String user_id = (String)session.getAttribute("user_id");
	if(session.getAttribute("user_id") == null){
		response.sendRedirect("../login/login.jsp");
	}

	int n_num = Integer.parseInt(request.getParameter("n_num"));
	NoticeDBBean db = NoticeDBBean.getInstance();
	NoticeBean board = db.getBoard(n_num, false);
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="notice.js" type="text/javascript"></script>
</head>
<body>
	<center>
		<h1>글 수 정 하 기</h1>
		<form name="reg_frm" method="post" action="notice_edit_ok.jsp?n_num=<%= n_num %>&pageNum=<%= pageNum %>">
			<table>
			 	<tr height="30">
					<td width="80">작성자</td>
					<td width="140">
						<input type="text" name="user_id" size="10" maxlength="20" value="<%= user_id %>">
					</td>
				</tr> 
				<tr height="30">
					<td width="80">글제목</td>
					<td colspan="3" width="460">
						<input type="text" name="n_title" size="55" maxlength="80" value="<%= board.getN_title() %>">
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<textarea rows="10" cols="65" name="n_content">
							<%= board.getN_content() %>
						</textarea>
					</td>
				</tr>
				<tr height="30">
					<td width="80">암&nbsp;&nbsp;호</td>
					<td colspan="3" width="460">
						<input type="password" name="n_pwd" size="12" maxlength="12">
					</td>
				</tr>
				<tr height="50" align="center">
					<td colspan="4">
						<input type="button" value="글수정" onclick="check_ok()">&nbsp;
						<input type="reset" value="다시작성">
						<input type="button" value="글목록" onclick="location.href='notice_list.jsp?pageNum=<%= pageNum %>'">&nbsp;
					</td>
				</tr>
			</table>
		</form>
	</center>
</body>
</html>