<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>메인 페이지</title>
</head>
<body>
	<%!
	String greeting = "웹 쇼핑몰에 오신 것을 환영합니다";
	String tagline = "Welcome to web market";
	%>
	
	<jsp:include page="menu.jsp"></jsp:include>
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3"><%= greeting %></h1>
		</div>
	</div>
	
	<div class="container">
		<div class="text-center">
			<h3><%= tagline %></h3>
			<%
			response.setIntHeader("Refresh", 1);
			Date day = new Date();
			
			SimpleDateFormat sdf = new SimpleDateFormat("hh:mm:ss a");
			String simpleTime = sdf.format(day);
			
			int hour = day.getHours();
			int minute = day.getMinutes();
			int second = day.getSeconds();
			
			String ampm = "";
			if(hour < 12){
				ampm = "AM";
			} else if(hour == 12) {
				ampm = "PM";
			} else {
				ampm = "PM";
				hour -= 12;
				
			}
			String nowTime = hour + ":" + minute + ":" + second + " " + ampm;
			out.print("현재 접속 시간 : " + nowTime);
			%>
			<%-- <h2>현재 시각은 : <%= hour %>시 <%= minute %>분 <%= second %>초</h2> --%>
			<h2><%= simpleTime %></h2>
		</div>
		<hr>
	</div>
	
	<jsp:include page="footer.jsp"></jsp:include>
	
</body>
</html>