<%@page import="goods.GoodsBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="goods.GoodsDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
	<style type="text/css">
		.search_div{
		 	width: 100%;
            margin: auto;
            border: 1px solid black;
		}
	</style>
</head>
<body>
	<div class="search_div">
	<%
		String path = null, orgin_file_name = null, stored_file_name = null;
		 path = request.getRealPath("upload");
		request.setCharacterEncoding("UTF-8");
		String search = request.getParameter("search");
		//System.out.println("@@search>>"+search);
		// GoodsDBBean goodb = GoodsDBBean.getInstance();
		GoodsDBBean goodsDb = GoodsDBBean.getInstance();
		//GoodsBean goods = goodsDb.getGoods(product_number);
		
		ArrayList<GoodsBean> getsearchArr = goodsDb.getsearch(search);
		ArrayList<GoodsBean> getProductimgArr  =  goodsDb.getProductimg(getsearchArr);
		
	
	%>
		<table border="1">
	<%
		for(int i = 0 ; i< getProductimgArr.size(); i++){
			stored_file_name = getProductimgArr.get(i).getStored_file_name();
	%>
			<tr>
				<td>
					<a href="../cart/goodsDisplay.jsp?product_number=<%=getsearchArr.get(i).getProduct_number()%>"> <img src="<%= path%>\<%=stored_file_name %>"></a>
				</td>
			</tr>
	<%	
		}
	 %>
	 </table>
	</div>
</body>
</html>