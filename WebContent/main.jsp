
<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./../css/main.css" type = "text/css">
<%-- <jsp:include page="mainimg.jsp"/> --%>

<%

	String path = request.getRealPath("./");
		 path = path+"\\upload"; //폴더 경로
		 File Folder = new File(path);
		
		// 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
		if (!Folder.exists()) {
			try{
			    Folder.mkdir(); //폴더 생성합니다.
			   // System.out.println("폴더가 생성되었습니다.");
		        } 
		        catch(Exception e){
			    e.getStackTrace();
			}        
	   }
		
	 path = request.getRealPath("upload");
	//System.out.println("@@@@@@@@@@@@"+path);
	request.setCharacterEncoding("UTF-8");
	int product_number = 0;
	String category_code = null;
	String product_name = null;
	int product_price = 0;
	int product_stock = 0;
	String product_desc = null;
	Timestamp product_date = null;
	int product_hits = 0;

  int product_number2 = 0;
  int file_number = 0 ;
  String orgin_file_name= null;
  String stored_file_name= null;
  String stored_thumbnail= null;
  String delegate_thumbnail= null;
  int file_size= 0;
  Timestamp create_date= null;
  String delete_check= null;
	
 
%>
	
    <meta charset="utf-8" /> <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js">
    </script> <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js">
    </script> <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap-5.1.3-dist/css/bootstrap-grid.min.css">
    
    
    <link rel="stylesheet" href="../fontstyle/fontello-4581031e/css/fontello.css">
    <link rel="stylesheet" href="../css/jquery.bxslider.css">

  	
</head>
<script src="../js/jquery.js"></script>
<script src="../js/jquery.bxslider.js"></script>
<script>
	    $(document).mouseup(function (e){  //검색 외클릭시 숨김
	        if($("#searchbox").has(e.target).length === 0){
	        	$("#searchinput").val("");
	        	sendRequest();
	        	document.getElementById("main_stat_point2").style.display = "none";
	        	document.getElementById("main_stat_point").style.display = "block";
	            $("#searchbox").hide();
	            $("#hearder_title").css("margin-bottom","40px");
	        }
	    });

    
	   function selectbox(){ //검색 클릭시 ㄴ타남   
	        const sebox = document.getElementById('searchbox');
	        const inbox = document.getElementById('searchinput');
	        const hearder_title = document.getElementById('hearder_title');
	            sebox.style.display = 'flex';
	            hearder_title.style.marginBottom = '6px';
	            inbox.focus();
	    }

	    $(function(){
	         $(".slide_gallery").bxSlider({
	             mainSlides:3, //열자마자최소 4개
	             maxSlides:3, // 열자마자 4개까지
	             slideWidth:200, //슬라이드길이
	             slideMargin:30, //슬라이드간격
	             auto:true,
	             autoControls:true,
	             
	            speed:100
	         })
	        });
        $(window).resize(function() {  
            var a  =   $(".body_div").width();
                console.log(a 
            );
            document.getElementsByClassName("body_div");
        });
        
        function sendRequest() {
   		  var send = $("#searchinput").val(); 
   	
   		 //alert(send);
   		 document.getElementById("main_stat_point").style.display = "none";
   		 document.getElementById("main_stat_point2").style.display = "block";
   		 if(send==""){
   			 //alert(send);
   			 document.getElementById("main_stat_point").style.display = "block";
   			 document.getElementById("main_stat_point2").style.display = "none";
   		 }
   		$.ajax({
   			url:"../search/search2.jsp",
   			type:"post",
   			data:{"search":send},
   			//data:{"search":send,"zipcode":"12345"},
   			//dataType,
   			success:function(data){	
   				document.getElementById("main_stat_point2").innerHTML =data;
   			},
   			error:function(){
   			document.getElementById("main_stat_point2").innerHTML ="<h3>d fail</h3>";
   			}
   		});
   		
   	}

</script>
<%

	String user_id = null;

	
	if(!((String)session.getAttribute("user_id") == null)){
		user_id =(String)session.getAttribute("user_id");
	}
	
