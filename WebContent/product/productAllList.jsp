<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	String path = request.getRealPath("upload");
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
		
		
 <%
			int j = 0;
			GoodsDBBean productdb = new GoodsDBBean();
         	
         	ArrayList<GoodsBean> productListArr = productdb.getProductlist();
         	ArrayList<GoodsBean> ProductImgListArr  =  productdb.getProductimg(productListArr);
         	
         	//ProductImgListArr.get(0).getFile_number();
         	
         	int size = 0;
         	size = ProductImgListArr.size(); 
         	
         	if(size!=0){
	         	if(ProductImgListArr.size()/3 != 0){
	         		size = ProductImgListArr.size()/3 +1;
	         	}else{
	         		size = ProductImgListArr.size()/3;
	         	} 
	         	//System.out.println(size);
	     		out.print("<table border='1'>");
	         	for(int i = 0; i<size; i++){
 %>
				<tr>
				
					<%
					int count = 0;
					count = i*3;
						for(j =0+count; j<3+count; j++){
							if(j==ProductImgListArr.size()){
								break;
							}
					%>
			    	<td>	    
					<%
						product_number= productListArr.get(j).getProduct_number();
						category_code = productListArr.get(j).getCategory_code();
						product_name = productListArr.get(j).getProduct_name();
						product_price =productListArr.get(j).getProduct_price();
						product_stock = productListArr.get(j).getProduct_stock();
						product_desc = productListArr.get(j).getProduct_desc();
						//product_date = productlist.get(i).getProduct_date();
						product_hits = productListArr.get(j).getProduct_hits();
						
						file_number =ProductImgListArr.get(j).getFile_number();
						product_number2 = ProductImgListArr.get(j).getProduct_number();
						orgin_file_name = ProductImgListArr.get(j).getOrgin_file_name();
						stored_file_name = ProductImgListArr.get(j).getStored_file_name();
						stored_thumbnail = ProductImgListArr.get(j).getStored_thumbnail();
						delegate_thumbnail =ProductImgListArr.get(j).getDelegate_thumbnail();
						file_size = ProductImgListArr.get(j).getFile_size();
						create_date = ProductImgListArr.get(j).getCreate_date();
						delete_check = ProductImgListArr.get(j).getDelete_check();
						//System.out.println("@@@파일경로는 "+path+"\\"+stored_file_name);
						%> 		 
			    		 <table border="">	    		 
							<tr>	 
								<td colspan="2">  <a href="./../cart/goodsDisplay.jsp?product_number=<%=product_number%>"><img src="<%=path %>/<%=stored_file_name%>" style="width: 300px; height: 300px;"></a></td></tr>	   
					    	<tr>
					    		<td width="80px" style="text-align: center">상품이름:<%=orgin_file_name%></td>
								
								<td width="80px" style="text-align: center">상품가격:<%=product_price %></td>
							</tr>
							<tr>
								<td  colspan="2" width="100px" style="text-align: center">상품재고량:<%=product_stock%></td>
							</tr>
						 </table>
	            	 	 <%
	         		}
	        		
	             
	                	 %>
		        
	               </td> 
	               
	                
	            </tr>    
	            <%
	            	}
         	}
            %>
            
            
            
 		</table>
 		
		 	   
		 	
 
		


</body>
</html>