import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_ex/config/common/sized_box_values.dart';
import 'package:rest_api_ex/config/constants.dart';
import 'package:rest_api_ex/config/custom_app_bar.dart';
import 'package:rest_api_ex/config/navigate_to.dart';
import 'package:rest_api_ex/config/validation_check.dart';
import 'package:rest_api_ex/config/user_info_text_form_field.dart';
import 'package:rest_api_ex/data/network/error_handler.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/screen/sign_up/email_auth_check_screen.dart';
import 'package:rest_api_ex/screen/view_model/email_request_view_model.dart';

class EmailRequestScreen extends StatefulWidget {
  final String appBarTitle;

  const EmailRequestScreen({
    super.key,
    required this.appBarTitle,
  });

  @override
  State<EmailRequestScreen> createState() => _EmailRequestScreenState();
}

class _EmailRequestScreenState extends State<EmailRequestScreen> {
  final _userEmailController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    _userEmailController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _userEmailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<EmailRequestViewModel>();

    return Scaffold(
      appBar: CustomAppBar(title: widget.appBarTitle),
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
                  isButtonEnabled: _isButtonEnabled == true ? true : false,
                  textInputType: TextInputType.emailAddress,
                  controller: _userEmailController,
                  validator: validateEmail,
                  decorationLabelText: '',
                ),

                // 이메일 인증 요청 버튼
                emailAuthRequestButton(
                    context, viewModel, _userEmailController.text),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 이메일 유효성 검사에 따라 버튼 색상 활성화를 하기 위한 콜백 함수
  void _updateButtonState() {
    if (validateEmail(_userEmailController.text) == null) {
      _isButtonEnabled = true;
    } else {
      _isButtonEnabled = false;
    }
    setState(() {});
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
      BuildContext context, EmailRequestViewModel viewModel, String email) {
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
          viewModel.emailSubmit(email, (result) {
            if (result == '이메일이 전송되었습니다.') {
              navigateTo(
                context,
                EmailAuthCheckScreen(
                  appBarTitle: widget.appBarTitle,
                  userEmail: email,
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(result),
                ),
              );
            }
          });
        } catch (e) {
          final errorMessage = ErrorHandler.handle(e).failure;
          debugPrint('screen errorMessage: $errorMessage');
        }
      },
      child: Text(
        Constants.emailAuthRequest,
        style: FontStyles.Body2.copyWith(color: AppColors.white),
      ),
    );
  }
}
