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
<%  if(user_id!=null) {  //관리자 아이디로 접속할 때만 글쓰기 버튼 노출
	if(user_id.equals("admin")){	
%>
<nav>
  <ol>
    <li><a href="customer_service.html">고객센터</a></li>
    <li>1:1문의하기</li>
  </ol>
</nav>
		
<table width="600">
	<tr>
		<td align="right">
			<input type="button" value="글쓰기" onclick="location.href='notice_write.jsp?pageNum=<%= pageNum %>'"></input>
		</td>
	</tr>
</table>
<% }} %>

<div class="container" style="font-size:1.0em;  color: black;">
  <div class="row">
    <div class="col">
      TEL. 000-000 <br>OPEN : 09:00 ~ 18:00<br>LUNCH : 12:00 ~ 13:00<br>토요일, 일요일 OFF 
    </div>
    <div class="col">
		국민은행 000002-01-000000<br>예금주 : 그린컴<br>주소 : 부산 중구 새마을로 146 3-4층
    </div>
    <div class="col">
		<a href="customer_service.jsp" target="_self">고객센터 홈</a><br>
        <a href="fqa.jsp" target="_self">FAQ 자주묻는 질문</a><br>
		<a href="notice_list.jsp" target="_self">Notice 공지사항</a><br>
    </div>
  </div>
</div>
	<center>
		<h1>Notice</h1>
			
	</center>
	<center>
		<table border="1" width="800" cellspacing="0">
			<tr height="25">
				<td width="40" align="center">번호</td>
				<td width="450" align="center">글제목</td>
				<td width="120" align="center">작성자</td>
				<td width="130" align="center">작성일</td>
				<td width="60" align="center">조회수</td>
			</tr>
			</tr>
			<%
			if(boardList.size()==0) {
			%>
	 		<tr align="center" bgcolor="#FFFFFF" height="30">
	 	   		<td colspan="5">등록된 글이 없습니다.</td>
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
						<%= user_id %>	<!-- 세션을 통해 id받아와 입력  -->
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