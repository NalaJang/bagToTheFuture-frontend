import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api_ex/config/validation_check.dart';
import 'package:rest_api_ex/data/network/error_handler.dart';
import 'package:rest_api_ex/data/source/rest_client.dart';
import 'package:rest_api_ex/screen/sign_up/email_auth_check_screen.dart';

import '../../config/navigate_to.dart';

class EmailAuthViewModel with ChangeNotifier {
  final BuildContext context;
  final RestClient restClient = GetIt.instance<RestClient>();
  final _userEmailController = TextEditingController();
  final _emailAuthCodeController = TextEditingController();
  bool _showSpinner = false;
  bool _isButtonEnabled = false;

  get userEmailController => _userEmailController;

  get emailAuthCodeController => _emailAuthCodeController;

  bool get showSpinner => _showSpinner;

  bool get isButtonEnabled => _isButtonEnabled;

  EmailAuthViewModel(this.context) {
    _userEmailController.addListener(_updateButtonState);
    _emailAuthCodeController.addListener(_updateAuthState);
  }

  @override
  void dispose() {
    _userEmailController.dispose();
    _emailAuthCodeController.dispose();
    super.dispose();
  }

  // 이메일 유효성 검사에 따라 버튼 색상 활성화를 하기 위한 콜백 함수
  void _updateButtonState() {
    if (validateEmail(_userEmailController.text) == null) {
      _isButtonEnabled = true;
    } else {
      _isButtonEnabled = false;
    }

    notifyListeners();
  }

  // 이메일 인증하기 버튼 활성화
  void _updateAuthState() {
    if (validateAuthCode(_emailAuthCodeController.text) == null) {
      _isButtonEnabled = true;
    } else {
      _isButtonEnabled = false;
    }

    notifyListeners();
  }

  void emailResend(String email) async {
    _showSpinner = true;
    notifyListeners();

    try {
      await restClient.emailAuth(email);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('이메일이 전송되었습니다.'),
        ),
      );
    } catch (error) {
      final errorMessage = ErrorHandler.handle(error).failure;
      debugPrint(errorMessage);
    }

    _showSpinner = false;

    notifyListeners();
  }

  void emailSubmit(String appTitle, String email) async {
    _showSpinner = true;
    notifyListeners();

    try {
      await restClient.emailAuth(email);

      if (context.mounted) {
        navigateTo(
          context,
          EmailAuthCheckScreen(
            appBarTitle: appTitle,
            userEmail: email,
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('이메일이 전송되었습니다.'),
          ),
        );
      }
    } catch (error) {
      final errorMessage = ErrorHandler.handle(error).failure;
      debugPrint(errorMessage);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );
      }
    }

    _showSpinner = false;

    notifyListeners();
  }

  // 이메일 인증 코드 입력
  void authCodeSubmit(String email, Widget where) async {
    _showSpinner = true;
    notifyListeners();

    try {
      final status = await restClient.emailAuthStatus(
        email,
        _emailAuthCodeController.text,
      );
      final result = status.data['isValid'];

      if (result) {
        navigateTo(context, where);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('인증 코드가 맞지 않습니다.'),
          ),
        );
      }
    } catch (error) {
      final errorMessage = ErrorHandler.handle(error).failure;
      debugPrint(errorMessage);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );
      }
    }

    _showSpinner = false;

    notifyListeners();
  }
}
