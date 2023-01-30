package common;

import java.sql.*;
import javax.servlet.ServletContext;

public class JDBConnect {

	// 자바 빈 파일이 아님
	public Connection con; // 데이터베이스와의 연결
	public Statement stmt; // 구문 or 실행문(인파라미터가 없는 정적 쿼리문)
	public PreparedStatement psmt; // 인파라미터가 있는 동적 쿼리문(주로 사용)
	public ResultSet rs; // select 쿼리문 결과 저장(게시판에서 검색 결과)

	public JDBConnect() {
		try {
			Class.forName("com.mysql.jdbc.Driver"); // mysql 연결 드라이브
			// DB에 연결
			String url = "jdbc:mysql://localhost:3306/jsp";
			String id = "manager";
			String pass = "1234";
			con = DriverManager.getConnection(url, id, pass);
			System.out.println("MySQL-DB 연결 성공(기본 생성자)");
		} catch (Exception e) {
			System.out.println("MySQL-DB 연결 실패");
		}
	}
	
	public JDBConnect(String driver, String url, String id, String pwd) {
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, id, pwd);
			System.out.println("MySQL-DB 연결 성공(web, 인수 생성자 1)");
		} catch (Exception e) {
			System.out.println("MySQL-DB 연결 실패(web)");
		}
	}
	
	public JDBConnect(ServletContext application) {
		try {
			String driver = application.getInitParameter("MySQLDriver");
			Class.forName(driver);
			
			String url = application.getInitParameter("MySQLURL");
			String id = application.getInitParameter("MySQLId");
			String pwd = application.getInitParameter("MySQLPwd");
			con = DriverManager.getConnection(url, id, pwd);
			System.out.println("MySQL-DB 연결 성공(application, 인수 생성자 2)");
		} catch (Exception e) {
			System.out.println("MySQL-DB 연결 실패(application)");
		}
	}
	
	public void close() {
		try {
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			if(psmt != null) psmt.close();
			if(con != null) con.close();
			System.out.println("JDBC 자원 해제 성공");
		} catch (Exception e) {
			System.out.println("JDBC 자원 해제 실패");
		}
	}

}
