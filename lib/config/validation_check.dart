import 'package:flutter/cupertino.dart';

class ValidationCheck {

  // 회원가입, 로그인에 대한 사용자 입력값 유효성 검사
  void allUserInputValidation(GlobalKey<FormState> formKey) {
    final isValid = formKey.currentState!.validate();

    if( isValid ) {
      formKey.currentState!.save();
    }
  }
}

String? validateEmail(String? value) {
  if( value == '' || value == null ) {
    return '이메일을 입력해 주세요.';
  } else {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))'
        r'@((\[[0-9]{1,3}\.[0-9]{1,3}\.'
        r'[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(pattern);
    if( !regExp.hasMatch(value) ) {
      return '올바르지 않은 이메일 형식입니다.';
    } else {
      return null;
    }
  }

}

String? validateAuthCode(String? value) =>
    value == null || value.isEmpty || value.length != 6 ? '인증 코드는 6자리 입니다.' : null;

String? validateNickName(String? value) =>
    value == '' ? '닉네임을 입력해 주세요.' : null;

String? validatePassword(String? value) =>
    value == null || value.length < 6 ? '비밀번호를 입력해 주세요.' : null;

String? validateConfirmPassword(String? value, String password) =>
    value == null || value.isEmpty || value != password ? '비밀번호가 일치하지 않습니다.' : null;
