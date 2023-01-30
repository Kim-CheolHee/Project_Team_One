<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.*"%>
<%@page import="common.JDBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="errorProcess.jsp"%>
<%
String url = application.getRealPath("/upload");
int maxSize = 1024 * 1000 * 5; // 파일 최대 크기 (5MB)
String encoding = "UTF-8";

MultipartRequest mr = new MultipartRequest(request, url, maxSize, encoding, new DefaultFileRenamePolicy());


request.setCharacterEncoding("UTF-8");
String id = mr.getParameter("id");
String password = mr.getParameter("password");
String name = mr.getParameter("name");
String photoImage = mr.getFilesystemName("photoImage"); // 현재 파일 이름

JDBConnect jdbc = new JDBConnect();

String sqlSelect = "select * from member";
Statement stmt = jdbc.con.createStatement();
ResultSet rs = stmt.executeQuery(sqlSelect);
String result = "";

while(rs.next()){
	String id2 = rs.getString(1); // 인덱스 or "컬럼명"
	if(id.equals(id2)){
		result = "이미 가입된 아이디입니다.";
		RequestDispatcher rd = request.getRequestDispatcher("addmember.jsp?error=1");
		rd.forward(request, response);
		break;
	} 
}

String sql = "insert into member values(?, ?, ?, ?)";
PreparedStatement psmt = jdbc.con.prepareStatement(sql);
if(result == ""){
	psmt.setString(1, id);
	psmt.setString(2, password);
	psmt.setString(3, name);
	psmt.setString(4, photoImage);
	int inResult = psmt.executeUpdate();
}

jdbc.close();
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="menu.jsp"></jsp:include>
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원 가입</h1>
		</div>
	</div>
	<div class="container">	
		<h2 class="display-5"><%= name %>님 회원가입을 환영합니다!</h2>
	</div>
</body>
</html>