<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.Product" %>
<%@ page import="dao.ProductRepository" %>

<%
request.setCharacterEncoding("UTF-8"); // 인코딩방식 한글설정

String url = application.getRealPath("./upload/"); // 상대경로를 절대경로로 변환
int maxSize = 5 * 1024 * 1024; // 그림 파일 최대크기를 5mb로 설정
MultipartRequest multi = new MultipartRequest(request, url, maxSize, "UTF-8", new DefaultFileRenamePolicy());
											// 방식, 저장경로, 최대크기, 코딩방식, 중복생성자 
String productId = multi.getParameter("productId");
String pname = multi.getParameter("pname");
String unitPrice = multi.getParameter("unitPrice"); // Integer 타입
String description = multi.getParameter("description");
String manufacturer = multi.getParameter("manufacturer");
String category = multi.getParameter("category");
String unitsInStock = multi.getParameter("unitsInStock"); // long 타입
String condition = multi.getParameter("condition");
String filename = multi.getFilesystemName("productImage");

/* Enumeration files = multi.getFileNames(); // 파일을 잘라서 보냄으로 열거형 사용
String fname = (String)files.nextElement(); // 쪼갠 파일을 문자타입으로 변환
String filename = multi.getFilesystemName(fname); // 쪼개진 파일의 이름 가져오기 */

// 가격을 입력하지 않았으면 0으로 설정
Integer price;
if(unitPrice.isEmpty()){
	price = 0;
} else {
	price = Integer.valueOf(unitPrice);
}
// 재고수량을 입력하지 않았으면 0으로 설정
long stock;
if(unitsInStock.isEmpty()){
	stock = 0;
} else {
	stock = Long.valueOf(unitsInStock);
}

//ProductRepository 객체생성(private 타입임으로 만들어논 get 메서드로 생성)
ProductRepository dao = ProductRepository.getInstance();
Product newProduct = new Product();

newProduct.setProductId(productId);
newProduct.setPname(pname);
newProduct.setUnitPrice(price);
newProduct.setDescription(description);
newProduct.setManufacturer(manufacturer);
newProduct.setCategory(category);
newProduct.setUnitsInStock(stock);
newProduct.setCondition(condition);
newProduct.setFilename(filename);

dao.addProduct(newProduct);

response.sendRedirect("products.jsp");

%>
