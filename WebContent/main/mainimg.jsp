<%-- <%@page import="goods.Imgcopy"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
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
	
	String fileName = null;
	String path = request.getRealPath("upload");
	File file = null;
	File newFile = null;
	FileInputStream  input = null;
	FileOutputStream  output = null;
	System.out.println(request.getContextPath()+"/images/products/");
	for(int i =1; i<=30; i++){
		 fileName = request.getContextPath()+"/images/products/";
		 fileName += i+".jpg"; 
		 System.out.println("@@"+fileName);
		 file = new File(fileName);
		 newFile = new File(path+"\\"+i+".jpg");
		 input = new FileInputStream(file);
		 output = new FileOutputStream(newFile);
		 byte[] buf = new byte[1024];
		 int readData;
			
		 while ((readData = input.read(buf)) > 0) {
			output.write(buf, 0, readData);
		 }
					
	}
	input.close();
	output.close();

	
/* 	String upload = request.getRealPath("upload");
	String path = System.getProperty("user.dir");
	System.out.println("@@@@"+path);
	path +="\\WebContent\\images\\products\\";
	FileInputStream input = null;
	FileOutputStream output = null;
		for(int i = 1; i<=30; i++){
			
		
		String  fileName = path+i+".jpg";
		System.out.println("@@@@"+fileName);
		File file = new File(fileName);
		File newFile = new File(upload+"\\"+i+".jpg");
		
		 input = new FileInputStream(file);
		 output = new FileOutputStream(newFile);
		// 3. 한번에 read하고, write할 사이즈 지정
		byte[] buf = new byte[1024];
		// 4. buf 사이즈만큼 input에서 데이터를 읽어서, output에 쓴다.
		int readData;
		
		while ((readData = input.read(buf)) > 0) {
			output.write(buf, 0, readData);
		}
		}
		// 5. Stream close
		input.close();
		output.close(); */
	%>
	<img src="<%=path%>">
</body>
</html> --%>