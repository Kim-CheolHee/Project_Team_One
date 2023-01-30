function logincheck() {
	/*var id = document.loginForm.id.value;
	var pass = document.loginForm.password.value;*/
	/*var idlength = document.loginForm.id.value.length;*/
	var id = document.getElementById("id").value;
	var pass = document.getElementById("pass").value;
	var name = document.getElementById("name").value;
	
	console.log(id);	
	console.log(pass);	
	console.log(name);	
	
	// 영어와 숫자만 입력되게 유효성검사 설정
	var redId = /^[a-zA-Z0-9]*$/;
	// A-Z, a-z, 0-9 특수문자가 포함되어 있는지, 8자 이상
	var regPass = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~?!@#$%^&*_-]).{8,}$/;
	// 이름은 한글만 입력 가능
	var regName = /^[가-힣]*$/;

	if (id.length < 7) {
		alert("아이디는 7글자 이상입니다.");
		return false;
	} else if (!redId.test(id)) { // redId의 형식이 아니라면
		alert("아이디는 영어와 숫자만 사용할 수 있습니다.");
		return false;
	}
	
	if(!regPass.test(pass)){
		alert("비밀번호는 영어, 숫자, 특수문자 포함 8글자 이상입니다.");
		return false;
	}
	
	if(!regName.test(name)){
		alert("이름은 한글만 입력 가능합니다.");
		return false;
	}
}