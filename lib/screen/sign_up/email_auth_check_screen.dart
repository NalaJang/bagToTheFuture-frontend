import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rest_api_ex/config/constants.dart';
import 'package:rest_api_ex/config/validation_check.dart';
import 'package:rest_api_ex/config/navigate_to.dart';
import 'package:rest_api_ex/config/user_info_text_form_field.dart';
import 'package:rest_api_ex/data/network/error_handler.dart';
import 'package:rest_api_ex/data/source/rest_client.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/screen/sign_up/email_request_screen.dart';

import '../../config/palette.dart';
import 'sign_up_screen.dart';

class EmailAuthCheckScreen extends StatefulWidget {
  const EmailAuthCheckScreen({required String userEmail, super.key}) : _userEmail = userEmail;

  final String _userEmail;

  @override
  State<EmailAuthCheckScreen> createState() => _EmailAuthCheckScreenState();
}

class _EmailAuthCheckScreenState extends State<EmailAuthCheckScreen> {
  bool showSpinner = false;
  bool _isButtonEnabled = false;
  final formKey = GlobalKey<FormState>();
  final _authCodeController = TextEditingController();
  final int authCodeLength = 6;


  @override
  void initState() {
    super.initState();

    // 텍스트 길이에 따라 버튼 색상 활성화를 하기 위한 콜백 함수
    // 함수를 호출하는 게 아니라, 콜백으로 전달하기 때문에 괄호를 사용하지 않는다.
    _authCodeController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    super.dispose();
    _authCodeController.dispose();
  }

  // 텍스트 길이에 따라 버튼 색상 활성화를 하기 위한 콜백 함수
  void _updateButtonState() {
    setState(() {
      if( _authCodeController.text.length == authCodeLength ) {
        _isButtonEnabled = true;
      } else {
        _isButtonEnabled = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Constants.signUp,
          style: FontStyles.Title3,
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
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

                  // 이메일 재전송 버튼
                  emailResendButton(context, _isButtonEnabled, widget._userEmail),

                  // 이메일 변경하기
                  changeEmailButton(context),

                  // 코드 재전송
                  requestResendEmailDescription(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 설명 문구
  Widget description(String userEmail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          Constants.emailAuth,
          style: FontStyles.Title2,
        ),

        // 사용자가 입력한 이메일 주소
        Text(
          userEmail,
          style: const TextStyle(fontSize: 17.0, color: AppColors.main,),
        ),
        const Text(
          Constants.emailAuthDescription1,
          style: TextStyle(
            fontSize: 17.0,
            color: AppColors.gray5,
          ),
        ),
        const Text(
          Constants.emailAuthDescription2,
          style: TextStyle(
            fontSize: 17.0,
            color: AppColors.gray5,
          ),
        ),
      ],
    );
  }

  // 이메일 재전송 버튼
  Widget emailResendButton(BuildContext context, bool buttonEnabled, String email) {
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
        await restClient.emailAuth(email);
      },
      child: const Text(
        Constants.resendEmail,
        style: TextStyle(
          color: AppColors.white,
        ),
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
          side: BorderSide(color: AppColors.main),
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      onPressed: () async {
        navigatePushAndRemoveUtilTo(context, const EmailRequestScreen());
      },
      child: const Text(
        Constants.changeEmail,
        style: TextStyle(
          color: AppColors.main,
        ),
      ),
    );
  }


  Widget requestResendEmailDescription() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Constants.requestResendEmail1,
          style: TextStyle(
            color: Palette.disabledColor,
          ),
        ),

        Row(
          children: [
            Text(
              Constants.requestResendEmail2,
              style: TextStyle(
                color: Palette.disabledColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
