import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_ex/config/common/sized_box_values.dart';
import 'package:rest_api_ex/config/constants.dart';
import 'package:rest_api_ex/config/custom_app_bar.dart';
import 'package:rest_api_ex/config/custom_submit_button.dart';
import 'package:rest_api_ex/config/user_info_text_form_field.dart';
import 'package:rest_api_ex/config/validation_check.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/screen/my_bottom_navigation.dart';
import 'package:rest_api_ex/screen/view_model/user_info_view_model.dart';

class ResetPwScreen extends StatefulWidget {
  const ResetPwScreen({super.key});

  @override
  State<ResetPwScreen> createState() => _ResetPwScreenState();
}

class _ResetPwScreenState extends State<ResetPwScreen> {
  bool showSpinner = false;
  final formKey = GlobalKey<FormState>();
  final _userPasswordController = TextEditingController();
  final _userPasswordConfirmController = TextEditingController();

  @override
  void dispose() {
    _userPasswordController.dispose();
    _userPasswordConfirmController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UserInfoViewModel>();

    return Scaffold(
      appBar: const CustomAppBar(title: Constants.resetPw),
      body: ModalProgressHUD(
        inAsyncCall: viewModel.isLoading,
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  Constants.resetPwDescription,
                  style: FontStyles.Title2.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBoxValues.gapH20,

                Row(
                  children: [
                    const Text(
                      Constants.password,
                      style: FontStyles.Body2,
                    ),
                    Text(
                      Constants.asterisk,
                      style: FontStyles.Body2.copyWith(color: AppColors.red),
                    )
                  ],
                ),

                // 비밀번호
                UserInfoTextFormField(
                  controller: _userPasswordController,
                  validator: validatePassword,
                  decorationLabelText: Constants.pwValidationRule,
                ),

                SizedBoxValues.gapH20,

                Row(
                  children: [
                    const Text(
                      Constants.checkPassword,
                      style: FontStyles.Body2,
                    ),
                    Text(
                      Constants.asterisk,
                      style: FontStyles.Body2.copyWith(color: AppColors.red),
                    )
                  ],
                ),

                // 비밀번호 확인
                UserInfoTextFormField(
                  controller: _userPasswordConfirmController,
                  validator: (value) => validateConfirmPassword(
                    value,
                    _userPasswordController.text,
                  ),
                  decorationLabelText: Constants.pwValidationRule,
                ),

                SizedBoxValues.gapH20,

                // 비밀번호 변경 버튼
                CustomSubmitButton(
                  formKey: formKey,
                  buttonText: Constants.submitNewPw,
                  nextPage: const MyBottomNavigation(),
                  viewModel: viewModel,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
