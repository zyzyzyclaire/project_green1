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
		//��й�ȣ Ʋ��
%>
		<script>
			alert("��й�ȣ�� ���� �ʽ��ϴ�.");
			history.go(-1);
		</script>
<%
	}else if(re == -1){
		//���� ����
%>
		<script>
			alert("������ �����Ͽ����ϴ�..");
			history.go(-1);
		</script>
<%
	}
%>