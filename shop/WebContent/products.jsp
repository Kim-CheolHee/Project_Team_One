<%@page import="java.util.List"%>
<%@ page import="dao.ProductRepository" %>
<%-- <jsp:useBean id="productDAO" class="dao.ProductRepository" scope="session"></jsp:useBean> --%>
<%@ page import="dto.Product" %>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>상품 목록</title>
</head>
<body>
	<jsp:include page="menu.jsp"></jsp:include>
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품목록</h1>
		</div>
	</div>
	
	<%
	ProductRepository dao = ProductRepository.getInstance();
 	ArrayList<Product> listOfProducts = dao.getAllProducts();
	dao.close();
	%>
	
	<div class="container">
		<div class="row" align="center">
			<%
			for(int i = 0; i < listOfProducts.size(); i++){
				Product product = listOfProducts.get(i);
			%>
			<div class="col-md-4">
				<img alt="" src="./upload/<%= product.getFilename() %>" style="width: 100%">
				<h3><%= product.getPname() %></h3>
				<p><%= product.getDescription() %></p>
				<p><%= product.getUnitPrice() %></p>
				<p><a href="product.jsp?id=<%= product.getProductId() %>" 
				class="btn btn-secondary" role="buttton">상품 상세 정보 &raquo;</a></p>
			</div>
			<% } %>
		</div>
		<hr>
	</div>
</body>
</html>