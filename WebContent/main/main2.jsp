<%@page import="java.util.ArrayList"%>
<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
  
<%
 	
	String pageNum = request.getParameter("pageNum");

	
	if(pageNum == null){
		pageNum = "1";
	}
	
%>	
	
</head>
<script src="../js/jquery.js"></script>
<script src="../js/jquery.bxslider.js"></script>
<script>
	    $(function(){
	         $(".slide_gallery").bxSlider({
	             mainSlides:3,   //열자마자최소 4개
	             maxSlides:3,    // 열자마자 4개까지
	             slideWidth:200, //슬라이드길이
	             slideMargin:30, //슬라이드간격
	             auto:true,
	             autoControls:true,
	             
	            speed:100
	         })
	        });
	    
        $(window).resize(function() {  
            var a  =   $(".body_div").width();
                console.log(a);
            document.getElementsByClassName("body_div");
        });
        
        
      
        
        
        function sendRequest() {
   		  	var send = $("#searchinput").val(); 
   		 	document.getElementById("main_stat_point").style.display = "none";
   		 	document.getElementById("main_stat_point2").style.display = "block";
   		 if(send==""){
   			 document.getElementById("main_stat_point").style.display = "block";
   			 document.getElementById("main_stat_point2").style.display = "none";
   		 }
   		$.ajax({
   			url:"../search/search2.jsp",
   			type:"post",
   			data:{"search":send},
   			success:function(data){	
   				document.getElementById("main_stat_point2").innerHTML =data;
   			},
   			error:function(){
   			document.getElementById("main_stat_point2").innerHTML ="<h3>fail</h3>";
   			}
   		});
   	}
</script>

