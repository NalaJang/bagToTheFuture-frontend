import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api_ex/data/network/error_handler.dart';
import 'package:rest_api_ex/data/source/rest_client.dart';

class EmailAuthViewModel with ChangeNotifier {
  final RestClient restClient = GetIt.instance<RestClient>();
  final _formKey = GlobalKey<FormState>();

  bool _showSpinner = false;

  get formKey => _formKey;

  bool get showSpinner => _showSpinner;

  // 이메일 인증 코드 입력
  void authCodeSubmit(
    String email,
    String authCode,
    Function(String) callback,
  ) async {
    _showSpinner = true;
    notifyListeners();

    try {
      final status = await restClient.emailAuthStatus(email, authCode);
      final bool result = status.data['isValid'];
      callback('$result');
    } catch (error) {
      final errorMessage = ErrorHandler.handle(error).failure;
      callback(errorMessage);
      debugPrint(errorMessage);
    }

    _showSpinner = false;

    notifyListeners();
  }

  // 이메일 재전송
  void emailResend(String email) async {
    _showSpinner = true;
    notifyListeners();

    try {
      await restClient.emailAuth(email);
    } catch (error) {
      final errorMessage = ErrorHandler.handle(error).failure;
      debugPrint(errorMessage);
    }

    _showSpinner = false;

    notifyListeners();
  }
}
