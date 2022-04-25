<%@page import="notice.QnABean"%>
<%@page import="notice.QnADBBean"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String pageNum = request.getParameter("pageNum");

	int b_id = Integer.parseInt(request.getParameter("b_id"));
	String b_pwd = request.getParameter("b_pwd");
	
	QnADBBean qdb = QnADBBean.getInstance();
	QnABean board = qdb.getBoard(b_id, false);
	String fName = board.getB_fname();
	String up="D:\\space_java2\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\ShoppingMall\\upload\\";
	
	int isDelete = qdb.deleteBoard(b_id, b_pwd);
	
	if(isDelete == 1){
		response.sendRedirect("qnaList.jsp?pageNum="+pageNum);
		
		if(fName != null){
			File file = new File(up+fName);
			file.delete();
		}
	}else if(isDelete == 0){
		//비밀번호 틀림
%>
		<script>
			alert("비밀번호가 맞지 않습니다.");
			history.go(-1);
		</script>
<%
	}else if(isDelete == -1){
		//삭제 실패
%>
		<script>
			alert("삭제에 실패하였습니다..");
			history.go(-1);
		</script>
<%
	}
%>