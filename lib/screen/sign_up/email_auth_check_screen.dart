import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_ex/config/constants.dart';
import 'package:rest_api_ex/config/custom_app_bar.dart';
import 'package:rest_api_ex/config/navigate_to.dart';
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
  final _emailAuthCodeController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    _emailAuthCodeController.addListener(_updateAuthState);
  }

  @override
  void dispose() {
    _emailAuthCodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<EmailAuthViewModel>();

    return Scaffold(
      appBar: CustomAppBar(title: widget.appBarTitle),
      body: ModalProgressHUD(
        inAsyncCall: viewModel.showSpinner,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Form(
            key: viewModel.formKey,
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
                    isButtonEnabled: _isButtonEnabled == true ? true : false,
                    textInputType: TextInputType.emailAddress,
                    controller: _emailAuthCodeController,
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
  }

  // 이메일 인증하기 버튼 활성화
  void _updateAuthState() {
    if (validateAuthCode(_emailAuthCodeController.text) == null) {
      _isButtonEnabled = true;
    } else {
      _isButtonEnabled = false;
    }
    setState(() {});
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
        side: _isButtonEnabled
            ? const BorderSide(color: AppColors.main)
            : const BorderSide(color: AppColors.gray4),
        backgroundColor: _isButtonEnabled ? AppColors.main : AppColors.gray4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      onPressed: () {
        if (_isButtonEnabled == false) {
          return;
        }

        try {
          viewModel.authCodeSubmit(email, _emailAuthCodeController.text,
              (result) {
            if (result == 'true') {
              if (widget.appBarTitle == Constants.signUp) {
                navigateTo(context, SignUpScreen(userEmail: email));
              } else {
                navigateTo(context, const ResetPwScreen());
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('인증 코드가 맞지 않습니다.'),
                ),
              );
            }
          });
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('이메일이 재전송되었습니다.'),
          ),
        );
      },
      child: Text(
        Constants.resendEmail,
        style: FontStyles.Body2.copyWith(color: AppColors.main),
      ),
    );
  }
}
