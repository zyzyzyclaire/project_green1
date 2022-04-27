<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file= "mainClass.jsp"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
 <link rel="stylesheet" href="./../css/main.css" type = "text/css">
<script src="../js/jquery.js"></script>
<script>

	$(window).scroll(function(){ 
		
		var scroll = $(window).scrollTop();
		/* $("선택자").offset().top; *///특정요소 y 좌표값반환
		 console.log(scroll); 
		var height = 114;
		height = height-scroll
		$( ".header_title" ).css("height", height);
		
		
		if(scroll>=180-80){
			$( ".addstyle" ).addClass( "fixed");
			$( ".addstyle1" ).addClass( "fixed1");
			//alert("숨겨졌음");
		}
		else if(scroll<=50){
			
			//$( ".headertop2" ).hide();
			$( ".addstyle" ).removeClass( "fixed");
			$( ".addstyle1" ).removeClass( "fixed1");
			
		}
		//
	})
	window.onload = function () {
		$( ".headertop2" ).hide();
	}

</script>
<style type="text/css">
a {
	 color: rgb(34, 34, 34);
}
.fixed{
	position: fixed;
	
	text-align:center;
	z-index: 1;
	left: 0px;
	right: 0px;
	top:0px;
	background-color: white;
}
.fixed1{
	position: fixed;
	width:100%;
	text-align:center;
	top: 40px;
	/* margin-top: 13px; */
/* 	margin-top: 0.5%; */
	z-index: 1;
	left: 0%;
	right: 10%;
	background-color: white;
}
</style>
</head>
<body>
			
			
			
			<div class="addstyle"  style="color: rgb(34, 34, 34); ">
	            <div class="headertop" >
	            <div class="d-flex justify-content-between headerlinks " >
		                <nav class="nav navbox" >
			                <%
			                	if(user_id==null){
			                %>
			                	<a class="nav-link active" aria-current="page" href="../login/login.jsp"> <span>&#xf2c0</span> 로그인</a>
			                    <a class="nav-link" href="../login/register.jsp"><span></span>회원가입</a>
			                <%
			                	}else{
			                %>
			                	<a class="nav-link active" aria-current="page" href="../login/logOut.jsp"> <span>&#xf2c0</span> 로그아웃</a>
			                    <a class="nav-link" href="../userPage/userPage.jsp"><span></span>마이페이지</a>
			                <%
			                   if(user_id.equals("admin")){
			             	%>
			             		<a class="nav-link" href="../adminPage/adminPage.jsp"><span></span>관리페이지</a>
			                    <!-- <a class="nav-link" href="../product/productAdd.jsp"><span></span>상품등록</a> -->
			                <%						
								}
			                %>
			                   
			                <%
			                	}
			                	
			                %>  
		                </nav>
	                
	                
	                <ul class="nav justify-content-end ulbox"  style="margin-bottom: 0px">
	                	
	                    <li class="nav-item">
	                    	<a class="nav-link" href="../cart/viewCart.jsp"><span>&#xf218</span>장바구니목록</a>
	                    </li>
	                    
	                    <li class="nav-item">
	                    	<a class="nav-link" href="#" onclick="selectbox()"> <span> &#xe800</span>검색</a>
	                    </li>
	                
	                </ul>
	            </div>
			</div>
		
			</div>
           	<div style="border-bottom: 1px rgba(0, 0, 0, 0.09) solid; "></div>
			<div class="header_titlecheck">
	            <div class=" d-flex justify-content-center" id="hearder_title" > 
	                <div class="header_title" style="overflow: hidden;"> 
	                    <a href="main.jsp">shopping mall</a>
	                </div>
	            </div>
            </div>
            <div class="headersearchbox">
            	<div class="searchbox1"></div>
	            <div class="d-flex justify-content-end searchbox2"> 
	               <div class="search"  id="searchbox">
	                	<form action="../search/search.jsp" method="post" style="width: 180px;" class="searchform">
	                    	<input type="text" id="searchinput" name="searchtext" onkeyup="sendRequest()" style="width: 100px">
	                   	 	<input type="submit" value="&#xe800" id="searchbutton">
	                  	</form>
	               </div>
	            </div>
            </div>

            <ul class="nav justify-content-center header_footer headernav addstyle1" style="font-size: 11px">
              	<li class="nav-item">             		
              		<a class="nav-link" href="../customer_service/notice_list.jsp">공지사항</a>
              	</li>
            	<li class="nav-item">
                    <a class="nav-link" href="../product/productAllList.jsp">전체</a>
                </li>
                <li class="nav-item">
                	<a class="nav-link" href="../product/categoryProduct.jsp?category=1">상의</a>
                </li>
                <li class="nav-item">
                	<a class="nav-link" href="../product/categoryProduct.jsp?category=2">하의</a>
                <li class="nav-item">
                    <a class="nav-link" href="../product/categoryProduct.jsp?category=3">신발</a>
                </li>
            </ul>  
      

</body>
</html>