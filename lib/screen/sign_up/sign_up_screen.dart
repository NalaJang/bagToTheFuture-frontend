import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_ex/config/constants.dart';
import 'package:rest_api_ex/config/custom_app_bar.dart';
import 'package:rest_api_ex/config/validation_check.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/screen/sign_up/components/terms_of_use.dart';
import 'package:rest_api_ex/screen/view_model/sign_up_view_model.dart';

import 'components/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  final String userEmail;

  const SignUpScreen({
    super.key,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignUpViewModel(),
      builder: (context, child) {
        final viewModel = context.watch<SignUpViewModel>();

        return Scaffold(
          appBar: const CustomAppBar(title: Constants.signUp),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: ModalProgressHUD(
              inAsyncCall: viewModel.showSpinner,
              child: SingleChildScrollView(
                child: Form(
                  key: viewModel.formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 27),
                    child: Column(
                      children: [
                        SignUpForm(
                          formKey: viewModel.formKey,
                          userEmail: userEmail,
                          userPasswordController:
                              viewModel.userPasswordController,
                          userPasswordConfirmController:
                              viewModel.userPasswordConfirmController,
                          userNickNameController:
                              viewModel.userNickNameController,
                          userBirthController: viewModel.userBirthController,
                          userBank: viewModel.userBank,
                          accountHolderController:
                              viewModel.accountHolderController,
                          accountController: viewModel.accountController,
                        ),

                        // 이용약관 동의
                        TermsOfUse(
                          isCheckedAllTermsOfUse:
                              viewModel.isCheckedAllTermsOfUse,
                          isCheckedNecessaryTermsOfUse1:
                              viewModel.isCheckedNecessaryTermsOfUse1,
                          isCheckedNecessaryTermsOfUse2:
                              viewModel.isCheckedNecessaryTermsOfUse2,
                          isCheckedNecessaryTermsOfUse3:
                              viewModel.isCheckedNecessaryTermsOfUse3,
                          isCheckedNecessaryTermsOfUse4:
                              viewModel.isCheckedNecessaryTermsOfUse4,
                          isCheckedMarketing: viewModel.isCheckedMarketing,
                          onAllTermsOfUsePressed: () =>
                              viewModel.onAllTermsOfUsePressed(),
                          onTermsOfUse1Pressed: () =>
                              viewModel.onTermsOfUse1Pressed(),
                          onTermsOfUse2Pressed: () =>
                              viewModel.onTermsOfUse2Pressed(),
                          onTermsOfUse3Pressed: () =>
                              viewModel.onTermsOfUse3Pressed(),
                          onTermsOfUse4Pressed: () =>
                              viewModel.onTermsOfUse4Pressed(),
                          onMarketingPressed: () =>
                              viewModel.onMarketingPressed(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: _buildBottomNavigationBar(context, viewModel),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(
      BuildContext context, SignUpViewModel viewModel) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xffe8e8e8),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xffe8e8e8),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(3, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 27),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                viewModel.isButtonEnabled ? AppColors.main : AppColors.gray4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          onPressed: () {
            if (!viewModel.isButtonEnabled) {
              return;
            }
            ValidationCheck().allUserInputValidation(viewModel.formKey);

            viewModel.signUpSubmit(context);
          },
          child: Text(
            Constants.submitSignUp,
            style: FontStyles.Body2.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
