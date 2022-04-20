<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="notice.NoticeBean"%>
<%@page import="notice.NoticeDBBean"%>
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
	String user_id = null;
	String pageNum = null;
	if(((String)session.getAttribute("user_id"))!=null){
		user_id =(String)session.getAttribute("user_id");
		System.out.print(user_id);
	}
	if(((String)session.getAttribute("pageNum"))!=null){
		 pageNum = request.getParameter("pageNum");
	}
	
	if(pageNum == null){
		pageNum = "1";
	}
	NoticeDBBean db = NoticeDBBean.getInstance();
	
	ArrayList<NoticeBean> boardList = db.listBoard(pageNum);
	int n_num, n_hit;
	String n_title, n_content;
	Timestamp n_date;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
%>
<%  if(user_id!=null) {  //������ ���̵�� ������ ���� �۾��� ��ư ����
	if(user_id.equals("admin")){	
%>
<nav>
  <ol>
    <li><a href="customer_service.html">������</a></li>
    <li>1:1�����ϱ�</li>
  </ol>
</nav>
		
<table width="600">
	<tr>
		<td align="right">
			<input type="button" value="�۾���" onclick="location.href='notice_write.jsp?pageNum=<%= pageNum %>'"></input>
		</td>
	</tr>
</table>
<% }} %>

<div class="container" style="font-size:1.0em;  color: black;">
  <div class="row">
    <div class="col">
      TEL. 000-000 <br>OPEN : 09:00 ~ 18:00<br>LUNCH : 12:00 ~ 13:00<br>�����, �Ͽ��� OFF 
    </div>
    <div class="col">
		�������� 000002-01-000000<br>������ : �׸���<br>�ּ� : �λ� �߱� �������� 146 3-4��
    </div>
    <div class="col">
		<a href="customer_service.jsp" target="_self">������ Ȩ</a><br>
        <a href="fqa.jsp" target="_self">FAQ ���ֹ��� ����</a><br>
		<a href="notice_list.jsp" target="_self">Notice ��������</a><br>
    </div>
  </div>
</div>
	<center>
		<h1>Notice</h1>
			
	</center>
	<center>
		<table border="1" width="800" cellspacing="0">
			<tr height="25">
				<td width="40" align="center">��ȣ</td>
				<td width="450" align="center">������</td>
				<td width="120" align="center">�ۼ���</td>
				<td width="130" align="center">�ۼ���</td>
				<td width="60" align="center">��ȸ��</td>
			</tr>
			</tr>
			<%
			if(boardList.size()==0) {
			%>
	 		<tr align="center" bgcolor="#FFFFFF" height="30">
	 	   		<td colspan="5">��ϵ� ���� �����ϴ�.</td>
	 	  	</tr>
			<% } else {
				for(int i=0; i<boardList.size(); i++){
						NoticeBean board = boardList.get(i);
						
						n_num = board.getN_num();
						n_title = board.getN_title();
						n_content = board.getN_content();
						n_date = board.getN_date();
						n_hit = board.getN_hit();
			%>
			<tr height="25" bgcolor="#F7F7F7" 
			    onmouseover="this.style.backgroundColor='#eeeeef'" 
			    onmouseout="this.style.backgroundColor='#f7f7f7'">
				<td align="center"><%= n_num %></td>
				<td>
					<a href="notice_show.jsp?n_num=<%= n_num %>&pageNum=<%= pageNum %>">
						<%= n_title %>
					</a>
				</td>
				<td align="center">
						<%= user_id %>	<!-- ������ ���� id�޾ƿ� �Է�  -->
				</td>
				<td align="center">
					<%= sdf.format(n_date) %>
				</td>
				<td align="center">
					<%= n_hit %>
				</td>
			</tr>
			<%
					}
				}
			%>
		</table>
		<%= NoticeBean.pageNumer(4) %>
	</center>
</body>
</html>