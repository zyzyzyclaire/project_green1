<%@page import="java.util.ArrayList"%>
<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="cart.CartDBBean"%>
<%@page import="cart.CartBean"%>
<%@page import="login.UserBean"%>
<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.io.File"%>
<%
	String[] cart_num_arr = request.getParameterValues("cart_num_arr");
	
	String user_id = (String)session.getAttribute("user_id");
	
	UserDBBean userDb = UserDBBean.getInstance();
	UserBean user = userDb.getUser(user_id);
	
	CartDBBean cartDb = CartDBBean.getInstance();
	CartBean cart = null;
	
	GoodsDBBean goodsDb = GoodsDBBean.getInstance();
	GoodsBean goods = null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<!-- 부트스트랩	-0426근지 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

	<script src="../js/jquery.js"></script>
	<script>
	$(function () {
		$("#check").change(function() {
			if($("#check").is(":checked")) {
				document.getElementById("re_name").value = "<%= user.getUser_name() %>";
				document.getElementById("re_phone").value = "<%= user.getUser_phone() %>";
				document.getElementById("re_addr").value = "<%= user.getUser_addr() %>";
			} else {
				document.getElementById("re_name").value = null;
				document.getElementById("re_phone").value = null;
				document.getElementById("re_addr").value = null;
			}
		});
	});
	</script>
	
<link rel="stylesheet" href="../css/buy.css" type = "text/css">	
</head>
<body class="buyBody">

      <jsp:include page="../main/mainHeader.jsp"></jsp:include> 

	<h1 class="buyH1">주문서 작성</h1>
		<form action="buyOkFromCart.jsp?">
				<table class="table" id="buyTable1">
					<h2 class="buyH2">주문 내역</h2>
						<tr align="center">
							<td>이미지</td>
							<td>상품정보</td>
							<td>판매가</td>
							<td>수량</td>
							<td>배송비</td>
							<td>합계</td>
						</tr>
			<%			
						int total_price = 0;
						for(int i=0; i<cart_num_arr.length; i++) {
							cart = cartDb.getCart_one(Integer.parseInt(cart_num_arr[i]));
							goods = goodsDb.getGoods(cart.getProduct_number());
							
							//상품세부이미지까지불러오기
							ArrayList<GoodsBean> getGoodsimg = goodsDb.getGoodsimg(cart.getProduct_number());
							String stored_file_name = getGoodsimg.get(0).getStored_file_name();
							System.out.println("@@@@@@"+stored_file_name);
							String path = request.getRealPath("upload");
							File file = new File(path+"\\"+stored_file_name);
							boolean isExists = file.exists();
							if(isExists) { System.out.println("I find the existFile.txt"); } 
							else { System.out.println("No, there is not a no file."); }
							
			%>			
						<!-- 값 넘기기 위해. 나중에 해당 체크박스는 css로 보이지 않게 설정하기	-0425근지 -->
						<div width=0 height=0 style="visibility:hidden">
						<input type="checkbox" value="<%= cart_num_arr[i] %>" name="cart_num_arr" checked onclick="return false;">
						</div>
						
							<tr>
								<td id="buyRow1_1" width="200">
									<%if(isExists){%>
										<img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%=stored_file_name%>"  alt="이미지없음" class="buyImg">
									<%}else{%>
										<img src="../images/products/noimg.PNG"  alt="이미지없음"  class="buyImg">
									<%}%>
								</td>							
								<td id="buyRow1_2"><%= goods.getProduct_name() %></td>
								<td id="buyRow1_3"><%= goods.getProduct_price() %> won</td>								
								<td id="buyRow1_4"><%= cart.getProduct_count() %></td>
								<td id="buyRow1_5">[무료]</td>
								<td id="buyRow1_6"><%= goods.getProduct_price()*cart.getProduct_count() %> won</td>
			<%
								total_price += goods.getProduct_price()*cart.getProduct_count();
						}
			%>				
							</tr>
							<tr>
								<td>[기본배송]</td>
								<td colspan="5" align="right">
									상품구매금액&nbsp;<%= total_price %>&nbsp;+&nbsp;배송비&nbsp;0&nbsp;(무료)&nbsp;=&nbsp;합계&nbsp;:<strong>&nbsp;&nbsp;&nbsp;<%= total_price %> won</strong>
								</td>
							</tr>	
				</table>
				<div class="buyBlank1"></div>
				<table class="table">
					<h2 class="buyH2">배송 정보</h2>
						<tr>
							<td colspan="2" align="right">
								<input type="checkbox" id="check">회원정보와 동일
							</td>
						</tr>
						<tr>
							<td id="buyRow2_1">이름</td>
							<td><input type="text" name="receiver_name" id="re_name" class="form-control"></td>
						</tr>
						<tr>
							<td id="buyRow2_2">휴대폰 번호</td>
							<td><input type="text" name="receiver_phone" id="re_phone" class="form-control"></td>
						</tr>
						<tr>
							<td id="buyRow2_3">주소</td>
							<td><input type="text" name="receiver_addr" id="re_addr" class="form-control"></td>
						</tr>
						<tr class="buyBlank2"></tr>
						<tr class="buyBtnClass">
							<td colspan="2">
								<input type="submit" value="주문하기" id="buyBtn">
							</td>
						</tr>
				</table>
		</form>
		
		<jsp:include page="../main/mainfooter.jsp"></jsp:include>
	
</body>
</html>