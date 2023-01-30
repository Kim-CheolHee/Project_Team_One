<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = (String)session.getAttribute("user_id");
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
	
	<div class="container" align="center">
		<div class="col-md-4 col-md-offset-4">
		<%
			String error = request.getParameter("error");
			if(error != null){
				out.println("<div class='alert alert-danger'>");
				out.println("회원정보 수정에 실패하였습니다.");
				out.println("</div>");
			}
		%>
			<form class="form-signin" action="editmemberprocess.jsp" method="post">
				<h5 class="form-signin-heading">회원님의 아이디입니다.</h5>
				<div class="form-group">
					<label for="inputPassword" class="sr-only">비밀번호</label>
					<input type="text" class="form-control" value="<%= id %>" name="user_id" readonly="readonly">				
				</div>
				<h5 class="form-signin-heading">수정하실 비밀번호를 입력해주세요.</h5>
				<div class="form-group">
					<label for="inputPassword" class="sr-only">비밀번호</label>
					<input type="password" class="form-control" placeholder="Password" name="user_pass" required autofocus>				
				</div>
				<h5 class="form-signin-heading">수정하실 이름을 입력해주세요.</h5>
				<div class="form-group">
					<label for="inputPassword" class="sr-only">비밀번호</label>
					<input type="text" class="form-control" placeholder="Name" name="user_name" required>				
				</div>
				<button class="btn btn btn-lg btn-success btn-block" type="submit">회원정보수정</button>
			</form>
		</div>
	</div>
</body>
</html>