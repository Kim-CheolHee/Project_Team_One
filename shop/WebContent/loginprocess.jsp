<%@page import="java.sql.*"%>
<%@page import="common.JDBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
JDBConnect jdbc = new JDBConnect();

String id = request.getParameter("id");
String password = request.getParameter("password");

String sql = "select * from member";
PreparedStatement psmt = jdbc.con.prepareStatement(sql);
ResultSet rs = psmt.executeQuery(sql);

String result = "";
while(rs.next()){
	String id2 = rs.getString(1);
	String password2 = rs.getString(2);
	String name = rs.getString(3);
	if(id.equals(id2) && password.equals(password2)){
		result = name + "님 환영합니다.";
		session.setAttribute("user_id", id2);
		session.setAttribute("user_name", name);
		break;
		// 세션적용이 안될 때 1. session 생성문에 리로드 구문 추가
		// 2. if문 출력을 다른 페이지에 출력
		// 3. 세션 생성식 위치를 menu 위치보다 먼저 위치시키기
	} 
}

if(result == ""){
	RequestDispatcher rd = request.getRequestDispatcher("login.jsp?error=1");
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
			<h1 class="display-3">로그인 처리</h1>
		</div>
	</div>
	
	<div class="container">	
		<h1 class="display-5"><%= result %></h1>
		<p><a href="welcome.jsp" class="btn btn-secondary"> 처음으로</a></p>
	</div>
</body>
</html>