import 'package:flutter/cupertino.dart';
import 'package:rest_api_ex/data/network/error_handler.dart';
import 'package:rest_api_ex/data/repository/token_repository.dart';

class UserInfoViewModel with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void submit({String? email, String? password}) async {
    _isLoading = true;
    notifyListeners();

    try {
      // await TokenRepository().signIn('email', password!);
    } catch (error) {
      final errorMessage = ErrorHandler.handle(error).failure;
      debugPrint(errorMessage);
    }

    _isLoading = false;

    notifyListeners();
  }
}
