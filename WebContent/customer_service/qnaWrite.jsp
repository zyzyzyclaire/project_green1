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
	
	if (request.getParameter("b_id") != null) {	
		b_id = Integer.parseInt(request.getParameter("b_id"));
	}
	QnADBBean qdb = QnADBBean.getInstance();
	QnABean board = qdb.getBoard(b_id, false);
	UserDBBean udb = new UserDBBean();
	
	if(board != null){ //board가 널값이 아니면(답변글이면)
		b_title = board.getB_title();
		b_ref = board.getB_ref();
		b_step = board.getB_step();
		b_level = board.getB_level();
	}
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
	
	<!-- 서머노트를 위해 추가해야할 부분 시작 -->
	  <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet"> 
	  <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	  <script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
	<!-- 서머노트를 위해 추가해야할 부분 끝 -->
    <script src="board.js" type="text/javascript"></script> 
<style> 
	#container, #ntc, #navi { 
		min-width: 1100px; 
		max-width: 1280px; 
		margin: 0 auto; /* 가로로 중앙에 배치 */ 
				font-family: "Malgun Gothic",돋음;
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
<jsp:include page="../main/mainHeader.jsp"></jsp:include>
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
	<div id="ntc">
		<h4 id="list">Q & A</h4>
		<p>사이즈 문의, 입금 배송 문의, 코디 문의, 이벤트 문의 등 모든 궁금한 사항들을 남겨주세요~</p>
	</div>  
	<div id="container">
		<table class="table">
			<form method="post" action="qnaWriteOK.jsp" name="boardForm" enctype="multipart/form-data">
					<input type="hidden" name="b_id" value="<%= b_id %>">
					<input type="hidden" name="b_ref" value=<%= b_ref %>>
					<input type="hidden" name="b_step" value="<%= b_step %>">
					<input type="hidden" name="b_level" value="<%= b_level %>">
				<tr>
					<td style="padding-right: 40px">SUBJECT</td>
					<td>
					<%
						if(b_id == 0){
					%>
							<input name="b_title" type="text" size="100px" value="<%= b_title %>" placeholder="제목을 입력하세요." aria-label="default input example">
					<% 	
						} else {
					%>	
							<input name="b_title" type="text" size="100px" value="[RE]: <%= b_title %>">
					<% 	
						}
					%>
					</td>
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
				<td colspan="2"><textarea name="b_content" class="summernote" placeholder="내용을 입력하세요." rows="15" cols="160" style="height: 500px;"></textarea></td>
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
			<% if (!udb.isAdmin(user_id) || b_ref != 0) { %>  <!-- 관리자와 작성자가 아니면 글 비공개 설정  -->
			<tr height="30px">
				<td>SECRET</td>
				<td class="btn-group-toggle" data-toggle="buttons" colspan="4">
					<input type="checkbox" class="btn-check" id="btn-check-outlined" name="b_secret" autocomplete="off" checked>
					<label class="btn btn-outline-primary" for="btn-check-outlined">비밀글</label>
				</td>
			</tr>
			<% } %>
			<tr height="30px">
				<td align="left">
					<input type="button" value="&nbsp;&nbsp;&nbsp;목록&nbsp;&nbsp;&nbsp;" onClick="location.href='qnaList.jsp?b_id=<%= b_id %>&pageNum=<%= pageNum %>'" class="btn btn-secondary">
				</td>
				<td align="right">
					<input type="button" onClick="doWrite()" value="&nbsp;&nbsp;&nbsp;등록&nbsp;&nbsp;&nbsp;" class="btn btn-dark">
					<input type="reset" value="&nbsp;&nbsp;&nbsp;다시쓰기&nbsp;&nbsp;&nbsp;" class="btn btn-dark">
				</td>
			</tr>
			</form>
		</table>
	</div>
	<jsp:include page="../main/mainfooter.jsp"></jsp:include>
<script>
$('.summernote').summernote({
	  height: 500,
	  lang: "ko-KR"
	});
</script> 
</body>
</html>