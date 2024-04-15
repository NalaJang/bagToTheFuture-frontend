import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_ex/config/common/sized_box_values.dart';
import 'package:rest_api_ex/config/constants.dart';
import 'package:rest_api_ex/config/custom_app_bar.dart';
import 'package:rest_api_ex/config/validation_check.dart';
import 'package:rest_api_ex/config/user_info_text_form_field.dart';
import 'package:rest_api_ex/data/network/error_handler.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/screen/view_model/email_auth_view_model.dart';

class EmailRequestScreen extends StatelessWidget {
  final String appBarTitle;

  const EmailRequestScreen({
    super.key,
    required this.appBarTitle,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => EmailAuthViewModel(context),
      builder: (context, child) {
        final viewModel = context.watch<EmailAuthViewModel>();

        return Scaffold(
          appBar: CustomAppBar(title: appBarTitle),
          body: ModalProgressHUD(
            inAsyncCall: viewModel.showSpinner,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 설명 문구,
                    description(),

                    // 이메일 입력
                    UserInfoTextFormField(
                      autoFocus: true,
                      isButtonEnabled:
                          viewModel.isButtonEnabled == true ? true : false,
                      textInputType: TextInputType.emailAddress,
                      controller: viewModel.userEmailController,
                      validator: validateEmail,
                      decorationLabelText: '',
                    ),

                    // 이메일 인증 요청 버튼
                    emailAuthRequestButton(
                        context, viewModel, viewModel.userEmailController.text),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // 설명 문구
  Widget description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Constants.emailInputPrompt,
          style: FontStyles.Title2.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBoxValues.gapH10,
        Text(
          Constants.emailAuthDescription1,
          style: FontStyles.Body2.copyWith(color: AppColors.gray5),
        )
      ],
    );
  }

  // 이메일 인증 요청 버튼
  Widget emailAuthRequestButton(
      BuildContext context, EmailAuthViewModel viewModel, String email) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        side: viewModel.isButtonEnabled
            ? const BorderSide(color: AppColors.main)
            : const BorderSide(color: AppColors.gray4),
        backgroundColor:
            viewModel.isButtonEnabled ? AppColors.main : AppColors.gray4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      onPressed: () {
        if (viewModel.isButtonEnabled == false) {
          return;
        }

        try {
          viewModel.emailSubmit(appBarTitle, email);
        } catch (e) {
          final errorMessage = ErrorHandler.handle(e).failure;
          print('screen errorMessage: $errorMessage}');
        }
      },
      child: Text(
        Constants.emailAuthRequest,
        style: FontStyles.Body2.copyWith(color: AppColors.white),
      ),
    );
  }
}
