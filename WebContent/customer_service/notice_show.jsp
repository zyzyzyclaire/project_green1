<%@page import="java.sql.Timestamp"%>
<%@page import="notice.NoticeBean"%>
<%@page import="notice.NoticeDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String pageNum = request.getParameter("pageNum");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	int num = Integer.parseInt(request.getParameter("n_num"));
	NoticeDBBean db = NoticeDBBean.getInstance();
	NoticeBean board = db.getBoard(num, true);
%>

<%
	String user_id = null;

	if(!((String)session.getAttribute("user_id") == null)){
		user_id =(String)session.getAttribute("user_id");
	}
%>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js">
    </script> <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js">
    </script> <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap-5.1.3-dist/css/bootstrap-grid.min.css">
    <link rel="stylesheet" href="../fontstyle/fontello-4581031e/css/fontello.css">
    <link rel="stylesheet" href="../css/jquery.bxslider.css">

<style type="text/css">
	div{
		font-family: "Malgun Gothic",돋음;
	}
	/* body{font-size: small;} */
	#scroll{
		position: sticky;
		top: 0;
		background-color: white;
		background-color: rgba( 255, 255, 255, 0.5 );
	}
	#lastnav{
		padding-right: 50px;
	}
	.breadcrumb {
		 background: white; 
	}
	a:link { color:black; }
	a:visited { color:black; }
	a:hover { color:mute;}
	a:active { color:black; }
</style>
<script type="text/javascript">
	function delete_OK() {
	var pwd = prompt("비밀번호를 입력하세요.");
	if(<%= board.getN_pwd() %> == pwd){
		if(confirm("정말 글을 삭제하시겠습니까?") == true){
			location.href = "notice_delete_ok.jsp?n_num="+<%= board.getN_num() %>+"&pageNum="<%= pageNum %>;
		}
	} else {
		alert("비밀번호가 맞지 않습니다.");
		history.go(-1);
	} 
}
</script>
</head>
<body>
<!-- 스크롤 네비바 시작 -->
<div id="scroll">


<nav class="py-2 border-bottom">
    <div class="container d-flex flex-wrap">
       <%
       		if(user_id==null){
       %>
      <ul class="nav me-auto">
        <li class="nav-item"><a href="../login/login.jsp" class="nav-link link-dark px-2 active" aria-current="page">로그인</a></li>
        <li class="nav-item"><a href="../login/register.jsp" class="nav-link link-dark px-2">회원가입</a></li>
        <li class="nav-item"><a href="../cart/viewCart.jsp" class="nav-link link-dark px-2">장바구니</a></li>
        <li class="nav-item"><a href="#" class="nav-link link-dark px-2">주문조회</a></li>
        <li class="nav-item"><a href="../userPage/userPage.jsp" class="nav-link link-dark px-2">마이페이지</a></li>
        <li class="nav-item"><a href="#" class="nav-link link-dark px-2">+즐겨찾기</a></li>
      </ul>
      	<%
                	}else{
      	%>
      <ul class="nav me-auto">
        <li class="nav-item"><a href="../login/logOut.jsp" class="nav-link link-dark px-2 active" aria-current="page">로그아웃</a></li>
        <li class="nav-item"><a href="../login/userUpdate.jsp" class="nav-link link-dark px-2">정보수정</a></li>
        <li class="nav-item"><a href="../cart/viewCart.jsp" class="nav-link link-dark px-2">장바구니</a></li>
        <li class="nav-item"><a href="#" class="nav-link link-dark px-2">주문조회</a></li>
        <li class="nav-item"><a href="../userPage/userPage.jsp" class="nav-link link-dark px-2">마이페이지</a></li>
        <li class="nav-item"><a href="#" class="nav-link link-dark px-2">+즐겨찾기</a></li>
      </ul>
      	<%
                	}
         %> 
      <ul class="nav">
        <li class="nav-item"><a href="../customer_service/notice_list.jsp" class="nav-link link-dark px-2">NOTICE</a></li>
        <li class="nav-item"><a href="../customer_service/qnaList.jsp" class="nav-link link-dark px-2">Q&A</a></li>
        <li class="nav-item"><a href="#" class="nav-link link-dark px-2">REVIEW</a></li>
        <li class="nav-item"><a href="#" class="nav-link link-dark px-2">MODEL</a></li>
      </ul>
    </div>
  </nav>
   <header class="py-3 mb-0 border-bottom">
    <div class="container d-flex flex-wrap justify-content-center">
      <a href="../main/main.jsp" class="d-flex align-items-center mb-3 mb-lg-0 me-lg-auto text-dark text-decoration-none">
        <svg class="bi me-4" width="40" height="32"><use xlink:href="#bootstrap"/></svg>
        <span class="fs-1" style="padding-left: 350px;">
        shopping mall</span>
      </a>
      <form class="col-12 col-lg-auto mb-3 mb-lg-0">
        <input type="search" class="form-control" placeholder="Search?" aria-label="Search">
      </form>
    </div>
  </header>
  <div>
 <ul class="nav justify-content-center">
  <li class="nav-item" id="lastnav">
    <a class="nav-link" href="#">BEST 50</a>
  </li>
  <li class="nav-item" id="lastnav">
    <a class="nav-link" href="#">OUTER</a>
  </li>
  <li class="nav-item" id="lastnav">
    <a class="nav-link" href="#">TOP</a>
  </li>
  <li class="nav-item" id="lastnav">
    <a class="nav-link" href="#">BOTTOM</a>
  </li>
  <li class="nav-item" id="lastnav">
    <a class="nav-link" href="#">SKIRT/OPS</a>
  </li>
  <li class="nav-item" id="lastnav">
    <a class="nav-link" href="#">SHOSE/BAG</a>
  </li>
  <li class="nav-item" id="lastnav">
    <a class="nav-link" href="#">ACC</a>
  </li>
  <li class="nav-item" id="lastnav">
    <a class="nav-link" href="#">SALE</a>
  </li>