<link rel="stylesheet" href="./../css/main.css" type = "text/css">
<%-- <jsp:include page="mainClass.jsp"></jsp:include> --%> 
<%@include file= "mainClass.jsp"%>  
<body>
	
      <jsp:include page="mainHeader.jsp"></jsp:include> 
       <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel" style=" width: 92%; margin: auto" > 
					  <div class="carousel-indicators" >
					    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
					    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
					    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
					  </div>
					  <div class="carousel-inner" style="width: 100%; " >
					    <div class="carousel-item active">
					    <a href="./../cart/goodsDisplay.jsp?product_number=1" style="border: 1px solid yellow;">
					      <img  src="../images/products/04.jpg" class="d-block w-100" alt="이미지없음">
					      </a>
					    </div>
					    <div class="carousel-item">
					    <a href="./../cart/goodsDisplay.jsp?product_number=1">
					      <img   src="../images/products/02.jpg" class="d-block w-100" alt="이미지없음">
					      </a>
					    </div>
					    <div class="carousel-item">
					    <a href="./../cart/goodsDisplay.jsp?product_number=1">
					      <img   src="../images/products/03.jpg" class="d-block w-100" alt="이미지없음">
					      </a>
					    </div>
					  </div>
					  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
					    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
					    <span class="visually-hidden">Previous</span>
					  </button>
					  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
					    <span class="carousel-control-next-icon" aria-hidden="true"></span>
					    <span class="visually-hidden">Next</span>
					  </button>
		  </div>		
	  <div class="body_div" >  
		  <div class="main_stat_point2" id="main_stat_point2"></div>
		  <div class="main_stat_point" id="main_stat_point">
		      <div class="maindiv">
				
				  
				  <div style="height: 66px; margin-bottom: 25px;">
				  </div>
				  
				  <div class="maintitle">
				 		BEST ITEM
		  		  </div>
		  		  <div class="goods">
	<%					
					//1번for시작
					for(int count=1; count<=3; count++){  //상품종류추가시 카운트업 
						if(count == 1)
							category_code = "상의";
						else if(count == 2)
							category_code = "하의";
						else if(count == 3)
							category_code = "신발";
						
						GoodsDBBean productdb = new GoodsDBBean();
						ArrayList<GoodsBean> CategoryProductList =productdb.getCategoryProductList(category_code,pageNum); //종류 리스트들을 넣고 
						ArrayList<GoodsBean> productlistArr  =  productdb.getProductimg(CategoryProductList); // 상품이미지를 불러옴
						
						int j = 0;
					/* 	if(count==1 && CategoryProductList.size()!=0){
						   out.println("<h1>상의</h1>");
					    }else if(count==2 && CategoryProductList.size()!=0){
						   out.println("<h1>하의</h1>");
					    }else if ( count==3 && CategoryProductList.size()!=0){
						   out.println("<h1>신발</h1>");
					    } */
						
						int size = 0;
				     	if(CategoryProductList.size()%4 != 0){
				     		size = CategoryProductList.size()/4+1 ;
				     	}else{
				     		size = CategoryProductList.size()/4;
				     	}  
				     	//2번for 문
				     	out.print("<table>");
				     	for(int i=0; i<size; i++){
				     		out.print("<tr>");
				     		int num =i*4;
				     		//3번 for 문
				     		for(j=0+num; j<=3+num; j++){
				     			if(CategoryProductList.size()==j) break;
				     		
					     		product_number= CategoryProductList.get(j).getProduct_number();
								category_code = CategoryProductList.get(j).getCategory_code();
								product_name = CategoryProductList.get(j).getProduct_name();
								product_price =CategoryProductList.get(j).getProduct_price();
								product_stock = CategoryProductList.get(j).getProduct_stock();
								product_desc = CategoryProductList.get(j).getProduct_desc();
								product_hits = CategoryProductList.get(j).getProduct_hits();
								ArrayList<GoodsBean> getGoodsimg = productdb.getGoodsimg(product_number);
								
								file_number =productlistArr.get(j).getFile_number();
								orgin_file_name = productlistArr.get(j).getOrgin_file_name();
								stored_file_name = productlistArr.get(j).getStored_file_name();
								stored_thumbnail = productlistArr.get(j).getStored_thumbnail();
								delegate_thumbnail =productlistArr.get(j).getDelegate_thumbnail();
								file_size = productlistArr.get(j).getFile_size();
								create_date = productlistArr.get(j).getCreate_date();
								delete_check = productlistArr.get(j).getDelete_check();
								
								String orgin_file_namearr[] = orgin_file_name.split("/");
								String stored_file_namearr[] = stored_file_name.split("/");
								//파일존재확인
								File file = new File(path+"\\"+stored_file_namearr[0]);
								boolean isExists = file.exists();
								/* if(isExists) { System.out.println("I find the existFile.txt"); } 
								else { System.out.println("No, there is not a no file."); }
								 */
	%>	
								<td>
									<table>
										<tr>
											<td class="mainalinkimg">
												<%if(isExists){%>
												 <a href="./../cart/goodsDisplay.jsp?product_number=<%=product_number%>">
													<img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%=stored_file_namearr[0]%>"  alt="../images/products/noimg.png">
												 </a>
												<%}else{%>
												  <a href="./../cart/goodsDisplay.jsp?product_number=<%=product_number%>">
													<img src="../images/products/noimg.png"  alt="이미지없음">
												  </a>
												<%}%>
											</td>
										</tr>
										<tr  style = "cursor:pointer;" onclick="location.href='../cart/goodsDisplay.jsp?product_number=<%=product_number%>'">
											 	<td style="border-bottom: 1px rgba(0, 0, 0, 0.09) solid; line-height: 30px;">	
											 			<%=product_name %>
											 	</td>
											
										</tr>
										<tr>
											<td style="color: rgb(0, 139, 204); line-height: 15px;">판매가 :<%=product_price%> won</td>
										</tr>
									</table>
								</td>
						
	<%						
				     		}//3번 for 마지막 
				     		out.print("</tr>");
						}//2번for 마지막
				     	out.print("</table>");
	%>
				     	 <%-- <%= GoodsBean.pageNumer(4,"main") %> --%>
	<% 
					} //1번for 마지막
	%>
		  		  </div>
			  </div>
			</div>  <!-- main_stat_point -->
			 
			
			<jsp:include page="mainfooter.jsp"></jsp:include>
			 
      <div><!-- body_div -->    
</body>
</html>