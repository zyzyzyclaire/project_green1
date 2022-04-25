<%@page import="java.sql.Timestamp"%>
<%@page import="login.UserDBBean"%>
<%@page import="notice.QnABean"%>
<%@page import="notice.QnADBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
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
	//System.out.println("@@@>>>>"+pageNum); 

%>

<%
	QnADBBean qnaDB = QnADBBean.getInstance();
	ArrayList<QnABean> boards = qnaDB.getList(pageNum);
	
	UserDBBean udb = new UserDBBean();
	boolean isAdmin = udb.isAdmin(user_id);
	
	int n_num=0, n_hit=0;
	String n_title, n_content;
	Timestamp n_date;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
	

%>
<!doctype html>
<html>
<head>
    <title></title>
    <script src="board.js" type="text/javascript"></script> 
</head>
<body>
	<h4>Boards</h4>
	<table border="1" width="800" cellspacing="0"> 
			<tr align="center">
				<td width="90px" height="30px">글번호</td>
				<td width="90px" height="30px">분류</td>
				<td width="300px">제목</td>
				<td width="90px">작성자</td>
				<td width="150px">작성일</td>
				<td width="90px">조회수</td>
				<td width="80px">첨부파일</td>
				<td width="90px">비공개</td>
			</tr>
			<% //공지사항 3줄 불러오기	
			for(int i=0; i<boards.size(); i++){
				
				if(i<3){
					QnABean list = boards.get(i);
					n_num = list.getN_num();
					n_title = list.getN_title();
					n_content = list.getN_content();
					if(n_num == 0) {
						continue;
					}
			%>
		<tr height="25" bgcolor="#F7F7F7">
			<td align="center"> 공지 </td>
			<td> &nbsp; </td>
			<td>
				<a href="notice_show.jsp?n_num=<%= n_num %>&pageNum=<%= pageNum %>">
					<%= n_title %>
				</a>
			</td>
			<td align="center">
				<%  if(user_id!=null) { 
						if(user_id.equals("admin")){	
				%>
						<%= user_id %>	
				<% 	}}else {%>
						admin
				<% }%>
			</td>
			<td> &nbsp; </td>
			<td> &nbsp; </td>
			<td> &nbsp; </td>
			<td> &nbsp; </td>
		</tr>
			
		<tr>
		    <%
				} else {
					QnABean list = boards.get(i);
					boolean isMine = false;
					boolean isRef = list.getB_ref() != list.getB_id();
			%>
			
			<td align="center"> <%= list.getB_id() %> </td>
			<td align="center"> <%= list.getB_category() %> </td>
			<td align='left'> <!-- 답변글일 경우 들여쓰기 후 이미지 표시 -->
			<%
					if(list.getB_level() > 0) {	
						for(int j=0; j<list.getB_level(); j++){
			%>			&nbsp; 
			<% 		} %>
				<img src="'../images/outline_subdirectory_arrow_right_black_24dp.png'">
			<% 	}	%>
				<a href="qnaShow.jsp?b_id=<%= list.getB_id() %>&pageNum=<%= pageNum %>">
				<%= list.getB_title() %> 
				</a>
			</td>
			<td align="center"> 
				<%= list.getU_id() %> 
			</td>
			<td align="center"> 
				<%= sdf.format(list.getB_date()) %> 
			</td>
			<td align="center"> 
				<%= list.getB_view() %>  
			</td>
			<% 	
				//첨부파일 있을 시 이미지 표시
				if (list.getB_fsize() > 0) {
			%>		
					<td align="center"><img src='../images/zip.gif'></td>	
			<% 	} else { %>
					<td>&nbsp;</td>
			<% 	}
				//비밀글일 경우 이미지 표시
				if (list.getB_secret().equals("0")) {
			%>		<td>&nbsp;</td>
			<% 	} else { %>
					<td align="center"><img src='../images/outline_lock_black_24dp.png'></td>	
			<% 	} %>	
		</tr>
		<% 			 
			}
		}	
		%>
		<tr>
			<td colspan="8" align="right">
				<% if (user_id != null) { %> <!-- 회원일 경우 글쓰기 가능  -->
				<input type="button"
					value="글쓰기" onClick="canWrite('<%= user_id == null ? "" : user_id %>')"
					style="cursor: pointer;"
					class="btn btn-secondary">
				<% } %>
			</td>
		</tr>
	</table>      
	<%= QnABean.pageNumber(5) %>   
</body>
</html>