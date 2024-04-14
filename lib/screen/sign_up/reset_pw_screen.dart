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
import 'package:rest_api_ex/screen/view_model/reset_pw_view_model.dart';

class ResetPwScreen extends StatelessWidget {
  const ResetPwScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResetPwViewModel(),
      builder: (context, child) {
        final viewModel = context.watch<ResetPwViewModel>();

        return Scaffold(
          appBar: const CustomAppBar(title: Constants.resetPw),
          body: ModalProgressHUD(
            inAsyncCall: viewModel.showSpinner,
            child: Form(
              key: viewModel.formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _description(),
                    SizedBoxValues.gapH20,
                    _inputPassword(viewModel),
                    SizedBoxValues.gapH20,
                    _changePassword(viewModel, context),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _description() {
    return Text(
      Constants.resetPwDescription,
      style: FontStyles.Title2.copyWith(
        color: AppColors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _inputPassword(ResetPwViewModel viewModel) {
    return Column(
      children: [
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
          controller: viewModel.userPasswordController,
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
          controller: viewModel.userPasswordConfirmController,
          validator: (value) => validateConfirmPassword(
            value,
            viewModel.userPasswordController.text,
          ),
          decorationLabelText: Constants.pwValidationRule,
        ),
      ],
    );
  }

  Widget _changePassword(ResetPwViewModel viewModel, BuildContext context) {
    return CustomSubmitButton(
      formKey: viewModel.formKey,
      buttonText: Constants.submitNewPw,
      nextPage: const MyBottomNavigation(),
      onPressedCallback: () => viewModel.submitNewPassword(context, 'password'),
    );
  }
}
