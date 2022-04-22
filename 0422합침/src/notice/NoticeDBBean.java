package notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class NoticeDBBean {
	private static NoticeDBBean instance=new NoticeDBBean();
	public static NoticeDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	public int insertBoard(NoticeBean board) throws Exception {	//媛믪쓣 異붽��븯�뒗 硫붿냼�뱶
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		int re=-1;
		int number;
		
		try {
			conn = getConnection();
			sql="select max(n_num) from notice";	//怨듭��궗�빆 踰덊샇 異쒕젰
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				number=rs.getInt(1)+1;
			} else {
				number=1;
			}
						
			sql="insert into notice(n_num, n_title, n_content, n_date, n_pwd, n_ip) "
					+ "values(?,?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setString(2, board.getN_title());
			pstmt.setString(3, board.getN_content());
			pstmt.setTimestamp(4, board.getN_date());
			pstmt.setString(5, board.getN_pwd());
			pstmt.setString(6, board.getN_ip());
			pstmt.executeUpdate();
			
			re=1;
 			pstmt.close();
 			conn.close();
 			
			System.out.println("글 등록에 성공했습니다.");
		} catch (Exception e) {
			System.out.println("글 등록에 실패했습니다.");
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return re;
	}
	
	public ArrayList<NoticeBean> listBoard(String pageNumber){	//리스트 추가 메소드
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		ResultSet pageSet=null;	//페이지번호
		
		int dbCount=0;	//페이지 번호의 개수를 받기 위한 변수
		int absolutePage=1;	//출력할 페이지
		
		
		ArrayList<NoticeBean> boardList = new ArrayList<NoticeBean>();
		
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			String sql="select count(n_num) from notice";
			pageSet = stmt.executeQuery(sql);
			
			if (pageSet.next()) {	//dbcount에 총 개수를 넣음
				dbCount = pageSet.getInt(1);
				pageSet.close();
				stmt.close();
			}
			
			if (dbCount % NoticeBean.pageSize == 0) {	//80
				NoticeBean.pageCount = dbCount / NoticeBean.pageSize;
			} else {	//84
				NoticeBean.pageCount = dbCount / NoticeBean.pageSize + 1;
			}
			
			if (pageNumber != null) {
				NoticeBean.pageNum = Integer.parseInt(pageNumber);
				//1: 0*10+1=1, 2: 1*10+1=11
				absolutePage = (NoticeBean.pageNum - 1) * NoticeBean.pageSize + 1;
			}	//페이지 출력
			
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			// type_scroll_sensitive -> 스크롤할때 변경사항을 처리 
			//concur_updatatable -> 커서 위치에서 정보를업데이트한다.

			sql="select * from notice order by n_num desc";
 			rs = stmt.executeQuery(sql);
 			
 			if (rs.next()) {
				rs.absolute(absolutePage);
				int count = 0;
				
	 			while (count < NoticeBean.pageSize) {
	 				NoticeBean board = new NoticeBean();
	 				
	 				board.setN_num(rs.getInt(1));
	 				board.setN_title(rs.getString(2));
	 				board.setN_content(rs.getString(3));
	 				board.setN_date(rs.getTimestamp(4));
	 				board.setN_hit(rs.getInt(5));
	 				board.setN_pwd(rs.getString(6));
	 				board.setN_ip(rs.getString(7));
	 				
	 				boardList.add(board);
	 				
	 				if (rs.isLast()) {
						break;
					} else {
						rs.next();
					}
	 				
	 				count++;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return boardList;
	}
	
	public NoticeBean getBoard(int num, boolean hitadd) {	//湲�踰덊샇 -> �옉�꽦�옄 湲��궡�슜 �솗�씤�븯�뒗 硫붿냼�뱶
		Connection conn=null;
		PreparedStatement pstmtup=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		NoticeBean board=null;
		
		try {
			conn = getConnection();
			
			if (hitadd == true) {
				sql="update notice set n_hit=n_hit+1 where n_num=?";
				pstmtup = conn.prepareStatement(sql);
				pstmtup.setInt(1, num);
				pstmtup.executeUpdate();
				pstmtup.close();
			}
			
			sql="select * from notice where n_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				board=new NoticeBean();
				board.setN_num(rs.getInt(1));
 				board.setN_title(rs.getString(2));
 				board.setN_content(rs.getString(3));
 				board.setN_date(rs.getTimestamp(4));
 				board.setN_hit(rs.getInt(5));
 				board.setN_pwd(rs.getString(6));
 				board.setN_ip(rs.getString(7));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return board;
	}
	
	public int deleteBoard(int n_num, String n_pwd) {	//n_num�� pwd瑜� 諛쏆븘 �궘�젣�븯�뒗 硫붿냼�뱶
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		String pwd="";
		int re=-1;
		
		try {
			conn = getConnection();
			sql="select n_pwd from notice where n_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, n_num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				pwd = rs.getString(1);
				if (pwd.equals(n_pwd)) {
					sql="delete from notice where n_num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, n_num);
					pstmt.executeUpdate();
					re=1;
				}else {
					re=0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return re;
	}
	
	public int editBoard(NoticeBean board) {	//board瑜� 諛쏆븘�꽌 �닔�젙�븯�뒗 硫붿냼�뱶
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		String pwd="";
		int re=-1;
		
		try {
			conn = getConnection();
			sql="select n_pwd from notice where n_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board.getN_num());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				pwd = rs.getString(1);
				if (pwd.equals(board.getN_pwd())) {
					sql="update notice set n_title=?, n_content=? where n_num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, board.getN_title());
					pstmt.setString(2, board.getN_content());
					pstmt.setInt(3, board.getN_num());
					pstmt.executeUpdate();
					re=1;
				}else {
					re=0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return re;
	}
	
}
