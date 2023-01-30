function checkAddproduct(){
	var productId = document.getElementById("productId"); // 상품코드
	var pname = document.getElementById("pname"); // 상품명
	var unitPrice = document.getElementById("unitPrice"); // 상품가격
	var unitsInStock = document.getElementById("unitsInStock"); // 재고개수
	
	// 상품 아이디 유효성 검사, P로 시작하고 나머지는 숫자로써 5글자부터 12글자 사이로 설정
	if(!check(/^P[0-9]{4,11}$/, productId, "[상품코드]\nP와 숫자를 조합하여 5~12자리까지 입력하세요\n첫 글자는 반드시 P로 시작하세요.")){
		return false;
	}
	
	// 상품 이름 유효성 검사, 4글자 부터 12글자 사이로 입력
	if(pname.value.length < 4 || pname.value.length > 12){
		alert("[상품명]\n최소 4글자에서 최대 12글자까지 입력하세요.");
		pname.select();
		return false;
	}
	
	// 상품 가격 유효성 검사, 숫자만 입력되게 설정
	if(!check(/^[0-9]*$/, unitPrice, "[상품가격]\n가격은 숫자만 입력하세요.")){
		return false;
	}
	
	// 상품 재고 수, 숫자만 입력되게 설정
	if(!check(/^[0-9]*$/, unitsInStock, "[상품 재고수]\n상품재고는 숫자만 입력하세요.")){
		return false;
	}
	
	
	function check(regExp, e, msg){
		if(regExp.test(e.value)){
			return true;
		}
		alert(msg);
		e.select();
		return false;
	}
	document.newProduct.submit();
}