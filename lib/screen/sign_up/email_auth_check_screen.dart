import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_ex/config/constants.dart';
import 'package:rest_api_ex/config/custom_app_bar.dart';
import 'package:rest_api_ex/config/user_info_text_form_field.dart';
import 'package:rest_api_ex/config/validation_check.dart';
import 'package:rest_api_ex/data/network/error_handler.dart';
import 'package:rest_api_ex/data/source/rest_client.dart';
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
  bool showSpinner = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => EmailAuthViewModel(),
      builder: (context, child) {
        final viewModel = context.watch<EmailAuthViewModel>();

        return Scaffold(
          appBar: CustomAppBar(title: widget.appBarTitle),
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
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
                      emailResendButton(context, widget._userEmail),

                      // 이메일 변경하기
                      if (widget.appBarTitle == Constants.signUp)
                        changeEmailButton(context),

                      // 설명 문구
                      requestResendEmailDescription(),
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
          Constants.emailAuthDescription,
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
            viewModel.authCodeSubmit(context, email, SignUpScreen(userEmail: email));
          } else {
            viewModel.authCodeSubmit(context, email, const ResetPwScreen());
          }

        } catch (e) {
          final errorMessage = ErrorHandler.handle(e).failure;
          debugPrint(errorMessage);
        }
      },
      child: const Text(
        '이메일 인증 요청',
        style: TextStyle(
          color: AppColors.white,
        ),
      ),
    );
  }

  // 이메일 재전송
  Widget emailResendButton(BuildContext context, String email) {
    final RestClient restClient = GetIt.instance<RestClient>();

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.main,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.main),
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      onPressed: () async {
        setState(() {
          showSpinner = true;
        });
        try {
          await restClient.emailAuth(email);

          // 아직 디자인 안 나온 부분. 추후 수정 예정
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('이메일이 재전송되었습니다.'),
            ),
          );
        } catch (error) {}

        setState(() {
          showSpinner = false;
        });
      },
      child: Text(
        Constants.resendEmail,
        style: FontStyles.Body2.copyWith(color: AppColors.white),
      ),
    );
  }

  // 이메일 변경하기
  Widget changeEmailButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.main),
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        Constants.changeEmail,
        style: FontStyles.Body2.copyWith(color: AppColors.main),
      ),
    );
  }

  // 설명 문구
  Widget requestResendEmailDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Constants.requestResendEmail1,
          style: FontStyles.Body8.copyWith(color: AppColors.gray4),
        ),
        Row(
          children: [
            Text(
              Constants.requestResendEmail2,
              style: FontStyles.Body8.copyWith(color: AppColors.gray4),
            ),
          ],
        ),
      ],
    );
  }
}
