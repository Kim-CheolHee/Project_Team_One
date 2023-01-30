<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand navbar-dark bg-dark">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="welcome.jsp">Home</a>
			<%
			if(session.getAttribute("user_id") == null){
				out.println("<a class='navbar-brand' href='login.jsp'>");
				out.println("로그인");
				out.println("</a>");
				out.println("<a class='navbar-brand' href='addmember.jsp'>");
				out.println("회원가입");
				out.println("</a>");
				out.println("<a class='navbar-brand' href='products.jsp'>");
				out.println("상품목록");
				out.println("</a>");
			} else {
				out.println("<a class='navbar-brand' href='logout.jsp'>");
				out.println("로그아웃");
				out.println("</a>");
				out.println("<a class='navbar-brand' href='infomember.jsp'>");
				out.println("회원정보");
				out.println("</a>");
				out.println("<a class='navbar-brand' href='editmember.jsp'>");
				out.println("회원수정");
				out.println("</a>");
				out.println("<a class='navbar-brand' href='deletemember.jsp'>");
				out.println("회원탈퇴");
				out.println("</a>");
				out.println("<a class='navbar-brand' href='products.jsp'>");
				out.println("상품목록");
				out.println("</a>");
				out.println("<a class='navbar-brand' href='addProduct.jsp'>");
				out.println("상품추가");
				out.println("</a>");
			}
			%>
		</div>
	</div>
</nav>
