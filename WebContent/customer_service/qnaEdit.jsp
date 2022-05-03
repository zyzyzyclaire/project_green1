<%@page import="login.UserDBBean"%>
<%@page import="notice.QnABean"%>
<%@page import="notice.QnADBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
	String pageNum = request.getParameter("pageNum");   
	
	String user_id = null;
    if (session.getAttribute("user_id") != null) {
    	user_id = (String) session.getAttribute("user_id");
    }
    
	int b_id=0;
    if (request.getParameter("b_id") != null) {	
		b_id = Integer.parseInt(request.getParameter("b_id"));
	}
    
    UserDBBean udb = new UserDBBean();
    QnADBBean qdb = QnADBBean.getInstance();
	QnABean board = qdb.getBoard(b_id, false);
	
	String select = request.getParameter("pageChange");
	boolean isAdPage = true;
	if (select == null) {
		isAdPage = false;
	}
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>

<style> 
	#container, #ntc, #navi { 
		min-width: 1100px; 
		max-width: 1280px; 
		margin: 0 auto; /* 가로로 중앙에 배치 */ 
		font-family: "Malgun Gothic",돋음;
		font-size: 12px;
	} 
	#ntc{
		padding-top: 3%;
	} 
	p{
		font-size: small;
	} 
	#list { 
		text-align: left; 
	}
	a:link { color: black; text-decoration: none;}
 	a:visited { color: gray; text-decoration: none;}
 	a:hover { color: blue; text-decoration: underline;}
</style>
<% if(!isAdPage){ %>
<jsp:include page="../main/mainHeader.jsp"></jsp:include>
<% } %>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="board.js" type="text/javascript"></script>   
</head>
<body>
	<div id="navi" style= "--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
		<ul class="breadcrumb" style="float: right;">
			<li class="breadcrumb-item"><a href="../main/main.jsp">Home</a></li>
			<li class="breadcrumb-item"><a href="../customer_service/customer_service.jsp">Customer Service</a></li>
			<li class="breadcrumb-item active">Q & A</li>
		</ul>
	</div>
	<% if(!isAdPage){ %>
	<div id="ntc">
		<h4 id="list">Q & A</h4>
		<p>사이즈 문의, 입금 배송 문의, 코디 문의, 이벤트 문의 등 모든 궁금한 사항들을 남겨주세요~</p>
	</div>  
	<% } %>
	<div id="container">
	<table class="table">
		<form name="boardForm" method="post" action="qnaEditOK.jsp?b_id=<%= b_id %>&pageNum=<%= pageNum %>" enctype="multipart/form-data">
				<input type="hidden" name="b_secret" value=<%= board.getB_secret() %>>
				<tr height="30px">
					<td style="padding-right: 40px">SUBJECT</td>
					<td><input name="b_title" type="text" size="100px" value="<%= board.getB_title() %>"></td>
				</tr>
				<tr height="30px">
						<td>NAME</td>
						<td>
							<input type="text" name="u_id" disabled="disabled" value=<%= user_id %>>
						</td>
					</tr>
					<tr height="30px">
						<td>CATEGORY</td>
						<td>
							<select name="b_category">
								<option value = "상품">상품</option>
								<option value = "배송">배송</option>
								<option value = "회원정보">회원정보</option>
							</select> 
						</td>
					</tr>
				<tr>
					<td colspan="2"><textarea name="b_content" placeholder="내용을 입력하세요." rows="15" cols="160" style="height: 500px;"></textarea></td>
				</tr>
				<tr>
					<td>FILE</td>
					<td>
						<input type="file" name="b_fname">
					</td>
				</tr>	
				<tr height="30px">
					<td>PASSWORD</td>
					<td>
						<input type="password" name="b_pwd" size="100px" maxlength="30" placeholder="암호를 입력하세요." aria-label="default input example">
					</td>
				</tr>
				<tr height="30px">
					<td align="left">
						<input type="button" value="&nbsp;&nbsp;&nbsp;목록&nbsp;&nbsp;&nbsp;" onClick="location.href='qnaList.jsp?b_id=<%= b_id %>&pageNum=<%= pageNum %>'" class="btn btn-secondary">
					</td>
					<td align="right">
						<input type="button" onClick="doWrite()" value="&nbsp;&nbsp;&nbsp;수정&nbsp;&nbsp;&nbsp;" class="btn btn-dark">
						<input type="reset" value="&nbsp;&nbsp;&nbsp;다시쓰기&nbsp;&nbsp;&nbsp;" class="btn btn-dark">
					</td>
				</tr>
			</form>
		</table>
	</div>
	<% if(!isAdPage){ %>
	<jsp:include page="../main/mainfooter.jsp"></jsp:include>
	<% } %> 
</body>
</html>