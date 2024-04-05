import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rest_api_ex/config/validation_check.dart';
import 'package:rest_api_ex/config/navigate_to.dart';
import 'package:rest_api_ex/screen/my_bottom_navigation.dart';

import '../../config/palette.dart';
import '../../data/model/user_model.dart';
import '../../data/network/error_handler.dart';
import '../../data/source/rest_client.dart';
import 'components/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({required String userEmail, super.key}) : _userEmail = userEmail;

  final String _userEmail;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool showSpinner = false;
  final formKey = GlobalKey<FormState>();

  final userNickNameController = TextEditingController();
  final userEmailController = TextEditingController();
  final userPasswordController = TextEditingController();
  final userPasswordConfirmController = TextEditingController();
  final RestClient restClient = GetIt.instance<RestClient>();


  @override
  void dispose() {
    super.dispose();

    userNickNameController.dispose();
    userEmailController.dispose();
    userPasswordController.dispose();
    userPasswordConfirmController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
      ),

      body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SignUpForm(
                  formKey: formKey,
                  userEmail: widget._userEmail,
                  userNickNameController: userNickNameController,
                  userPasswordController: userPasswordController,
                  userPasswordConfirmController: userPasswordConfirmController,
                ),
              ],
            ),
          )
      ),

      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(15.0),
            backgroundColor: Palette.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),

          onPressed: () async {
            await _handleSignUpPressed();
            },

          child: const Text(
            '가입하기',
            style: TextStyle(
                color: Colors.white
            ),
          ),
        ),
      ),
    );
  }





  Future<void> _handleSignUpPressed() async {
    ValidationCheck().allUserInputValidation(formKey);

    setState(() {
      showSpinner = true;
    });

    List<String> phoneNumber = ['010', '1616', '1616'];
    var userModel = UserModel(
        name: 'test16',
        email: 'test16@email.com',
        password: '123456',
        passwordConfirm: '123456',
        phoneNumber: phoneNumber);

    try {
      await restClient.createUser(userModel.toJson());

      if( mounted ) {
        navigatePushAndRemoveUtilTo(context, const MyBottomNavigation());
      }

    } catch (error) {
      final errorMessage = ErrorHandler.handle(error).failure;

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );
      }
    }
    setState(() {
      showSpinner = false;
    });
  }
}
