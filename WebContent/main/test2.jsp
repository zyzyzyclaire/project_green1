<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">

<title>Insert title here</title>
<%
	String path= request.getRealPath("upload")+"\\1.jpg";
System.out.println("@@@"+path);

%>

<script>
    var index = 0;   //�̹����� �����ϴ� �ε���
    window.onload = function(){
        slideShow();
    }
    
    function slideShow() {
    var i;
    var x = document.getElementsByClassName("slide10");  //slide1�� ���� dom ����
    for (i = 0; i < x.length; i++) {
       x[i].style.display = "none";   //ó���� ���� display�� none���� �Ѵ�.
    }
    index++;
    if (index > x.length) {
        index = 1;  //�ε����� �ʰ��Ǹ� 1�� ����
    }   
    x[index-1].style.display = "block";  //�ش� �ε����� block����
    setTimeout(slideShow, 1000);   //�Լ��� 4�ʸ��� ȣ��
 
}
</script>
</head>
<body>
<%int c = 0; %>
	
  		<img class="slide1<%=c %>" src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %>1.jpg" >
  		<img class="slide1<%=c %>" src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %>2.jpg" >
  		<img class="slide1<%=c %>" src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %>3.jpg" >
	
</body>
</html>