<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="goods.GoodsBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	int file_number = 0 ;
	String orgin_file_name= null;
	String stored_file_name= null;
	String stored_thumbnail= null;
	String delegate_thumbnail= null;
	int file_size= 0;
	Timestamp create_date= null;
	String delete_check= null;


	String user_id = (String)session.getAttribute("user_id");
	int product_number = Integer.parseInt(request.getParameter("product_number"));	
	
	GoodsDBBean db = GoodsDBBean.getInstance();
	GoodsBean goods = db.getGoods(product_number);
	//��ǰ�����̹��������ҷ�����
	ArrayList<GoodsBean> getGoodsimg = db.getGoodsimg(product_number);
	String product_name = goods.getProduct_name();
	int product_price = goods.getProduct_price();
	int product_stock = goods.getProduct_stock();
	
	
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="../js/jquery.js"></script>
<script type="text/javascript">
	$(function() {
		$("#setCart").on("click", function() {
			confirm("��ٱ��Ͽ� �����ðڽ��ϱ�?");
			var value = $('#product_count').val();
			
			if(value == 0) {
				alert("��ǰ ������ �������ּ���.");
			} else {
				location.href="cartProcess.jsp?product_count="+value+"&product_number="+<%= product_number %>;
			}
		});
	});
	
	// �ٲ� ������ ��� ���� �� �˸�â ��쵵�� �� -0420����
	$(function () {
		$("#product_count").on("change",function() {
			var value = $('#product_count').val();
			
			if(value == 0) {
				alert("��ǰ ������ �������ּ���.");
			} else {
				location.href="checkStock.jsp?product_count="+value+"&product_number="+<%= product_number %>;
			}
		});
	});
	
	// 0���� ������ �� �˸�â ��쵵�� �� -0421����
	$(function () {
		$("#buyCount").on("click",function() {
			var value = $('#product_count').val();
			if(value == 0) {
				alert("��ǰ ������ �������ּ���.");
			} else {
				document.goods_frm.submit();
			}
		});
	});
	
	
	function viewCart(user_id) { 
		if(confirm("��ٱ��ϸ� ���ðڽ��ϱ�?")){ 
			location.href = "viewCart.jsp"; 
		} 
	} 
</script>

</head>
<body>
	<%= user_id %>�� <br><br>
	��ǰ ��ȣ : <%= product_number %><br>
	��ǰ�� :  <%= product_name %> <br>
	��ǰ ���� :  <%= product_price %> <br>
	��ǰ ��� : <%=product_stock %><br>
	���� : <br>
	<form method="post" action="../buy/buy.jsp" name="goods_frm">
		<input type="hidden" name="product_number" value="<%= product_number %>">
			<select name="product_count" id="product_count">
				<option value="0" selected>������ �����ϼ���.</option>
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">5</option>
			</select>
		<input type="button" value="��ٱ��� ���" id="setCart">
		<input type="button" value="�����ϱ�" id="buyCount">
	</form>
	<br><br>
	��ٱ��� ���� : <br>
	<input type="button" value="��ٱ��� ����" onclick="viewCart()">
	
	<% 
		
	
		
		if(user_id != null){
			if(user_id.equals("admin")){
			}
		}
		out.println("<a href='../product/goodsUpdate.jsp?product_number="+product_number+"'>��ǰ����</a>");
		out.println("<a href='../product/goodsDelete.jsp?product_number="+product_number+"'>��ǰ����</a>");
		
	%>
	
	
	<table>
	<%
	 	String path = request.getRealPath("upload");
		for(int i = 0 ; i< getGoodsimg.size(); i++){
			if(getGoodsimg.get(i).getStored_file_name() != null){
				stored_file_name = getGoodsimg.get(i).getStored_file_name();
	%>
				<tr>
					<td><img src="<%=path%>/<%= stored_file_name%>"></td>
				</tr>
	<%
			}
		}
	%>
	
	<%
	 	
		for(int i = 0 ; i< getGoodsimg.size(); i++){
			if(getGoodsimg.get(i).getStored_thumbnail() != null){
				stored_thumbnail = getGoodsimg.get(i).getStored_thumbnail();
	%>
				<tr>
					<td><img src="<%=path%>/<%= stored_thumbnail%>"></td>
				</tr>
	<%
			}
		}
	%>
	
	</table>
	
</body>
</html>