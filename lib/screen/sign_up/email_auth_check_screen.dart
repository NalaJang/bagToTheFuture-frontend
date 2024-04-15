import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_ex/config/constants.dart';
import 'package:rest_api_ex/config/custom_app_bar.dart';
import 'package:rest_api_ex/config/user_info_text_form_field.dart';
import 'package:rest_api_ex/config/validation_check.dart';
import 'package:rest_api_ex/data/network/error_handler.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/screen/sign_up/reset_pw_screen.dart';
import 'package:rest_api_ex/screen/sign_up/sign_up_screen.dart';
import 'package:rest_api_ex/screen/view_model/email_auth_view_model.dart';

class EmailAuthCheckScreen extends StatefulWidget {
  final String appBarTitle;
  final String _userEmail;

  const EmailAuthCheckScreen({
    super.key,
    required this.appBarTitle,
    required String userEmail,
  }) : _userEmail = userEmail;

  @override
  State<EmailAuthCheckScreen> createState() => _EmailAuthCheckScreenState();
}

class _EmailAuthCheckScreenState extends State<EmailAuthCheckScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => EmailAuthViewModel(context),
      builder: (context, child) {
        final viewModel = context.watch<EmailAuthViewModel>();

        return Scaffold(
          appBar: CustomAppBar(title: widget.appBarTitle),
          body: ModalProgressHUD(
            inAsyncCall: viewModel.showSpinner,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 설명 문구,
                      description(widget._userEmail),

                      UserInfoTextFormField(
                        autoFocus: true,
                        isButtonEnabled:
                            viewModel.isButtonEnabled == true ? true : false,
                        textInputType: TextInputType.emailAddress,
                        controller: viewModel.emailAuthCodeController,
                        validator: validateAuthCode,
                        decorationLabelText: '',
                      ),

                      // 이메일 인증하기 버튼
                      emailAuthRequestButton(
                        context,
                        viewModel,
                        widget._userEmail,
                      ),

                      // 이메일 재전송
                      if (widget.appBarTitle == Constants.signUp)
                        emailResendButton(viewModel, widget._userEmail),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // 설명 문구
  Widget description(String userEmail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.appBarTitle == Constants.signUp)
          Text(
            Constants.emailAuth,
            style: FontStyles.Title2.copyWith(color: AppColors.black),
          ),

        // 사용자가 입력한 이메일 주소
        Text(
          userEmail,
          style: FontStyles.Title3.copyWith(color: AppColors.main),
        ),

        Text(
          Constants.emailAuthDescription2,
          style: FontStyles.Body2.copyWith(color: AppColors.gray5),
        ),
      ],
    );
  }

  // 이메일 인증하기 버튼
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
          if( widget.appBarTitle == Constants.signUp ) {
            viewModel.authCodeSubmit(email, SignUpScreen(userEmail: email));
          } else {
            viewModel.authCodeSubmit(email, const ResetPwScreen());
          }

        } catch (e) {
          final errorMessage = ErrorHandler.handle(e).failure;
          debugPrint(errorMessage);
        }
      },
      child: Text(
        Constants.emailAuth,
        style: FontStyles.Body2.copyWith(color: AppColors.white),
      ),
    );
  }

  // 이메일 재전송
  Widget emailResendButton(EmailAuthViewModel viewModel, String email) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.main),
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      onPressed: () {
        viewModel.emailResend(email);
      },
      child: Text(
        Constants.resendEmail,
        style: FontStyles.Body2.copyWith(color: AppColors.main),
      ),
    );
  }
}
