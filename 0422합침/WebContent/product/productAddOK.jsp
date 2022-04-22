<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>

<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.jspsmart.upload.File"%>
<%@page import="com.jspsmart.upload.SmartUpload"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.sql.Timestamp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%

		Timestamp timestamp = new Timestamp(System.currentTimeMillis());



	
	    request.setCharacterEncoding("UTF-8");
	    String product_name=null,product_desc=null,category_code=null;
		String product_img=null;
		int product_price=0;
		int product_stock=0;
				
		
		String path = request.getRealPath("upload");
		
		int size=1024*1024;
		String file_size="";
		String file="";
		String orgin_file_name="";
		String str = null;
		String stored_file_name = "";
		MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
		Enumeration files = multi.getFileNames();
	
		
		product_name = multi.getParameter("product_name");
		product_price = Integer.parseInt(multi.getParameter("product_price"));
		product_stock = Integer.parseInt(multi.getParameter("product_stock"));
		
		product_desc = multi.getParameter("product_desc");
		category_code = multi.getParameter("category_code");
		
		/* System.out.println("@@@@@@@@>>>>>>>>>>>>>>>>>>"+product_price); */
		
		for(int i=1; i<=2; i++){
			str ="product_img";
			str= str+i;

			file = multi.getFilesystemName(str);
			/* System.out.println("@@@@@@>>"+file); */
			
			if(file != null){
				stored_file_name += file;
				orgin_file_name += multi.getOriginalFileName(str) ;
				file_size += file.getBytes().length ;
				
				str ="product_img";
				str= str+(i+1);
				file = multi.getFilesystemName(str);
				if(file != null){
					stored_file_name+="/";
					orgin_file_name+="/";
					file_size+="/";
				}
				
			}
		}

/* 		System.out.println("@stored_file_name@@@@@@"+stored_file_name); //서버에저장된파일이름
		System.out.println("@orgin_file_name@@@@@@"+orgin_file_name); //내가저장한파일으리므
		 */
		
		//stored_file_name //서버에저장될파일이름
		//orgin_file_name //원본파일이름
		
		GoodsBean productBean = new GoodsBean();
		productBean.setProduct_name(product_name);
		productBean.setProduct_price(product_price);
		productBean.setProduct_stock(product_stock);
		productBean.setProduct_desc(product_desc);
		productBean.setCategory_code(category_code);
		productBean.setProduct_date(timestamp);
		GoodsDBBean prductDBB = GoodsDBBean.getInstance();
		int product_number = prductDBB.insertProduct(productBean);
		
		productBean.setFile_number(product_number);
		productBean.setProduct_number(product_number);
		productBean.setOrgin_file_name(orgin_file_name);
		productBean.setStored_file_name(stored_file_name);
		productBean.setString_file_size(file_size);
		int re = prductDBB.insertProductimg(productBean);
		System.out.println("re@@@"+re);
		 %>
	
	
</body>
</html>