%>
<body>
    <div class="body_div" >
        <header>
            <div class="d-flex justify-content-between" >
                <nav class="nav navbox">
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
                <ul class="nav justify-content-end ulbox">
                	
                    <!-- <li class="nav-item">
                    <a class="nav-link" href="#"> <span>&#xe802</span>Link</a>
                    </li> -->
                    <li class="nav-item">
                    <a class="nav-link" href="../cart/viewCart.jsp"><span>&#xf218</span>장바구니목록</a>
                    </li>
                    <!-- <li class="nav-item">
                    <a class="nav-link" href="../product/interested_items.jsp"> <span> &#xf218</span>찜목록</a>
                    </li> -->
                    <li class="nav-item">
                    <a class="nav-link" href="#" onclick="selectbox()"> <span> &#xe800</span>검색</a>
                    </li>
                
                </ul>
            </div>

           

            <div class=" d-flex justify-content-center" id="hearder_title" > 
                <div class="header_title" >
                    shopping mall
                </div>
            </div>
            <div class="d-flex justify-content-end searchbox"   > 
               <div class="search"  id="searchbox" >
                	<form action="../search/search.jsp" method="post">
                    	<input type="text" id="searchinput" name="searchtext" onkeyup="sendRequest()" style="width: 100px">
                   	 	<input type="submit" value="&#xe800">
                  	</form>
                   
               </div>
            </div>
            

            <ul class="nav justify-content-center header_footer">
              
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
                <!-- <li class="nav-item">
                    <a class="nav-link disabled">Disabled</a>
                </li> -->
            </ul>
        <!-- <aside>
            <a href="#up">↑</a><br>
            <a href="#down">↓</a><br>
        
        </aside> -->
        </header>
		<div id="up"></div>
        
        <div class="main_stat_point2" id="main_stat_point2"></div>
        <div class="main_stat_point" id="main_stat_point">
	        <main>
	            
	            하의	
	        		
	          <!--   <div class="d-flex justify-content-center zinde" id="multipleWrap"> 
	                <ul class="slide_gallery">
						<a href="./../cart/goodsDisplay.jsp?product_number=1"><li><img src="../images/serverimgs/pic_1.jpg"> </li></a>
						<li><a href="./../cart/goodsDisplay.jsp?product_number=2"><img src="../images/serverimgs/pic_2.jpg"></a> </li>
						<li><a href="./../cart/goodsDisplay.jsp?product_number=3"><img src="../images/serverimgs/pic_3.jpg"></a> </li>
						<li><a href="./../cart/goodsDisplay.jsp?product_number=4"><img src="../images/serverimgs/pic_4.jpg"></a> </li>
						<li><a href="./../cart/goodsDisplay.jsp?product_number=5"><img src="../images/serverimgs/pic_5.jpg"></a> </li>
						<li><a href="./../cart/goodsDisplay.jsp?product_number=6"><img src="../images/serverimgs/pic_6.jpg"></a> </li>
						<li><a href="./../cart/goodsDisplay.jsp?product_number=7"><img src="../images/serverimgs/pic_7.jpg"></a> </li>
						<li><a href="./../cart/goodsDisplay.jsp?product_number=8"><img src="../images/serverimgs/pic_8.jpg"></a> </li>
	                </ul>
	            </div> -->
	   <%
	   
	   	for(int count=1; count<=3; count++){  //상품종류추가시 카운트업
	   		if(count == 1)
	   			category_code = "상의";
	   		else if(count == 2)
	   			category_code = "하의";
	   		else if(count == 3)
	   			category_code = "신발";
	   %>
	
	   
				<table border="1">	
					<%
					int j = 0; 
				
					 
						GoodsDBBean productdb = new GoodsDBBean();
						ArrayList<GoodsBean> CategoryProductList =productdb.getCategoryProductList(category_code); //종류 리스트들을 넣고 
						ArrayList<GoodsBean> productlistArr  =  productdb.getProductimg(CategoryProductList); // 상품이미지를 불러옴
			
					  if(count==1 && CategoryProductList.size()!=0){
						   out.println("<h1>상의</h1>");
					   }else if(count==2 && CategoryProductList.size()!=0){
						   out.println("<h1>하의</h1>");
					   }else if ( count==3 && CategoryProductList.size()!=0){
						   out.println("<h1>신발</h1>");
					   }
					
					
				
					 int size = 0;
			     	if(CategoryProductList.size()%3 != 0){
			     		size = CategoryProductList.size()/3+1 ;
			     	}else{
			     		size = CategoryProductList.size()/3;
			     	} 
			     
					
					for(int i=0; i<size; i++){  //상품 종류 3개씩 출력
			//size ==3
						 %>
						 
						 	<tr>		 	 
						                <%
						                int num =i*3;
						                             
			               		for( j=0+num; j<=2+num; j++){ //3개씩출력하고 줄바꿈 
						                		
						                		
				               		if(CategoryProductList.size()==j) break;
				               		%>
							 		 <td>
									  <div class="container" style="margin: 0; padding: 0;">
							  			<div class="row"  style="margin: 0; padding: 0;">
							 		 		<ul class="nav justify-content-center header_footer">
							             <%     
						     	    			
									product_number= CategoryProductList.get(j).getProduct_number();
									category_code = CategoryProductList.get(j).getCategory_code();
									product_name = CategoryProductList.get(j).getProduct_name();
									product_price =CategoryProductList.get(j).getProduct_price();
									product_stock = CategoryProductList.get(j).getProduct_stock();
									product_desc = CategoryProductList.get(j).getProduct_desc();
									//product_date = CategoryProductList.get(i).getProduct_date();
									product_hits = CategoryProductList.get(j).getProduct_hits();
									
									file_number =productlistArr.get(i).getFile_number();
									//product_number2 = productlistArr.get(j).getProduct_number();
									orgin_file_name = productlistArr.get(j).getOrgin_file_name();
									String orgin_file_namearr[] = orgin_file_name.split("/");
									
									/* for (int j = 0; i < orgin_file_namearr.length; j++) {
										System.out.println("불리된 문자열 "+ i +":" + orgin_file_namearr[i]);
									} */
									
									stored_file_name = productlistArr.get(j).getStored_file_name();
									String stored_file_namearr[] = stored_file_name.split("/");
									
									
									stored_thumbnail = productlistArr.get(j).getStored_thumbnail();
									delegate_thumbnail =productlistArr.get(j).getDelegate_thumbnail();
									file_size = productlistArr.get(j).getFile_size();
									create_date = productlistArr.get(j).getCreate_date();
									delete_check = productlistArr.get(j).getDelete_check(); 
							 		//System.out.println(path+"\\"+stored_file_namearr[0]);
							 		 //path = request.getRealPath("upload");
							 	System.out.println(request.getServletPath()+File.separator+".."+File.separator+"upload"+ File.separator+stored_file_namearr[0]);
							 	
			%>	
						  	<img src="<%=request.getServletPath()+File.separator+".."+File.separator+"upload"+ File.separator+stored_file_namearr[0] %>">
									  
								   	 <li class="nav-item">   	  
							    		   <div class="card" style="width: 18rem;">
											   <a href="./../cart/goodsDisplay.jsp?product_number=<%=product_number%>"><img src=" <%=path%>\<%=stored_file_namearr[0]%>" style="width: 300px; height: 300px;" alt="이미지없음"></a>
											   <%-- <a href="./../cart/goodsDisplay.jsp?product_number=<%=orgin_file_namearr[0]%>"><img src="./../images/products/<%=stored_file_namearr[0]%>.jpg" style="width: 300px; height: 300px;"></a> --%>
											  <div class="card-body" style="margin: 0px; padding: 0px;">
											    <table border="">
											    	<tr>
											    		<td width="80px" style="text-align: center">상품이름:<%=product_name%></td>
														
														<td width="80px" style="text-align: center">상품가격:<%=product_price %></td>
													</tr>
													<tr>
														<td  colspan="2" width="100px" style="text-align: center">상품재고량:<%=product_stock%></td>
													</tr>
											    </table>
											  </div>
										   </div>
									  </li>
						  
				  	 	
				        			
				            	</ul>
				           </div>
						</div>
			         </td>
				            	<%
					  		
				               	}
				             
				                %>
			       </tr>    	
						
			<%
			         	} 
			%>
			</table>
		
		
		<%
	   	}
		%>	
			
			
	
	          <!--   <table border="1">
	                <tr>
	                    <td><a href="./../cart/goodsDisplay.jsp"><img src="data:image/jpeg;base64,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"> </a><br> 1</td>
	                    <td><a href="#"><img src="data:image/jpeg;base64,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"></a><br> a</td>
	                    <td><a href="#"><img src="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAoHCBYWFRgVFRYYGBgaGhgYGBoaGhgYGhgYGBgZGRgYGBgcIS4lHB4rIRgYJjgmKy8xNTU1GiQ7QDs0Py40NTEBDAwMEA8QGhISHjQhISE0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDE0NDQ0NDQ0NDQ0NDE0MTQxMf/AABEIALEBHAMBIgACEQEDEQH/xAAbAAABBQEBAAAAAAAAAAAAAAACAAEDBAUGB//EADUQAAIBAgMFBwMDBAMBAAAAAAABAgMRBCExBRJBUWEGInGBkbHwE6HBMtHhFBVC8VJysiP/xAAZAQADAQEBAAAAAAAAAAAAAAAAAQIDBAX/xAAhEQEBAQEAAgIDAQEBAAAAAAAAAQIRAxIhMQRBUSJhE//aAAwDAQACEQMRAD8A42wkOMJucewkOyQVhxCAEIZBXAGEIQA6QcabfAubOwm87NHSYbZcEu8rme/NnP20zi6cthsLKT0NOnsZ8Tp8NgYrOMUS/QZy6/K/jXPh/rm1sZO9yWjsJbyzyNLENxuRYfFd6xnPPppfDOIV2cWf2KuN2M4qTSzf2zX8nWQnkNJp3K/99M/R59PZM00raq/h0LNPYkrXfzI7KUFyI3Yd/J0c8McbPZMr6aZv9ilUwzVsuGfud5OmrFepgoS4IrP5P9F8P8cLKjLl8RG4M7xbOhy6FXG7DhLTJmmfyc37Z3xWOMaGNLFbOnD/AB6FaOHfHhqdE1Ky4rCJ5UnyZEo8FqV0cMwbBgsRBEOxigQhCQAQgUwgFCxCYgBxXGESBXEmMOgAhCEAMyShTu/wRo19hYVSnd6LMW9TObVZnbxubNwahFSas2jUw2bzKWKrW0IsPiszyt6ur13YxyOljFLNEFaskndozv7jYz605zT5dSOdVnP9WsVWUvYgwuH7135EeGovVl2L9R84q39RchMdVCvCTE5iqOJpTA3iv9Qkjdgrg5yGUyOQ6eQxxLGZNBlXeJITEVi46MZLNIysZs6m28rGhCZRx0msy871PpnMS35ZOJ2OrXg+Gn8mLicK4J5O/XkdbRmgq+GjNWaXQ3x+RZ8aRvw/xwbRGzosfsfcTkzAqRsduNzU7HNrNn2jEKwmaJIQhgB0EAPcBSYhwZSAHCQMRyQQ4hMAdBMBMe4A8VfI6rZWDUIb2d2jB2RT3qkVwvn5HWV9Mjl/I3yerfwZ7eqWKncowlLRX8i1VfAmjeMMmn5L3OWO3vFZSTynJrw18y1Gusox068SnDDOT7y4/LmlRopINchWjg2SxkNYfcuZ0C3hIjlCwcGBj3USwRCpB72YFTzQkshlmw20BIJZZv0EpksolepGzuBrMag2ISkivGZJGdwTUNCkW7ELlu66E0aqtdE6X3p501OO7I4fa+GcJta9TtlUVzG7QqPJaHV+NqzXHN5s/HXJDElRq+SI5TPQchMEFyBcigkuK5HvDpgKmkyIObAYAcWEmBEMkDGaEhwALCYUgbAGv2emlO3E6CvLmc1sOVqnPI6aGHcn0OL8if6dXgvIpTpOTyLVPBv/AC0NOnSihpx5M5rpv7dVowSyHVuA84v4wd0npjSHbAl4eY1uen3XJgot5BuRC55/MwXVtn6efQOBLv5/Odhb1s+JFKovD/eYovNZ6XuPgWU7Lm/moUSpGqpfi2n8hKfAVhcWVIinASdskGqgBVnG2iHhPr90TzjfgRKLv+n7jhJm4tWdvcp1KjhlquBbhbw8yhtODtdXfPIcnfgS8PDF3Zj9o8XFTSfItYe9+JxfaPGSnVk72SyXlyOr8Xx90x8+v8p54yPMhnjEYzbCSPS9I42n/VoX9VczbE1EVzAvqbZPTpuwOHL0HkZ2nYrtgsjeIRHPFRHyktwZImZqxyFLaKH60NLeHUjIe0gZbSD1obEpAb65mLPaDZC8XIqeOh3XZyovqpZN5ncKnZHB9gtn1HNVZq0bO1+p6M4HmflT/Tfx6+FSNPO4NZdC7uWK9eBy1tL2qLRHu3CnO2QMZg1DNWXuBFrW5K2iGq1HP9vtkCgTn58uD9PQjnUyssny/cgnW626W+w3023eOd9Vfh7IuZCda5XWWb1t8zChDVJ/vzs/UBrLklrw58h4Sjeyi7LjfXXR88kgB9NbX/gKM7c3w/0JK+dvNNWXLrcD4r8+tl9xBYhbj6X/AAHez09it9RLVPx19skSwm9dejXtYXAnjN8fcOcGwKduWfRe5PGfQSajjHmNOnkTLxJN264D6isGaUVJ8r6/uebbQq705PjdnpnaG1OjOeuXueV1q2872PS/Dz96c/m1+gJBIFMJSO5gceLGTE0INHDVi/CpkYEJtF2hVdjO5O1m1JPefi/cBtl+jh022+b9wcTQsa+07wlG46i2JI1dn0FIetcgZbi0SYXDynJRjqbtTZLnojT7O7DlGd2jLXmkz39nwWyuxO+k5tnRYbsTTi13TqtmUFFLIvOSucOvNq37VyKtLBRpwUYpIJIsy7xFBGG/lWaFxKuIRdkinXjrmY1rlj4mmVnUs7WsXMTO2iMerWk3ll1DM66I0JVLLh5/Myhi8Xk88+SH+m3nJ/chnOnDV38Fc0zhN1Ix6tSd3JviaWGxKilva6pfllatioTaSXG2eWZI6UZLLLp0Nbn4+YJrq3HFZPdeb4Xul4L8DYevvN9eaXO/8mS4NXtfl6FvDPcavp9+r6k3MPrYjLRWu1lz8yeKy5PjbkU44qOST1te/rl9vQszxUdU+H5+5lZR0NSPO3iv3C3HzyIJ1k2rO3TKwdOpbX14fwLlV1ZhPyaDjPn89CJ5/wC/lxlFX+exPAswl81+5cpq5Rw5p0o3QmerxzPbyuo4ZxvnJpWPLY0zte2mJdStuK+7D0b5mDDCnrfj/wCMSf1x7vazY4dkscIzXp4XoXaeFNL5anjChgmWYbP6G5DDdCzTw3Qzvkp8YdPZfQsf2tG7DDvkPVpPlwIvktKxx+HwzuWZ7OckXadSKLMMVFci7rXTkYsNgNm1szYe6Sw2hBcUTx2zBcUTrW6Phu4PZsFyNbD4SK0RyuG24pSUIZyeiR2ezsPJRTnqzn3LPtXf4s0oeRYhSiBYZsy9ofKsbi4FW1mx/qAOpcLewScKbKdZ8EW5u40aaMdNc3jLlhb5shls9X0NxU0VqtJphFTVecdr3OEklJpZteV/2OR+rKf66s0vOV81luprhd+R6j2h2aqkbpd5Xt58LHm+K2PVg2t2/J3s/NM9P8bWPXn7Z+Wa6q4Kq4yUbtq/vl+F9zdeL3ZLelZLK/kZ+GwcaS362vCKf/pkmBnN71Tdvd/LL5oaeTl+T8fY3qqTXPLho/S48INq/X7aFOdfeeUJdcnbyuamzaTfPzy8nY5NTjaBw9PevnxJKtWMI5tJdbGJtWrOFWVnZOzyvbqU8fCcqKqubaeSz0V7FZ8Pty9+KnXk9W4tow/xehPQ2ipf5ZrTP7Hn13fJs6XY2zJO0pJl+TwZzO9TnyXTqKeN3tPRe6LsJ73zO5nU8Hu8MzRwtCT1Rxak/TX2XMPY16UlYqYbB6ZGtRwnQzk+We9Ry+2Oz0Jtzjrx6mRDYvQ9Cnh7FKeHVzqz5LzjnsclDY/QsQ2R0OlVFCdMq7pcYcNlrkWYbORrKAyiT702fHAorYzBq68Pyzb3CljV3l4flhKTxOeKnd58X7g/Wm+LOlp7AbztqWYbAXI775cRElcjeb4svbO2bUqyUY5vkdZQ2Cr6Hcdnuz8KSU7Xk+PIy3+RJPhXrZ9qfZjsjCglOXenbXgvA6lUg7j7xw63dXtVID6YEoE1wWI1Guig69maeJjkc7jalnYeYqfLZhNMkdQ5/A7TilaUrGpHEKSvBpi1jgn2tqoKTvxM51WnqWI11zz6GfGnBTpJrMwdqYFtpQtd+GXU1sTXa/Tm3w4gUt9vq9X7ly8VOsPD9l01vVHvNPJWjJJdW43LkNmU1nZfOBuVIOK6WORx+3JqbjCKydnKWfor/c0k1oTXGjPCwvfd9idYRNXVkY9LbU1+uCl1T3fVGns3a0Kj3N1wn/xfFc0yLjUV7Ri7X2I3ecEnK2V1nfplkcy9nznFw32lfvRysnrk+GZ6s8KtW7nL7WwG5U34q8Zfq5xfPwNfH5bPhGpNMXZvZiEHvSTb65nT4XBJLJdENhK1NLW75czoMBQ3lvPjw5E73rV+SvMz4U8Pszi1maNLZ6RdhTJkjP1/rK6qGlh0izGIosTY5EW2lOCMqvHM1ZPIyq8rvzKEBANRAHXMDFuCUB4thJMAHdKON/UvD8s0NwpY2PeXh+WVCrLp4Vbqy4L2DjhC9Rh3Y+C9iRQCnLxFs/BpzV9FmdHGBm4BWuacRVNvTbg7gGh2TYOokgZhyIakhHFevyOW2zGz3kzpMRO17nK7Vrdyfg2Vj7aZc5XrZsl2ZthwlZyyevExK2K5EGHoVZy7kWdcxLPktV6VTrxmt6LuiaEraI5TY9GtTs5Zx5HU4aonq/nU5d49b8LzrsX8LBWvxZoQprVGPTrqLutOJo08TFrJmfBbUuKinF5HknaapJTnCNr72t7OPFNW1+x6jisYlFnm/aHCOpUcoPvP0yva75nT4OS/KL3jPW05Rg3rKMV5yZrdmv8A6zhmpSupytlbp0MHDbOrTut22ed8m7fjI7zsvs76UFd3k3eT4eCXCxr5fWZvPsZ1bXWuNonL7YlKTcba5avQ6iU+7YwtqzhCLnJrLrY4p9tJeOd2RBKtuclo+p6BhcopHk8cVJ1d+CzWadnutcU22k/FL3Oz2f2mgoP6l4SSzTulpqm1n5G+8X7Z3XXWqQ7qLizBqbepxpqpKW7F6X/ZZmdsnainJydSM95uyUk8rtrLhYz9bzpcdfCquY8qhyu0sdeK3I1JtytanGTvzz0XqS/1WJmkqdHdWm9UkopW1uldsJKLI6JYmO68zNpz3nfXPIq4bZVR3U5pJ67vPpfga9LDxirL15/yIfSKKbdiRU/VehI4Z8vyJ/YRIm7aeo6evL3Ct42+cRpJvohgrXzzRm7RvvLw/LNHd8vW5nbQfe04fljyVSUY92PgvYMUF3I+C9gm+Awlw07NrzL9OoZFSUo95J/uUFtSpGTvTnu31Sv7C50cdTvilM5z+8Tk7KE3yajJ+uQ9fGVp7u5Cdnr3Wv8A1YXKfq3Z1kitOurNtmUp4ia/Ru/9nb1Aex6so2niLNu9oQ06XbzFw+RDtfakYR8dFxfgc3UwlfEvdUZRj6HZw2NSVnJOcl/k3oXYwSskrF516/Q64nCdjlF3lmzaw+x1D9KszoUvIFx/3b3C7t+x1ztfZc5N2yXv5lWGx6kc4s6xrOzfQSitA9qOuPnhcT/xTXDP8EMoYlK/02/Br8nb7nFaDyp8/EXt/wAP2efzq1Gu9Ge9yaeV+SM2vSxEv0Qnqrd1+h6hGCvf8BbmjWX2Lzvn6FvXm+HwmMuk6L87Ry8b+5t4Oli4vddFeKnF+p1rhfzHUPUWt9/RS8Zawta2coLwuyP+xQk71G55aNtRXguPmbDjw/0N86EdHtaqUNnUoW3YK1raaeBLDCxTUtyPK9k3Yntp8QnxtmHSQRwkFZ7kE/8ArFPPXQkhRilZRjFLPRIlkvUSXHiACnZeOi0uKXPToE48wXJLqIyzev2GcL9BL7hX4sCAk+ISXPQS1uMpXdwAlms1kA1cKb6jSldZDBoxvmUcfLvLw/LLUp8EUMa3vLw/LHkrFygluR45L2DUOaGoQ7kb8lb0DguoUGivMKHReQ6jrkJy6CB4+nt6juT8hl4BWAGfMZv508QmvP5yH3QMDjcThzC+w8UANbx+cxOPEdxGsAPGPH0Gbu8h2JRyAE4jpP8AcSE07WAg6cBWJIoZvggAbCig+A1wAZx+4nHMSEtQMhMKw0kANcVuWQrD2ABzHlyHeQzAGtkLxHQziIFYUmBKQMmME3bIdKyG3OIMVcDNbiUMa+8vD8s1GihjY95eH5Y4TPofpXgvYKIhGlR+hTE9GIQgkpiiMIBTcRCEBiiMxCAFxQ6HEAMxkIQAcR2IQwEQhCBSGQ4gBkOIQALGEIAMFiEAISGEAFIZjCAAB4jiADegERCAHZUxmq8PyxCGH//Z"></a><br> a</td>
	                </tr>
	                <tr>
	                    <td><a href="#"><img src="data:image/jpeg;base64,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"></a><br> a</td>
	                    <td><a href="#"><img src="data:image/jpeg;base64,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"></a><br> a</td>
	                    <td><a href="#"><img src="data:image/jpeg;base64,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"></a><br> a</td>
	                </tr>
	            </table> -->
	     
	     
	     
	        </main>
	        <footer>
	            <table>
	                <tr>
	                    <td>회사소개</td>
	                    <td>|</td>
	                    <td>이용약관</td>
	                    <td>|</td>
	                    <td>개인정보취급</td>
	                    <td>|</td>
	                    <td>이용안내</td>
	                    <td>|</td>
	                    <td><a href="../customer_service/notice_list.jsp">공지사항</a></td>
	                </tr>
	            </table>
	            <div class="footerdiv" style="border: 1px solid black; width: auto; float: left; margin-left: 30px;">
	                <div style="font-size: 25px;">customer service</div>
	                <ul>
	                    <li>Tel 010-000-000</li>
	                </ul>
	                
	            </div>
	            <div class="footerdiv" style="border: 1px solid black; width: auto; float: left; margin-left: 30px;">
	                <div style="font-size: 25px;">customer service</div>
	                <ul>
	                    <li>Tel 010-000-000</li>
	                </ul>
	            </div>
	            <div class="footerdiv" style="border: 1px solid black; width: auto; float: left; margin-left: 30px;">
	                <div style="font-size: 25px;">customer service</div>
	                <ul>
	                    <li>Tel 010-000-000</li>
	                </ul>
	            </div>
	        </footer>
        </div>
    </div>
	    <script type="text/javascript">
	<%
		
		if(request.getParameter("searchCheck")!=null){
			if(request.getParameter("searchCheck").equals("false")){
				//System.out.println("검색한내용이없습니다.."+request.getParameter("searchCheck"));
				%>
				 	alert("검색한내용이없습니다..");
				
				<%
			}
		}
	%>
	</script>
</body>
</html>