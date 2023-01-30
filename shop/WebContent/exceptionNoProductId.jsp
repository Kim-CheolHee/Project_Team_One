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
			<h1 class="alert alert-danger">해당 상품이 존재하지 않습니다</h1>
		</div>
	</div>
	
	<div class="container">
		<!-- uri는 뒷부분 주소만, url은 전체주소 / ? 뒤에는 넘겨는 값 -->
		<p><%= request.getRequestURL()%>?<%= request.getQueryString()%></p>
		<p><a href="products.jsp" class="btn btn-secondary">상품목록</a></p>
	</div>

</body>
</html>