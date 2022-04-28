<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="notice.NoticeBean"%>
<%@page import="notice.NoticeDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
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
<%
	String user_id = null;
	String pageNum = null;
	if(((String)session.getAttribute("user_id"))!=null){
		user_id =(String)session.getAttribute("user_id");
		System.out.print(user_id);
	}
	if(((String)session.getAttribute("pageNum"))!=null){
		 pageNum = request.getParameter("pageNum");
	}
	
	if(pageNum == null){
		pageNum = "1";
	}
	NoticeDBBean db = NoticeDBBean.getInstance();
	
	ArrayList<NoticeBean> boardList = db.listBoard(pageNum);
	int n_num, n_hit;
	String n_title, n_content;
	Timestamp n_date;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
%>

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

<br><br><br><br>
	<center>
	<div class="table-responsive" >
		<div style="width:900px; padding-right: 700px; text-align: left;">
		<p>
		<h2>Notice</h2>
		구매 전에 꼭 읽어 주세요~
		</p>
		</div>	
	<%  if(user_id!=null) {  //관리자 아이디로 접속할 때만 글쓰기 버튼 노출
	if(user_id.equals("admin")){	
	%>
	<table width="800;">
		<tr>
			<td align="right">
				<input type="button" class="btn btn-outline-dark" value="글쓰기" onclick="location.href='notice_write.jsp?pageNum=<%= pageNum %>'"></input>
			</td>
		</tr>
	</table>
	<% }} %>
	</center>
	<center>
		<table class="table" style="width: 900px;">
    <tr>
      <th scope="col" style="width: 70px;">NO.</th>
      <th scope="col" style="text-align: center; width: 400px;">SUBJECT</th>
      <th scope="col" style="text-align: right; width: 100px;">NAME</th>
      <th scope="col" style="text-align: center;">DATE</th>
      <th scope="col" style="text-align: right;">VIEWS</th>
    </tr>
  			<%
			if(boardList.size()==0) {
			%>
	 		<tr align="center" bgcolor="#FFFFFF" height="30">
	 	   		<td colspan="5">등록된 글이 없습니다.</td>
	 	  	</tr>
			<% } else {
				for(int i=0; i<boardList.size(); i++){
						NoticeBean board = boardList.get(i);
						
						n_num = board.getN_num();
						n_title = board.getN_title();
						n_content = board.getN_content();
						n_date = board.getN_date();
						n_hit = board.getN_hit();
			%>
    <tr>
      <th scope="row"><%= n_num %></th>
      <td>
      	<a href="notice_show.jsp?n_num=<%= n_num %>&pageNum=<%= pageNum %>">
						<%= n_title %>
					</a>
      </td>
      <td style="text-align: right;">
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
      
      <td style="text-align: right;"><%= sdf.format(n_date) %></td>
      <td style="text-align: right;"><%= n_hit %></td>
      <%
					}
				}
			%>
    </tr>
</table>
</div>

<%= NoticeBean.pageNumber(4) %>
	</center>

<!-- 검색창 시작 -->
<br><br>
<center>
<div style="width: 1100px; padding-left: 100px;">
<table style="float: left;">
	<tr>
		<td width="100px;">
			<select class="form-select" aria-label="Default select example">
			  <option selected>일주일</option>
			  <option value="1">한달</option>
			  <option value="2">세달</option>
			  <option value="3">전체</option>
			</select>
		</td>
		<td width="100px;">
			<select class="form-select" aria-label="Default select example">
			  <option selected>제목</option>
			  <option value="1">내용</option>
			  <option value="2">글쓴이</option>
			  <option value="3">아이디</option>
			  <option value="3">별명</option>
			</select>
		</td>
		<td>
			<input type="search" class="form-control">
		</td>
		<td>
			<button type="button" class="btn btn-outline-secondary">검색</button>
		</td>
	</tr>
</table>
</div>
</center>
<!-- 검색창 끝 -->



<br><br><br><br><br><br><br><br>
<!-- <hr class="mx-0 px-0">
<div class="container">
  <footer class="row row-cols-0 py-0 my-0">

    <div class="col">
      <h5>Team3</h5>
      <ul class="nav flex-column">
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">TEL. 000-000</a></li>
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">OPEN : 09:00 ~ 18:00</a></li>
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">LUNCH : 12:00 ~ 13:00</a></li>
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">토요일, 일요일 OFF</a></li>
      </ul>
    </div>

    <div class="col">
      
      <ul class="nav flex-column">
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">customer service<br>Tel 010-0000-0000</a></li>
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">customer service<br>Tel 010-0000-0000</a></li>
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">customer service<br>Tel 010-0000-0000</a></li>
      </ul>
    </div>

    <div class="col">
      <h5>&nbsp;</h5>
      <ul class="nav flex-column">
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">국민은행 000002-01-000000</a></li>
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">예금주 : 그린컴</a></li>
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">주소 : 부산 중구 새마을로 146 3-4층</a></li>
      </ul>
    </div>
  </footer> -->
</div>
<jsp:include page="../main/mainfooter.jsp"></jsp:include>

</body>
</html>

