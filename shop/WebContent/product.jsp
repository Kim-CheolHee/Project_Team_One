<%@ page import="dao.ProductRepository" %>
<%-- <jsp:useBean id="productDAO" class="dao.ProductRepository" scope="session"></jsp:useBean> --%>
<%@ page import="dto.Product" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="exceptionNoProductId.jsp" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>상품 상세 정보</title>
</head>
<body>
	<jsp:include page="menu.jsp"></jsp:include>
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 상세 정보</h1>
		</div>
	</div>
	<%
	String id = request.getParameter("id");
	ProductRepository dao = ProductRepository.getInstance();
	Product product = dao.getProductById(id);
	%>
	
	<div class="container">
		<div class="row">
			<div class="col-md-5">
				<img src="upload/<%= product.getFilename() %>" style="width: 100%">
			</div>
			<div class="col-md-6">
				<h3> 상품명 : <%= product.getPname() %></h3>
				<p> 상품설명 : <%= product.getDescription() %></p>
				<p> 상품코드 : <%= product.getProductId() %></p>
				<p> 제조사 : <%= product.getManufacturer() %></p>
				<p> 분류 : <%= product.getCategory() %></p>
				<p> 재고수 : <%= product.getUnitsInStock() %> 개</p>
				<p> 상품가격 : <%= product.getUnitPrice() %> 원</p>
				<p> 상품상태 : <%= product.getCondition() %></p>
				<p><a href="#" class="btn btn-info"> 상품 주문 &raquo;</a></p>
				<p><a href="products.jsp" class="btn btn-secondary"> 상품 목록 &raquo;</a></p>
			</div>
		</div>
	</div>
</body>
</html>