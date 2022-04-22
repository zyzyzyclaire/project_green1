<%@page import="notice.QnABean"%>
<%@page import="login.UserDBBean"%>
<%@page import="notice.QnADBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html>
<head>
</head>
<body>
<%
	String pageNum = request.getParameter("pageNum");

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	String user_id = null;
    if (session.getAttribute("user_id") != null) {
        user_id = (String) session.getAttribute("user_id");
    }
%>
<%
	QnADBBean ndb = QnADBBean.getInstance();
	QnABean board;
	UserDBBean udb = new UserDBBean();
	boolean isAdmin = udb.isAdmin(user_id);
	boolean isMe = false;
	boolean isRef = false;
	boolean isMine = false;
	boolean isCategory = false;
	
	int b_id = 0;
	if (request.getParameter("b_id") == null || request.getParameter("b_id").length() == 0) {
	%>
		<script>
			alert("잘못된 접근입니다.");
			location.href = "qnaList.jsp";
		</script>
	<%
	} else {
		b_id = Integer.parseInt(request.getParameter("b_id"));
		board = ndb.getBoard(b_id, true);
		isMe = board.getU_id().equals(user_id);
	
	
		if (board == null) {
		%>
			<script>
				alert("잘못된 접근입니다.");
				location.href = "qnaList.jsp";
			</script>
		<%
		} else if (!board.getB_secret().equals("0")) {
			if (!isMe && !isAdmin) {
				%><script>
					alert("작성자만 볼 수 있는 비공개 글입니다.");
					location.href = "qnaList.jsp";
				</script><%
			}
		}
%>	
<script>
	function deleteOK() {
		if (<%= !isMe && !isAdmin %>) {
			alert("작성자만 삭제가 가능합니다.");
			return;
		} else if (confirm("정말 글을 삭제하시겠습니까?") == true) {
			location.href = "qnaDelete.jsp?b_id=" + <%= b_id %>;
		}
	}
</script>  
		<h4>Board</h4>
      	<% if (board != null) { %>
		<table border="1" width="600" cellspacing="0"> 
			<thead>
				<tr>
					<td width="90px" height="30px">분류:&nbsp;<%= board.getB_category()%></td>
					<td width="90px">조회수:&nbsp;<%= board.getB_view()%></td>
					<td width="180px">작성일:&nbsp;<%= sdf.format(board.getB_date()) %></td>
					<td width="100px">아이디:&nbsp;<%= board.getU_id()%></td>
				</tr>
				<tr align="left">
					<td colspan="4">
					 	<p>첨부파일&nbsp;
						<% 	
							if (board.getB_fsize() > 0) {
						%>		
								<a href='FileDownload.jsp?fileN=<%= board.getB_id() %>'><%= board.getB_rfname() %></a></p>	
						<% 	} else { %>
								&nbsp;
						<% 	} %>
					</td>
				</tr>
				<tr>
					<td width="90px" height="30px">No.<%= board.getB_id()%></td>                  
					<td colspan="3">제목: <%= board.getB_title()%></td>
				</tr>
			</thead>
			<tr>
				<td colspan="4" height="300px"><%= board.getB_content()%></td>
			</tr>
			<tr height="30">
				<td colspan="4" align="right">
					<% if (isAdmin) { %>
						<input type="button" value="답글" onClick="location.href='qnaWrite.jsp?b_ref=<%= b_id %>'" style="cursor:pointer;">
					<% } %>
					<% if (isMe || isAdmin) { %>
						<input type="button" value="수정" onClick="location.href='qnaEdit.jsp?b_id=<%= b_id %>'" style="cursor:pointer;">
						<input type="button" value="삭제" onClick="deleteOK()" style="cursor:pointer;">
					<% } %>
					<input type="button" value="목록" onClick="location.href='qnaList.jsp?pageNum=<%= pageNum %>'" style="cursor:pointer;">
				</td>
			</tr>
		</table>   
		<%
			}
      	}
      	%>      
</body>
</html>