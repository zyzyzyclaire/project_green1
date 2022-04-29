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
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js">
    </script> <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js">
    </script> <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap-5.1.3-dist/css/bootstrap-grid.min.css">
    <link rel="stylesheet" href="../fontstyle/fontello-4581031e/css/fontello.css">
    <link rel="stylesheet" href="../css/jquery.bxslider.css">
<!-- 서머노트를 위해 추가해야할 부분 시작 -->
  <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet"> 
  <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
  <script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
<!-- 서머노트를 위해 추가해야할 부분 끝 -->
	<script src="notice.js" type="text/javascript"></script>
<style type="text/css">
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
</head>
<body>
<!-- 스크롤 네비바 시작 -->
<div id="scroll">
<%-- <%
	if(((String)session.getAttribute("user_id"))!=null){
		user_id =(String)session.getAttribute("user_id");
	}
%> --%>

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
<div style="width: 1100px;">
	<nav aria-label="breadcrumb" style="float: right;">
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="../main/main.jsp">Home</a></li>
			<li class="breadcrumb-item">Board</li>
			<li class="breadcrumb-item active" aria-current="page">NOTICE</li>
		</ol>
	</nav>
</div>
</center>
<!-- Breadcrumb 끝 -->

	<br><br><br>
	<center>
		<div class="table-responsive">
			<div style="width:900px; padding-right: 700px; text-align: left;">
					<p>
						<h2>Notice</h2>
						
					</p>
				</div>
		<form name="reg_frm" method="post" action="notice_edit_ok.jsp?n_num=<%= n_num %>&pageNum=<%= pageNum %>">
			<table class="table" style="width: 900px;">
			 	<tr>
					<td style="width: 120px;">NAME</td>
					<td>
						<input type="text" name="user_id" size="10" maxlength="20" value="<%= user_id %>" class="form-control form-control-sm" style="width: 200px;">
					</td>
				</tr> 
				<tr>
					<td style="width: 120px;">SUBJECT</td>
					<td>
						<input type="text" name="n_title" size="55" maxlength="80" value="<%= board.getN_title() %>" class="form-control form-control-sm">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<textarea rows="10" cols="65" name="n_content" class="summernote" style="height: 500px">
							<%= board.getN_content() %>
						</textarea>
					</td>
				</tr>
				<tr>
					<td style="width: 120px;">PASSWARD</td>
					<td>
						<input type="password" name="n_pwd" size="12" maxlength="12" class="form-control form-control-sm" style="width: 200px;">
					</td>
				</tr>
			</table>
			<div style="width: 900px;">
						<button style="float: left;" class="btn btn-outline-dark" onclick="check_ok()">글수정</button>
						<input style="float: right;" class="btn btn-outline-dark" type="button" value="글목록" onclick="location.href='notice_list.jsp?pageNum=<%= pageNum %>'">
						<input style="float: right;" class="btn btn-outline-dark" type="reset" value="다시작성">
			</div>
			<br><br><br><br>
		</form>
		</div>
	</center>
	<jsp:include page="../main/mainfooter.jsp"></jsp:include>
	<script>
$('.summernote').summernote({
	  height: 500,
	  lang: "ko-KR"
	});
</script>

</body>
</html>