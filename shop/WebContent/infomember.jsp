<%@page import="java.util.ArrayList"%>
<%@page import="dto.memberDTO"%>
<%@page import="dao.memberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			<h1 class="display-3">회원 상세 정보</h1>
		</div>
	</div>
	<%
	String id = session.getAttribute("user_id").toString();
	
	memberDAO dao = new memberDAO();
	dao.memberInfo(id);
	ArrayList<memberDTO> showMember = dao.getMemberlist();
	dao.close();
	
	for(int i = 0; i < showMember.size(); i++){
		memberDTO mem = showMember.get(i);
	%>
	
	<div class="container">
		<div class="row">
			<div class="col-md-5">
				<img src="upload/<%= mem.getPhoto() %>" style="width: 100%">
			</div>
			<div class="col-md-6">
				<h3> 회원 아이디 : <%= mem.getId() %></h3>
				<p> 회원 비밀번호 : <%= mem.getPass() %></p>
				<p> 회원 이름 : <%= mem.getName() %></p>
			</div>
			<% } %>
		</div>
	</div>	
</body>
</html>