<%@page import="java.util.ArrayList"%>
<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
  

	
</head>
<script src="../js/jquery.js"></script>
<script src="../js/jquery.bxslider.js"></script>
<script>
	   
	    $(function(){
	         $(".slide_gallery").bxSlider({
	             mainSlides:3,   //���ڸ����ּ� 4��
	             maxSlides:3,    // ���ڸ��� 4������
	             slideWidth:200, //�����̵����
	             slideMargin:30, //�����̵尣��
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
   			document.getElementById("main_stat_point2").innerHTML ="<h3>d fail</h3>";
   			}
   		});
   	}
</script>

<link rel="stylesheet" href="./../css/main.css" type = "text/css">
<%-- <jsp:include page="mainClass.jsp"></jsp:include> --%> 
<%@include file= "mainClass.jsp"%>  
<body>
	
      <jsp:include page="mainHeader.jsp"></jsp:include> 		
	  <div class="body_div" >  
		  <div class="main_stat_point2" id="main_stat_point2"></div>
		  <div class="main_stat_point" id="main_stat_point">
		      <div class="maindiv">
				  <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
					  <div class="carousel-indicators">
					    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
					    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
					    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
					  </div>
					  <div class="carousel-inner">
					    <div class="carousel-item active">
					      <img src="../images/serverimgs/pic_1.jpg" class="d-block w-100" alt="�̹�������">
					    </div>
					    <div class="carousel-item">
					      <img src="../images/serverimgs/pic_2.jpg" class="d-block w-100" alt="�̹�������">
					    </div>
					    <div class="carousel-item">
					      <img src="../images/serverimgs/pic_3.jpg" class="d-block w-100" alt="�̹�������">
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
				  
				  <div style="height: 66px; margin-bottom: 25px;">
				  </div>
				  
				  <div class="maintitle">
				 		BEST ITEM
		  		  </div>
		  		  <div class="goods">
	<%					
					//1��for����
					for(int count=1; count<=3; count++){  //��ǰ�����߰��� ī��Ʈ�� 
						if(count == 1)
							category_code = "����";
						else if(count == 2)
							category_code = "����";
						else if(count == 3)
							category_code = "�Ź�";
						
						GoodsDBBean productdb = new GoodsDBBean();
						ArrayList<GoodsBean> CategoryProductList =productdb.getCategoryProductList(category_code); //���� ����Ʈ���� �ְ� 
						ArrayList<GoodsBean> productlistArr  =  productdb.getProductimg(CategoryProductList); // ��ǰ�̹����� �ҷ���
						
						int j = 0;
					/* 	if(count==1 && CategoryProductList.size()!=0){
						   out.println("<h1>����</h1>");
					    }else if(count==2 && CategoryProductList.size()!=0){
						   out.println("<h1>����</h1>");
					    }else if ( count==3 && CategoryProductList.size()!=0){
						   out.println("<h1>�Ź�</h1>");
					    } */
						
						int size = 0;
				     	if(CategoryProductList.size()%4 != 0){
				     		size = CategoryProductList.size()/4+1 ;
				     	}else{
				     		size = CategoryProductList.size()/4;
				     	}  
				     	//2��for ��
				     	out.print("<table>");
				     	for(int i=0; i<size; i++){
				     		out.print("<tr>");
				     		int num =i*4;
				     		//3�� for ��
				     		for(j=0+num; j<=3+num; j++){
				     			if(CategoryProductList.size()==j) break;
				     		
					     		product_number= CategoryProductList.get(j).getProduct_number();
								category_code = CategoryProductList.get(j).getCategory_code();
								product_name = CategoryProductList.get(j).getProduct_name();
								product_price =CategoryProductList.get(j).getProduct_price();
								product_stock = CategoryProductList.get(j).getProduct_stock();
								product_desc = CategoryProductList.get(j).getProduct_desc();
								product_hits = CategoryProductList.get(j).getProduct_hits();
								
								
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
								//��������Ȯ��
								File file = new File(path+"\\"+stored_file_namearr[0]);
								boolean isExists = file.exists();
								if(isExists) { System.out.println("I find the existFile.txt"); } 
								else { System.out.println("No, there is not a no file."); }
	
							
							
	
							
	%>	
								<td>
									<table>
										<tr>
											<td class="mainalinkimg">
												<%if(isExists){%>
												 <a href="./../cart/goodsDisplay.jsp?product_number=<%=product_number%>">
													<img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%=stored_file_namearr[0]%>"  alt="�̹�������">
												 </a>
												<%}else{%>
												  <a href="./../cart/goodsDisplay.jsp?product_number=<%=product_number%>">
													<img src="../images/products/noimg.PNG"  alt="�̹�������">
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
											<td style="color: rgb(0, 139, 204); line-height: 15px;">�ǸŰ� :<%=product_price%> won</td>
										</tr>
									</table>
								</td>
						
	<%						
				     		}//3�� for ������ 
				     		out.print("</tr>");
						}//2��for ������
				     	out.print("</table>");
					} //1��for ������
	%>
		  		  </div>
			  </div>
			</div>  <!-- main_stat_point -->
			
			
			<jsp:include page="mainfooter.jsp"></jsp:include>
			 
      <div><!-- body_div -->    
</body>
</html>