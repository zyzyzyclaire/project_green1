<%@page import="notice.NoticeDBBean"%>
<%@page import="notice.NoticeBean"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="board" class="notice.NoticeBean"></jsp:useBean>
<jsp:setProperty property="*" name="board"/>
<%
	InetAddress address = InetAddress.getLocalHost();
	String ip = address.getHostAddress();
	
	//board.setB_ip(request.getRemoteAddr());
	board.setN_ip(ip);
	board.setN_date(new Timestamp(System.currentTimeMillis()));

	NoticeDBBean db = NoticeDBBean.getInstance();
	//db.insertBoard(board);
	
	System.out.println(board.getN_content());
	int re = db.insertBoard(board);
	if(re == 1){
		response.sendRedirect("notice_list.jsp");
	}else{
		response.sendRedirect("notice_write.jsp");
	}
%>