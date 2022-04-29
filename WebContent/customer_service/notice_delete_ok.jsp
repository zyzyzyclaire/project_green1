<%@page import="notice.NoticeDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String pageNum = request.getParameter("pageNum");

	int n_num = Integer.parseInt(request.getParameter("n_num"));
	String n_pwd = request.getParameter("n_pwd");
	
	NoticeDBBean db = NoticeDBBean.getInstance();
	int re = db.deleteBoard(n_num, n_pwd);
	
	if(re == 1){
		response.sendRedirect("notice_list.jsp?n_num="+n_num+"&pageNum="+pageNum);
	}else if(re == 0){
		//비밀번호 틀림
%>
		<script>
			alert("비밀번호가 맞지 않습니다.");
			history.go(-1);
		</script>
<%
	}else if(re == -1){
		//삭제 실패
%>
		<script>
			alert("삭제에 실패하였습니다..");
			history.go(-1);
		</script>
<%
	}
%>