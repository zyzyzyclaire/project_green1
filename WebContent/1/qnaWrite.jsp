<%@page import="notice.QnABean"%>
<%@page import="login.UserDBBean"%>
<%@page import="login.UserBean"%>
<%@page import="notice.QnADBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<%	
	String pageNum = request.getParameter("pageNum");
	
	int b_id = 0, b_ref=1, b_step=0, b_level=0;
	String b_title="";
	
    String user_id = null;
    if (session.getAttribute("user_id") != null) {
        user_id = (String) session.getAttribute("user_id");
    }

	if (request.getParameter("b_id") != null) {	//답글일 시 제목앞에 [RE] 추가
		b_id = Integer.parseInt(request.getParameter("b_id"));
	}
    
	QnADBBean qdb = QnADBBean.getInstance();
	QnABean board = qdb.getBoard(b_id, false);
	
	if(board != null){
		b_title = board.getB_title();
		b_ref = board.getB_ref();
		b_step = board.getB_step();
		b_level = board.getB_level();
	}
		UserDBBean udb = new UserDBBean();
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="board.js" type="text/javascript"></script>    
</head>
<body>
	<h4>Write</h4>
	<table class="table">
		<form method="post" action="qnaWriteOK.jsp" name="boardForm" enctype="multipart/form-data">
		<thead>
			<tr height="30px">
				<td width="60">제&nbsp;&nbsp;목</td>
				<td>
				<%
					if(b_id == 0){
				%>
						<input class="form-control" name="b_title" type="text" size="55" value="<%= b_title %>"></td>
				<% 	
					} else {
				%>	
						<input class="form-control" name="b_title" type="text" size="55" value="[RE]: <%= b_title %>"></td>
				<% 	
					}
				%>
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
			<td colspan="4"><textarea name="b_content" rows="10" cols="80"></textarea></td>
		</tr>
		<tr height="30">
			<td colspan="4" align="right">
				<input type="hidden" name="b_id" value="<%= b_id %>">
				<input type="hidden" name="b_ref" value=<%= b_ref %>>
				<input type="hidden" name="b_step" value="<%= b_step %>">
				<input type="hidden" name="b_level" value="<%= b_level %>">
				<input type="hidden" name="u_id" value=<%= user_id %>>
				<% if (!udb.isAdmin(user_id) || b_ref != 0) { %>  <!-- 관리자와 작성자가 아니면 글 비공개 설정  -->
					<label><input type="checkbox" name="b_secret" checked> 비공개</label>
				<% } %>
				<input type="button" onClick="doWrite()" value="글쓰기">
				<input type="reset" value="다시쓰기">
				<input type="button" value="목록" onClick="location.href='qnaList.jsp'">
			</td>
		</tr>
		</form>
	</table>
</body>
</html>