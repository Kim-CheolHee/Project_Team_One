<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css">
<script src="resources/js/validation.js" type="text/javascript"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="menu.jsp"></jsp:include>
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 등록</h1>
		</div>
	</div>
	
	<div class="container">
		<form action="processAddProduct.jsp" name="newProduct" class="form-horizontal" method="post" enctype="multipart/form-data">
			<div class="form-group row">
				<label class="col-sm-2">상품코드</label>
				<div class="col-sm-3">
					<input type="text" name="productId" id="productId" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상품명</label>
				<div class="col-sm-3">
					<input type="text" name="pname" id="pname" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상품가격</label>
				<div class="col-sm-3">
					<input type="text" name="unitPrice" id="unitPrice" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상세 정보</label>
				<div class="col-sm-5">
					<textarea rows="2" cols="50" name="description" id="description" class="form-control"></textarea>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">제조사</label>
				<div class="col-sm-3">
					<input type="text" name="manufacturer" id="manufacturer" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">분류</label>
				<div class="col-sm-3">
					<input type="text" name="category" id="category" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">재고 개수</label>
				<div class="col-sm-3">
					<input type="text" name="unitsInStock" id="unitsInStock" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상태</label>
				<div class="col-sm-5">
					<input type="radio" name="condition" value="New">신상품
					<input type="radio" name="condition" value="Old">중고품
					<input type="radio" name="condition" value="Refurbished">재생품
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">이미지</label>
				<div class="col-sm-5">
					<input type="file" name="productImage" class="form-control">
				</div>
			</div>			
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10">
					<input type="button" class="btn btn-primary" value="등록" onclick="return checkAddproduct()">
				</div>
			</div>
		</form>
	</div>
</body>
</html>