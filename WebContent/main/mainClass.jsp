<%@page import="java.sql.Timestamp"%>
<%@page import="java.io.File"%>
<%

String path = request.getRealPath("./");
	 path = path+"\\upload"; //폴더 경로
	 File Folder = new File(path);
	// 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
	if (!Folder.exists()) {
		try{
		    Folder.mkdir(); //폴더 생성합니다.
		    System.out.println("폴더가 생성되었습니다.");
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		}        
   }
	
 path = request.getRealPath("upload");
//System.out.println("@@@@@@@@@@@@"+path);
request.setCharacterEncoding("UTF-8");
int product_number = 0;
String category_code = null;
String product_name = null;
int product_price = 0;
int product_stock = 0;
String product_desc = null;
Timestamp product_date = null;
int product_hits = 0;

int product_number2 = 0;
int file_number = 0 ;
String orgin_file_name= null;
String stored_file_name= null;
String stored_thumbnail= null;
String delegate_thumbnail= null;
int file_size= 0;
Timestamp create_date= null;
String delete_check= null;
String user_id = null;
if(!((String)session.getAttribute("user_id") == null)){
	user_id =(String)session.getAttribute("user_id");
}
%>



