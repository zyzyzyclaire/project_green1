<%@page import="notice.NoticeDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="board" class="notice.NoticeBean"></jsp:useBean>
<jsp:setProperty property="*" name="board"/>
<%
	String pageNum = request.getParameter("pageNum");

	
	String pagecheck = request.getParameter("pagecheck");
	
	String select = request.getParameter("pageChange");
	boolean isAdPage = true;
	if (select == null) {
		isAdPage = false;
	}
	
	int n_num = Integer.parseInt(request.getParameter("n_num"));
	
	NoticeDBBean db = NoticeDBBean.getInstance();
	int re = db.editBoard(board);
	
	if(re == 1){
		if(pagecheck.equals("adminpage")){ 
			%>
			<script>
			location.href="../adminPage/adminPage.jsp?pageChange=../customer_service/notice_list.jsp";
			</script>
			<%
		}else{
			%>
			<script>
			location.href="notice_list.jsp";
			</script>
			<%
		}
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