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
<!-- ��ũ�� �׺�� ���� -->
<div id="scroll">


<nav class="py-2 border-bottom">
    <div class="container d-flex flex-wrap">
       <%
       		if(user_id==null){
       %>
      <ul class="nav me-auto">
        <li class="nav-item"><a href="../login/login.jsp" class="nav-link link-dark px-2 active" aria-current="page">�α���</a></li>
        <li class="nav-item"><a href="../login/register.jsp" class="nav-link link-dark px-2">ȸ������</a></li>
        <li class="nav-item"><a href="../cart/viewCart.jsp" class="nav-link link-dark px-2">��ٱ���</a></li>
        <li class="nav-item"><a href="#" class="nav-link link-dark px-2">�ֹ���ȸ</a></li>
        <li class="nav-item"><a href="../userPage/userPage.jsp" class="nav-link link-dark px-2">����������</a></li>
        <li class="nav-item"><a href="#" class="nav-link link-dark px-2">+���ã��</a></li>
      </ul>
      	<%
                	}else{
      	%>
      <ul class="nav me-auto">
        <li class="nav-item"><a href="../login/logOut.jsp" class="nav-link link-dark px-2 active" aria-current="page">�α׾ƿ�</a></li>
        <li class="nav-item"><a href="../login/userUpdate.jsp" class="nav-link link-dark px-2">��������</a></li>
        <li class="nav-item"><a href="../cart/viewCart.jsp" class="nav-link link-dark px-2">��ٱ���</a></li>
        <li class="nav-item"><a href="#" class="nav-link link-dark px-2">�ֹ���ȸ</a></li>
        <li class="nav-item"><a href="../userPage/userPage.jsp" class="nav-link link-dark px-2">����������</a></li>
        <li class="nav-item"><a href="#" class="nav-link link-dark px-2">+���ã��</a></li>
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
<!-- ��ũ�� �׺�� �� -->
<!-- Breadcrumb ���� -->
<center>
<div style="width: 1100px;">
	<nav aria-label="breadcrumb" style="float: right;">
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="../main/main.jsp">Home</a></li>
			<li class="breadcrumb-item">Board</li>
			<li class="breadcrumb-item"><a href="../customer_service/notice_list.jsp">Notice</a></li>
			<li class="breadcrumb-item active" aria-current="page">VIEW</li>
		</ol>
	</nav>
</div>
</center>
<!-- Breadcrumb �� -->
	<%-- <center>
		
		<table border="1" width="600" cellspacing="0">
			<tr height="30" align="center">
				<td width="100">�۹�ȣ</td>
				<td width="200">
					<%= board.getN_num() %>
				</td>
				<td width="100">��ȸ��</td>
				<td width="200">
					<%= board.getN_hit() %>
				</td>
			</tr>
			<tr height="30" align="center">
				<td width="100">�ۼ���</td>
				<td width="200">
				<%  if(user_id!=null) {  //������ ���̵�� ������ ���� �۾��� ��ư ����
						if(user_id.equals("admin")){	
				%>
						<%= user_id %>	<!-- ������ ���� id�޾ƿ� �Է�  -->
				<% }else {%>
						admin
				<% }} else { %>
						admin
				<% } %>
				</td>
				<td width="100">�ۼ���</td>
				<td width="200">
					<%= sdf.format(board.getN_date()) %>
				</td>
			</tr>
			<tr height="30" align="center">
				<td width="100">������</td>
				<td colspan="3" align="left">
					<%= board.getN_title() %>
				</td>
			</tr>
			<tr height="30" align="center">
				<td width="100">�۳���</td>
				<td colspan="3" align="left">
					<%= board.getN_content() %>
				</td>
			</tr>
			<tr height="30">
				<td colspan="5" align="right">
					
					<%  if(user_id!=null) {  //������ ���̵�� ������ ���� �۾��� ��ư ����
						if(user_id.equals("admin")){	
					%>
					<input type="button" id="editbtn" value="�ۼ���" onclick="location.href='notice_edit.jsp?n_num=<%= board.getN_num() %>&pageNum=<%= pageNum %>'">&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" id="delbtn" value="�ۻ���" onclick="location.href='notice_delete.jsp?n_num=<%= board.getN_num() %>&pageNum=<%= pageNum %>'">&nbsp;&nbsp;&nbsp;&nbsp;
					<% }} %>
					<input type="button" value="�۸��" onclick="location.href='notice_list.jsp?pageNum=<%= pageNum %>'">
				</td>
			</tr>
		</table>
	</center> --%>
	
	<br><br><br><br>
	<center>
		<div class="table-responsive">
				<div style="width:900px; padding-right: 700px; text-align: left;">
					<p>
						<h2>Notice</h2>
						���� ���� �� �о� �ּ���~
					</p>
				</div>	
			<table class="table" style="width: 900px;">
				<tr>
					<td style="width: 120px;">SUBJECT</td><td ><%= board.getN_title() %></td>
				</tr>
				<tr>
					<td style="width: 120px;">NAME</td><td><%= user_id %></td>
				</tr>
				<tr>
					<td colspan="2" height="400px"><%= board.getN_content() %></td>
				</tr>
			</table>
			<div style="width: 900px;">
				<button style="float: left;" class="btn btn-outline-dark" onclick="location.href='notice_list.jsp?pageNum=<%= pageNum %>'">���</button>
					<%  if(user_id!=null) {  //������ ���̵�� ������ ���� �۾��� ��ư ����
						if(user_id.equals("admin")){	
					%>
				<button style="float: right;" class="btn btn-outline-dark" id="editbtn" onclick="location.href='notice_edit.jsp?n_num=<%= board.getN_num() %>&pageNum=<%= pageNum %>'">
				����</button>
				<button style="float: right;" class="btn btn-outline-dark" id="delbtn" onclick="location.href='notice_delete.jsp?n_num=<%= board.getN_num() %>&pageNum=<%= pageNum %>'">
				����</button>
				<% }} %>
			</div>
			<br><br><br><br>
			<table class="table" style="width: 900px;">
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