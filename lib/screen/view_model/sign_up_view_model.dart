import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api_ex/config/custom_snack_bar.dart';
import 'package:rest_api_ex/config/navigate_to.dart';
import 'package:rest_api_ex/config/validation_check.dart';
import 'package:rest_api_ex/data/model/user_model.dart';
import 'package:rest_api_ex/data/network/error_handler.dart';
import 'package:rest_api_ex/data/source/rest_client.dart';
import 'package:rest_api_ex/screen/my_bottom_navigation.dart';

class SignUpViewModel with ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  final _userEmailController = TextEditingController();
  final _userPasswordController = TextEditingController();
  final _userPasswordConfirmController = TextEditingController();
  final _userNickNameController = TextEditingController();
  final _userBirthController = TextEditingController();
  final _accountHolderController = TextEditingController();
  final _accountController = TextEditingController();
  final String _userBank = '';
  final RestClient restClient = GetIt.instance<RestClient>();

  bool _showSpinner = false;
  bool _isButtonEnabled = false;
  bool _isCheckedAllTermsOfUse = false;
  bool _isCheckedNecessaryTermsOfUse1 = false;
  bool _isCheckedNecessaryTermsOfUse2 = false;
  bool _isCheckedNecessaryTermsOfUse3 = false;
  bool _isCheckedNecessaryTermsOfUse4 = false;
  bool _isCheckedMarketing = false;

  @override
  void dispose() {
    super.dispose();

    _userEmailController.dispose();
    _userPasswordController.dispose();
    _userPasswordConfirmController.dispose();
    _userNickNameController.dispose();
    _userBirthController.dispose();
    _accountHolderController.dispose();
    _accountController.dispose();
  }

  void signUpSubmit(BuildContext context) async {
    _showSpinner = true;
    notifyListeners();

    List<String> phoneNumber = ['010', '1616', '1616'];
    var userModel = UserModel(
        name: 'test16',
        email: 'test16@email.com',
        password: '123456',
        passwordConfirm: '123456',
        phoneNumber: phoneNumber);

    try {
      await restClient.createUser(userModel.toJson());

      navigatePushAndRemoveUtilTo(context, const MyBottomNavigation());
    } catch (error) {
      final errorMessage = ErrorHandler.handle(error).failure;

      CustomSnackBar().showSnackBar(context, errorMessage);
    }

    _showSpinner = false;
    notifyListeners();
  }

  void onAllTermsOfUsePressed() {
    _isCheckedAllTermsOfUse = !_isCheckedAllTermsOfUse;
    _isCheckedNecessaryTermsOfUse1 = _isCheckedAllTermsOfUse;
    _isCheckedNecessaryTermsOfUse2 = _isCheckedAllTermsOfUse;
    _isCheckedNecessaryTermsOfUse3 = _isCheckedAllTermsOfUse;
    _isCheckedNecessaryTermsOfUse4 = _isCheckedAllTermsOfUse;
    _isCheckedMarketing = _isCheckedAllTermsOfUse;

    _updateButtonState();
    notifyListeners();
  }

  void _updateAllTermsOfUseStatus() {
    _isCheckedAllTermsOfUse = _isCheckedNecessaryTermsOfUse1 &&
        _isCheckedNecessaryTermsOfUse2 &&
        _isCheckedNecessaryTermsOfUse3 &&
        _isCheckedNecessaryTermsOfUse4 &&
        _isCheckedMarketing;
  }

  void _updateButtonState() {
    _isButtonEnabled = _isCheckedNecessaryTermsOfUse1 &&
        _isCheckedNecessaryTermsOfUse2 &&
        _isCheckedNecessaryTermsOfUse3 &&
        _isCheckedNecessaryTermsOfUse4;
  }

  void onTermsOfUse1Pressed() {
    _isCheckedNecessaryTermsOfUse1 = !_isCheckedNecessaryTermsOfUse1;
    _updateAllTermsOfUseStatus();
    _updateButtonState();
    notifyListeners();
  }

  void onTermsOfUse2Pressed() {
    _isCheckedNecessaryTermsOfUse2 = !_isCheckedNecessaryTermsOfUse2;
    _updateAllTermsOfUseStatus();
    _updateButtonState();
    notifyListeners();
  }

  void onTermsOfUse3Pressed() {
    _isCheckedNecessaryTermsOfUse3 = !_isCheckedNecessaryTermsOfUse3;
    _updateAllTermsOfUseStatus();
    _updateButtonState();
    notifyListeners();
  }

  void onTermsOfUse4Pressed() {
    _isCheckedNecessaryTermsOfUse4 = !_isCheckedNecessaryTermsOfUse4;
    _updateAllTermsOfUseStatus();
    _updateButtonState();
    notifyListeners();
  }

  void onMarketingPressed() {
    _isCheckedMarketing = !_isCheckedMarketing;
    _updateAllTermsOfUseStatus();
    _updateButtonState();
    notifyListeners();
  }

  get formKey => _formKey;

  get userEmailController => _userEmailController;

  get userPasswordController => _userPasswordController;

  get userPasswordConfirmController => _userPasswordConfirmController;

  get userNickNameController => _userNickNameController;

  get userBirthController => _userBirthController;

  get accountHolderController => _accountHolderController;

  get accountController => _accountController;

  String get userBank => _userBank;

  bool get showSpinner => _showSpinner;

  bool get isButtonEnabled => _isButtonEnabled;

  bool get isCheckedAllTermsOfUse => _isCheckedAllTermsOfUse;

  bool get isCheckedNecessaryTermsOfUse1 => _isCheckedNecessaryTermsOfUse1;

  bool get isCheckedNecessaryTermsOfUse2 => _isCheckedNecessaryTermsOfUse2;

  bool get isCheckedNecessaryTermsOfUse3 => _isCheckedNecessaryTermsOfUse3;

  bool get isCheckedNecessaryTermsOfUse4 => _isCheckedNecessaryTermsOfUse4;

  bool get isCheckedMarketing => _isCheckedMarketing;
}
