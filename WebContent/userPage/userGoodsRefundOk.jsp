<%@page import="buy.UserOrderDetailBean"%>
<%@page import="buy.UserOrderDetailDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	int order_detail_number =  Integer.parseInt( request.getParameter("order_detail_number"));
	String refund_reason = request.getParameter("refund_reason");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
			UserOrderDetailDBBean uodb = UserOrderDetailDBBean.getInstance();
			UserOrderDetailBean ubean = new UserOrderDetailBean();	
			ubean.setOrder_detail_number(order_detail_number);
			ubean.setRefund_reason(refund_reason);
			ubean.setRefund_img("�̹�������");
			ubean.setUser_email("�̸��Ͼ���");
			int re = uodb.goodsRefundRequest(ubean);
			System.out.println("ȯ�ҽ�û����"+re);	
	%>
</body>
</html>