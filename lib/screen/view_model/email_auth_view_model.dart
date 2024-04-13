import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api_ex/config/validation_check.dart';
import 'package:rest_api_ex/data/network/error_handler.dart';
import 'package:rest_api_ex/data/source/rest_client.dart';
import 'package:rest_api_ex/screen/sign_up/email_auth_check_screen.dart';

import '../../config/navigate_to.dart';

class SignInViewModel with ChangeNotifier {
  final RestClient restClient = GetIt.instance<RestClient>();
  final _userEmailController = TextEditingController();
  bool _showSpinner = false;
  bool _isButtonEnabled = false;

  get userEmailController => _userEmailController;

  bool get showSpinner => _showSpinner;

  bool get isButtonEnabled => _isButtonEnabled;

  SignInViewModel() {
    _userEmailController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _userEmailController.dispose();
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

  void emailSubmit(BuildContext context, String appTitle, String email) async {
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
