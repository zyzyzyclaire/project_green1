<%@page import="login.UserBean"%>
<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style type="text/css">
.maindiv{
        margin: auto;
		min-width : 1120px;	
		max-width : 1280px;	
		margin-top: 30px;
		
}
.maindiv div:first-child {
	
	height: 138px;
	width: 138px;
	float: left;
}
.maindiv div:nth-child(2){
	width: 100%;
	border: 1px solid blue;
}

.u1div1{
	border: 1px solid green;
}
.buylist{
		border:1px solid black;
		
 		margin: auto;
		min-width : 1120px;	
		max-width : 1280px;
}
</style>
</head>
<body>
<%
	String user_id = null,user_name = null,user_grade=null;
	if(((String)session.getAttribute("user_id")) != null){
		 user_id  = (String)session.getAttribute("user_id");
		 UserDBBean udb =  UserDBBean.getInstance();
		 UserBean ubean = udb.getUser(user_id);
	  	 user_name = ubean.getUser_name();
	  	 user_grade = ubean.getUser_grade();
	}	else{
		response.sendRedirect("../login/login.jsp");
	} 
		
	
%>
<link rel="stylesheet" href="../css/nav.css" type = "text/css">
<jsp:include page="../main/mainHeader.jsp"></jsp:include>

	<nav class="nav2" >
		<nav style="--bs-breadcrumb-divider: '>'; font-size: 10px;" aria-label="breadcrumb" class="nav2div">
		  <ul class="breadcrumb ">
		    <li class="breadcrumb-item"><a href="../main/main.jsp">home</a></li>
		    <li class="breadcrumb-item active" aria-current="page">MY PAGE</li>
		  </ul>
		</nav>
		
		<div style="clear: both; font-size: large; color: black;">
			MY PAGE
		</div>
	</nav>
	
	<br>
	
	<div class="container">
		  <div class="row">
			    <div class="col-sm-3" style="width: 138px; height: 138px;">
			     	<img  src="../images/products/noimg.jpg" alt=""
						style="width: 138px; height: 138px; ">
			    </div>
			    <div class="col-sm-9" style="margin-left: 30px;">
				      <div class="row" style="border-bottom: 1px solid black;">
					        <div class="col-8 col-sm-6" style="font-weight: 600px; margin-bottom: 3px;">
					          	<%=user_name%>
					        </div>
					        <div class="col-4 col-sm-6">
					        </div>
				      </div>
				      
			          <div class="row" style="border-bottom: 1px solid black; border-top: 1px rgba(0, 0, 0, 0.09) solid; margin-top: 8px;">
					        <div class="col-8 col-sm-6  u1div1">
					          	<div class="container" style="line-height: 50px; ">
								  <div class="row">
								    <div class="col">회원등급: <%=user_grade%></div>
								    <div class="col">구매건수: 0건</div>
								   <!--  <div class="col">col</div>
								    <div class="col">col</div> -->
								  </div>
								</div>
					          	
					        </div>
					        <div class="col-4 col-sm-6">
					        </div>
					      
				      </div>
				      
			    </div>
		  </div>
	</div>
	
	<div class="buylist">
		<table class="table" style="margin-top:30px;">
		  <thead>
		    <tr>
		      <th scope="col">#</th>
		      <th scope="col">First</th>
		      <th scope="col">Last</th>
		      <th scope="col">Handle</th>
		    </tr>
		  </thead>
		  <tbody>
		    <tr>
		      <th scope="row">1</th>
		      <td>Mark</td>
		      <td>Otto</td>
		      <td>@mdo</td>
		    </tr>
		    <tr>
		      <th scope="row">2</th>
		      <td>Jacob</td>
		      <td>Thornton</td>
		      <td>@fat</td>
		    </tr>
		    <tr>
		      <th scope="row">3</th>
		      <td colspan="2">Larry the Bird</td>
		      <td>@twitter</td>
		    </tr>
		  </tbody>
		</table>
		
	</div>
	
<a href="../login/userOut.jsp">탈퇴</a>
	<a href="../login/userUpdate.jsp">회원정보수정</a>
	<a href="./userBuygoods.jsp">구매한상품조회</a>
	
</body>
</html>