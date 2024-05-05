import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api_ex/data/network/error_handler.dart';
import 'package:rest_api_ex/data/source/rest_client.dart';

class EmailRequestViewModel with ChangeNotifier {
  final RestClient restClient = GetIt.instance<RestClient>();
  bool _showSpinner = false;
  String result = '';

  bool get showSpinner => _showSpinner;

  void emailSubmit(
    String appTitle,
    String email,
    Function(String) callback,
  ) async {
    _showSpinner = true;
    notifyListeners();

    restClient.emailAuth(email).then((_) {
      callback('이메일이 전송되었습니다.');
    }).catchError((error) {
      final errorMessage = ErrorHandler.handle(error).failure;

      callback(errorMessage);
      debugPrint('result: $errorMessage');
    });

    _showSpinner = false;

    notifyListeners();
  }
}
