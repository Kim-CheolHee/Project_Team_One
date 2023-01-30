<%@page import="common.JDBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
request.setCharacterEncoding("utf-8");
String id = request.getParameter("user_id");
String pass = request.getParameter("user_pass");
String name = request.getParameter("user_name"); 

JDBConnect jdbc = new JDBConnect();

String sql = "UPDATE member SET pass = ?, name = ? WHERE id = ?";
jdbc.psmt = jdbc.con.prepareStatement(sql);
jdbc.psmt.setString(1, pass);
jdbc.psmt.setString(2, name);
jdbc.psmt.setString(3, id);
int result = jdbc.psmt.executeUpdate();

if(result == 0){
	RequestDispatcher rd = request.getRequestDispatcher("editmember.jsp?error=1");
	rd.forward(request, response);
} else {
	
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
			<h1 class="display-3">회원정보수정</h1>
		</div>
	</div>
	<div class="container">	
		<h2 class="display-5"><%= name %>님의 정보가 정상 수정되었습니다!</h2>
	</div>
</body>
</html>