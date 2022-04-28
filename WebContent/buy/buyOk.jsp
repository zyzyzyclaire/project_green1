<%@page import="buy.UserOrderDetailDBBean"%>
<%@page import="buy.UserOrderDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 주소 받아올 때 한글 깨지지 않기 위해 -0421근지
	request.setCharacterEncoding("UTF-8");
%>   
<jsp:useBean id="userOrder" class="buy.UserOrderBean"/>
<jsp:setProperty property="*" name="userOrder"/>
<jsp:useBean id="userOrderDetail" class="buy.UserOrderDetailBean"/>
<jsp:setProperty property="*" name="userOrderDetail"/>
<%
	// buy.jsp에서 submit할 때 건너오지 않은 값들 세팅(UserOrder용) -0422근지
	String user_id = (String)session.getAttribute("user_id");
	userOrder.setUser_id(user_id);
	
	Timestamp now = new Timestamp(System.currentTimeMillis());
	userOrder.setOrder_date(now);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		UserOrderDBBean order_db = UserOrderDBBean.getInstance();
		UserOrderDetailDBBean detail_db = UserOrderDetailDBBean.getInstance();
	
		// buy.jsp에서 submit할 때 건너오지 않은 값들 세팅(UserOrderDetail용) -0425근지
		
		// order_number값 찾기 -0425근지
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		String time = sdf.format(now);
		String order_number = time+"_"+user_id;
		userOrderDetail.setOrder_number(order_number);
		
	%>
	<%
		if(order_db.insertUserOrder(userOrder) == 1 && detail_db.insertUserOrderDetail(userOrderDetail) == 1) {
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