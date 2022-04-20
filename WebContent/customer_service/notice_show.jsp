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
				<td width="100">글번호</td>
				<td width="200">
					<%= board.getN_num() %>
				</td>
				<td width="100">조회수</td>
				<td width="200">
					<%= board.getN_hit() %>
				</td>
			</tr>
			<tr height="30" align="center">
				<td width="100">작성자</td>
				<td width="200">
					<%= user_id %>
				</td>
				<td width="100">작성일</td>
				<td width="200">
					<%= sdf.format(board.getN_date()) %>
				</td>
			</tr>
			<tr height="30" align="center">
				<td width="100">글제목</td>
				<td colspan="3" align="left">
					<%= board.getN_title() %>
				</td>
			</tr>
			<tr height="30" align="center">
				<td width="100">글내용</td>
				<td colspan="3" align="left">
					<%= board.getN_content() %>
				</td>
			</tr>
			<tr height="30">
				<td colspan="5" align="right">
					<%  if(user_id.equals("admin")) {  //관리자 아이디로 접속할 때만 글수정, 삭제 버튼 노출 %>
					<input type="button" id="editbtn" value="글수정" onclick="location.href='notice_edit.jsp?n_num=<%= board.getN_num() %>&pageNum=<%= pageNum %>'">&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" id="delbtn" value="글삭제" onclick="location.href='notice_delete.jsp?n_num=<%= board.getN_num() %>&pageNum=<%= pageNum %>'">&nbsp;&nbsp;&nbsp;&nbsp;
					<% } %>
					<input type="button" value="글목록" onclick="location.href='notice_list_se.jsp?pageNum=<%= pageNum %>'">
				</td>
			</tr>
		</table>
	</center>
</body>
</html>