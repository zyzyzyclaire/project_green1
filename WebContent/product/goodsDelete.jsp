<%@page import="java.util.ArrayList"%>
<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<%@page import="java.io.File"%>
<title>Insert title here</title>
</head>
<body>
	<%
		int product_number = Integer.parseInt(request.getParameter("product_number"));	
		GoodsDBBean goodsDb = GoodsDBBean.getInstance();
		String path = request.getRealPath("upload");
		ArrayList<GoodsBean>  getGoodsimg =  goodsDb.getGoodsimg(product_number);
		File filee = null;
		
		for(int i=0; i<getGoodsimg.size(); i++){
			if(getGoodsimg.get(i).getStored_file_name()!=null){
				filee = new File(path+"\\"+getGoodsimg.get(i).getStored_file_name()); 
				  
			}else if(getGoodsimg.get(i).getStored_thumbnail()!=null){
				filee = new File(path+"\\"+getGoodsimg.get(i).getStored_thumbnail()); 
			}
			
			
			if( filee.exists() ){
					if(filee.delete()){ 
						//System.out.println("파일삭제 성공"); 
					}else{ 
						//System.out.println("파일삭제 실패"); 
					} 
			}else{ 
				//System.out.println("파일이 존재하지 않습니다."); 
			} 
		}
		
		
		int re = goodsDb.deleteGoods(product_number);
		response.sendRedirect("../main/main.jsp");
	%>
</body>
</html>