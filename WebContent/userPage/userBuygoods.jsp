<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="buy.UserOrderDetailBean"%>
<%@page import="buy.UserOrderDetailDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<style>
	.buygoods:hover{
		background: yellow;	
	}
</style>

	<script src="../js/jquery.js"></script>


<body>

	<%
		String user_id = null;
		if(!((String)session.getAttribute("user_id") == null)){
			user_id =(String)session.getAttribute("user_id");
		}
		String order_number =null,order_detail_status=null;
		int order_detail_number=0,product_number=0,product_count=0,product_price=0;
		
		
		UserOrderDetailDBBean UODBB =  UserOrderDetailDBBean.getInstance();
		ArrayList<UserOrderDetailBean> getUserOrderDetail = UODBB.getUserOrderDetail(user_id);

	%>	
		<table>
		<tr>
			<td>�ֹ��󼼹�ȣ</td>
			<td>�ֹ���ȣ</td>
			<td>��ǰ��ȣ</td>
			<td>����</td>
			<td>����</td>
			<td>��ۻ���</td>
			<td>ȯ��ó������</td>
		</tr>
	<%
	GoodsDBBean goodsdb =GoodsDBBean.getInstance();
		for(int i =0; i<getUserOrderDetail.size(); i++){
			order_detail_number =  getUserOrderDetail.get(i).getOrder_detail_number();
			order_number =  getUserOrderDetail.get(i).getOrder_number();
			product_number =  getUserOrderDetail.get(i).getProduct_number();
			product_count =  getUserOrderDetail.get(i).getProduct_count();
			product_price =  getUserOrderDetail.get(i).getProduct_price();
			order_detail_status =  getUserOrderDetail.get(i).getOrder_detail_status();	
			int re = UODBB.getUserRefundCheck(order_detail_number);
			
			GoodsBean goods	= goodsdb.getGoods(product_number);
			String product_name =  goods.getProduct_name();
			
	%>
			<tr onclick="location.href='userGoodsRefund.jsp?order_detail_number=<%=order_detail_number%>'" class="buygoods" style="cursor:pointer;">
					<%-- <input type="hidden" name="order_detail_number<%=i%>" id="order_detail_number<%=i%>" value="<%=order_detail_number%>"> --%>
					<td><%=order_detail_number%></td>
					<td><%=order_number %></td>
					<td><%=product_number %></td>
					<td><%=product_count %></td>
					<td><%=product_price %></td>
					<td><%=order_detail_status %></td>
					
					<td><input type="checkbox"  id="checkbox<%=i%>" disabled="disabled"></td>
					<%-- <td><input type="checkbox" name="checkbox" onclick="check()"  id="checkbox<%=i%>"></td> --%>		
			</tr>
	<%
	 		if(re == 1){
	%>		
				<script>
				  $('#checkbox<%=i%>').prop("checked", true);
				</script>
	<%
			}else{
	%>
				<script>
					$('#checkbox<%=i%>').prop("checked", false);
				 //document.getElementById("checkbox<%=i%>").checked = false;
				</script>
	<%			
			}	
		}
	%>
		</table>
	
</body>
</html>