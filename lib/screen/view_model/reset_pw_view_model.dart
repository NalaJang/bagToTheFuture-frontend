import 'package:flutter/cupertino.dart';
import 'package:rest_api_ex/config/custom_snack_bar.dart';
import 'package:rest_api_ex/config/navigate_to.dart';
import 'package:rest_api_ex/config/validation_check.dart';
import 'package:rest_api_ex/data/network/error_handler.dart';
import 'package:rest_api_ex/screen/my_bottom_navigation.dart';

class ResetPwViewModel with ChangeNotifier {
  bool _showSpinner = false;
  final _formKey = GlobalKey<FormState>();
  final _userPasswordController = TextEditingController();
  final _userPasswordConfirmController = TextEditingController();

  @override
  void dispose() {
    _userPasswordController.dispose();
    _userPasswordConfirmController.dispose();

    super.dispose();
  }

  bool get showSpinner => _showSpinner;

  get formKey => _formKey;

  get userPasswordController => _userPasswordController;

  get userPasswordConfirmController => _userPasswordConfirmController;

  void submitNewPassword(BuildContext context, String password) {
    _showSpinner = true;
    ValidationCheck().allUserInputValidation(formKey);
    notifyListeners();

    try {
      // todo: 새 비밀번호 변경 api

      navigatePushAndRemoveUtilTo(context, const MyBottomNavigation());
      CustomSnackBar().showSnackBar(context, '비밀번호가 변경되었습니다.');

    } catch (error) {
      final errorMessage = ErrorHandler.handle(error).failure;
      debugPrint(errorMessage);
    }

    _showSpinner = false;

    notifyListeners();
  }
}
