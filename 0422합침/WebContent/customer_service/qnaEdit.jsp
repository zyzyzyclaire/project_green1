<%@page import="notice.QnABean"%>
<%@page import="notice.QnADBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
	String pageNum = request.getParameter("pageNum");   

	String user_id = null;
    if (session.getAttribute("user_id") != null) {
    	user_id = (String) session.getAttribute("user_id");
    }
    
    QnADBBean qdb = QnADBBean.getInstance();
	int b_id = Integer.parseInt(request.getParameter("b_id"));
	QnABean board = qdb.getBoard(b_id, false);
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="board.js" type="text/javascript"></script>   
</head>
<body>
	<h4>Edit</h4>
	<table>
		<form method="post" action="qnaEditOK.jsp?b_id=<%= b_id %>&pageNum=<%= pageNum %>" enctype="multipart/form-data">
		<thead>
			<tr height="30px">
				<td>제&nbsp;&nbsp;목</td>
				<td><input name="b_title" type="text" size="55" value="<%= board.getB_title() %>"></td>
			</tr>
		</thead>
			<tr>
				<td>파&nbsp;&nbsp;일</td>
				<td>
					<input type="file" name="b_fname">
				</td>
			</tr>
		<tr height="30">
				<td width="40">암&nbsp;&nbsp;호</td>
				<td width="50">
					<input type="password" name="b_pwd" size="12" maxlength="12">
				</td>
				<td width="40">분&nbsp;&nbsp;류</td>
				<td>
					<select name="b_category">
						<option value = "상품">상품</option>
						<option value = "배송">배송</option>
						<option value = "회원정보">회원정보</option>
					</select> 
				</td>
			</tr>
		<tr>
			<td colspan="4"><textarea name="b_content" rows="10" cols="55"><%= board.getB_content() %></textarea></td>
		</tr>
		<tr height="30">
			<td colspan="4" align="right">
				<label><input type="checkbox" name="b_secret" checked> 비공개</label>
				<input type="submit" value="수정하기" onClick="doWrite()">
				<input type="reset" value="다시쓰기">
				<input type="button"
					value="목록" onClick="location.href='qnaList.jsp?pageNum=<%= pageNum %>'"
					style="cursor: pointer;"
					class="btn btn-secondary">
			</td>
		</tr>
		</form>
	</table>
</body>
</html>