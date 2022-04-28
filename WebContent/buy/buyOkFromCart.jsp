<%@page import="java.text.SimpleDateFormat"%>
<%@page import="buy.UserOrderDetailDBBean"%>
<%@page import="buy.UserOrderDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 주소 받아올 때 한글 깨지지 않기 위해 -0421근지
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="userOrder" class="buy.UserOrderBean"/>
<jsp:setProperty property="*" name="userOrder"/>
<%
	// buyFromCart.jsp에서 submit할 때 건너오지 않은 값들 세팅(UserOrder용) -0422근지
	String user_id = (String)session.getAttribute("user_id");
	userOrder.setUser_id(user_id);
	
	Timestamp now = new Timestamp(System.currentTimeMillis());
	userOrder.setOrder_date(now);
%>
<%
	// 값을 메서드를 통해 세팅(UserOrderDetail용) -0425근지
	
	UserOrderDBBean order_db = UserOrderDBBean.getInstance();
	UserOrderDetailDBBean detail_db = UserOrderDetailDBBean.getInstance();

	// order_number값 찾기 -0425근지
	SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
	String time = sdf.format(now);
	String order_number = time+"_"+user_id;
	
	// cart_number 배열 받기 -0425근지
	String[] cart_num_arr = request.getParameterValues("cart_num_arr");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<%
		if(order_db.insertUserOrder(userOrder) == 1 && detail_db.insertUserOrderDetailArray(cart_num_arr, order_number) == 1) {
	%>		
			<script type="text/javascript">
			alert("주문 성공. 입금 후 발송이 시작됩니다.");
			location.href="../main/main.jsp";
			</script>
	<%
		} else {
	%>
				<script>
				alert("주문 오류. 다시 시도해주세요.");
				history.back();
				</script>
	<%	
		}
	%>
</body>
</html>