</ul>
</div>

</div>
<!-- 스크롤 네비바 끝 -->
<!-- Breadcrumb 시작 -->
<center>
	<nav style= "--bs-breadcrumb-divider: '>'; min-width: 1100px; max-width: 1280px;" aria-label="breadcrumb">
		<ul class="breadcrumb" style= "float: right;">
			<li class="breadcrumb-item"><a href="../main/main.jsp">Home</a></li>
			<li class="breadcrumb-item"><a href="../customer_service/notice_list.jsp">Notice</a></li>
			<li class="breadcrumb-item active" aria-current="page">VIEW</li>
		</ul>
	</nav>
</center>
	<br><br><br><br>
	<center>
		<div class="table-responsive">
				<div style="min-width: 1100px; max-width: 1280px; padding-right: 700px; text-align: left;">
					<p>
						<h2>NOTICE</h2>
						구매 전에 꼭 읽어 주세요~
					</p>
				</div>	
			<table class="table" style="min-width: 1100px; max-width: 1280px;">
				<tr>
					<td style="width: 120px;">SUBJECT</td><td ><%= board.getN_title() %></td>
				</tr>
				<tr>
					<td style="width: 120px;">NAME</td>
					<td>
					<%  if(user_id!=null) {  //관리자 아이디로 접속할 때만 글쓰기 버튼 노출
							if(user_id.equals("admin")){	
					%>
							<%= user_id %>	<!-- 세션을 통해 id받아와 입력  -->
					<% }else {%>
							admin
					<% }} else { %>
							admin
					<% } %>
				</td>
				</tr>
				<tr>
					<td colspan="2" height="400px"><%= board.getN_content() %></td>
				</tr>
			</table>
			<div style="min-width: 1100px; max-width: 1280px;">
				<button style="float: left;" class="btn btn-outline-dark" onclick="location.href='notice_list.jsp?pageNum=<%= pageNum %>'">목록</button>
					<%  if(user_id!=null) {  //관리자 아이디로 접속할 때만 글쓰기 버튼 노출
						if(user_id.equals("admin")){	
					%>
				<button style="float: right;" class="btn btn-outline-dark" id="editbtn" onclick="location.href='notice_edit.jsp?n_num=<%= board.getN_num() %>&pageNum=<%= pageNum %>'">
				수정</button>
				<button style="float: right;" class="btn btn-outline-dark" id="delbtn" onclick="delete_OK()">
				삭제</button>
				<% }} %>
			</div>
			<br><br><br><br>
			<table class="table" style="min-width: 1100px; max-width: 1280px;">
				<tr>
					<td style="width: 120px;"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-up" viewBox="0 0 16 16">
												<path fill-rule="evenodd" d="M7.646 4.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1-.708.708L8 5.707l-5.646 5.647a.5.5 0 0 1-.708-.708l6-6z"/>
												</svg>
												PREV</td><td><a href="#">?????</a></td>
				</tr>
				<tr>
					<td style="width: 120px;"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-down" viewBox="0 0 16 16">
												<path fill-rule="evenodd" d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z"/>
												</svg>
												NEXT</td><td><a href="#">?????</a></td>
				</tr>
			</table>
		</div>	
	</center>
	<jsp:include page="../main/mainfooter.jsp"></jsp:include>
</body>
</html>
