<%@page import="java.sql.*"%>
<%@page import="common.JDBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
JDBConnect jdbc = new JDBConnect();

request.setCharacterEncoding("UTF-8");
String id = (String)session.getAttribute("user_id");
String password = request.getParameter("password");

String sqlSelect = "select * from member";
/* String sqlSelect = "select * from member where id=?"; */
/* select 에 조건문을 쓰려면 prepareStatement 구문을 활용하고 psmt.set(id)
로 검색할 아이디가 세션에 저장된 아이디인걸로 설정해야한다.*/
Statement stmt = jdbc.con.createStatement();
ResultSet rs = stmt.executeQuery(sqlSelect);
String result = "";

String sql = "delete from member where id=?";
PreparedStatement psmt = jdbc.con.prepareStatement(sql);
while(rs.next()){
	String id2 = rs.getString(1);
	String password2 = rs.getString(2);
	String name = rs.getString(3);
	if(id2.equals(id) && password.equals(password2)){
		psmt.setString(1, id);
		int inResult = psmt.executeUpdate();
		result = name + "님 회원 탈퇴 처리가 정상 처리되었습니다.";
		session.invalidate();
		break;
	} 
}

if(result == ""){
	RequestDispatcher rd = request.getRequestDispatcher("deletemember.jsp?error=1");
	rd.forward(request, response);
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
			<h1 class="display-3">회원탈퇴 처리</h1>
		</div>
	</div>
	
	<div class="container">	
		<h1 class="display-5"><%= result %></h1>
		<p><a href="welcome.jsp" class="btn btn-secondary"> 처음으로</a></p>
	</div>
</body>
</html>