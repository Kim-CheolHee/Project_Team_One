<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
/* session.removeAttribute("UserId");
session.removeAttribute("UserName"); */

session.invalidate(); // * 추천방법(서버가 세션정보를 더이상 유지할 필요가 없으므로 부담이 줄어듬)
response.sendRedirect("login.jsp");
%>