import 'package:flutter/cupertino.dart';
import 'package:rest_api_ex/config/validation_check.dart';
import 'package:rest_api_ex/data/network/error_handler.dart';

class ResetPwViewModel with ChangeNotifier {
  bool _showSpinner = false;
  final _formKey = GlobalKey<FormState>();

  bool get showSpinner => _showSpinner;

  get formKey => _formKey;

  void submitNewPassword(String password) {
    _showSpinner = true;
    ValidationCheck().allUserInputValidation(formKey);
    notifyListeners();

    try {
      // todo: 새 비밀번호 변경 api

    } catch (error) {
      final errorMessage = ErrorHandler.handle(error).failure;
      debugPrint(errorMessage);
    }

    _showSpinner = false;

    notifyListeners();
  }
}
