<%@page import="buy.UserOrderDetailDBBean"%>
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
		int checkboxcount = Integer.parseInt( request.getParameter("checkboxcount"));
		String order_number;
		for(int i = 0; i<checkboxcount; i++){
			 order_number = request.getParameter("order_number"+i);
			 System.out.println("order__number"+"@@@"+order_number);	
			 UserOrderDetailDBBean uodbb = UserOrderDetailDBBean.getInstance();
			 int re = uodbb.goodsRefundRequest(order_number);
			 System.out.println("@@@@환불신청"+re);
		}
		
	%>

</body>
</html>