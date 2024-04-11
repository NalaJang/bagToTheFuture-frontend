import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rest_api_ex/config/common/sized_box_values.dart';
import 'package:rest_api_ex/config/custom_app_bar.dart';
import 'package:rest_api_ex/config/validation_check.dart';
import 'package:rest_api_ex/config/user_info_text_form_field.dart';
import 'package:rest_api_ex/data/network/error_handler.dart';
import 'package:rest_api_ex/data/source/rest_client.dart';

import '../../config/navigate_to.dart';
import '../../config/palette.dart';
import 'email_auth_check_screen.dart';

class EmailRequestScreen extends StatefulWidget {
  final String appBarTitle;

  const EmailRequestScreen({super.key, required this.appBarTitle,});

  @override
  State<EmailRequestScreen> createState() => _EmailRequestScreenState();
}

class _EmailRequestScreenState extends State<EmailRequestScreen> {
  bool showSpinner = false;
  bool _isButtonEnabled = false;
  final formKey = GlobalKey<FormState>();
  final _userEmailController = TextEditingController();


  @override
  void initState() {
    super.initState();

    // 이메일 유효성 검사에 따라 버튼 색상 활성화를 하기 위한 콜백 함수
    // 함수를 호출하는 게 아니라, 콜백으로 전달하기 때문에 괄호를 사용하지 않는다.
    _userEmailController.addListener(_updateButtonState);
  }


  @override
  void dispose() {
    super.dispose();
    _userEmailController.dispose();
  }


  // 이메일 유효성 검사에 따라 버튼 색상 활성화를 하기 위한 콜백 함수
  void _updateButtonState() {
    setState(() {

      if( validateEmail(_userEmailController.text) == null ) {
        _isButtonEnabled = true;
      } else {
        _isButtonEnabled = false;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.appBarTitle,),
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
                  emailAuthRequestButton(context, _isButtonEnabled, _userEmailController.text),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 설명 문구
  Widget description() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '이메일을 입력해 주세요',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBoxValues.gapH10,
        Text(
          '인증 코드를 보내드려요',
          style: TextStyle(fontSize: 17.0,),
        )
      ],
    );
  }

  // 이메일 인증 요청 버튼
  Widget emailAuthRequestButton(BuildContext context, bool buttonEnabled, String email) {
    final RestClient restClient = GetIt.instance<RestClient>();

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
        _isButtonEnabled ? Palette.primaryColor : Palette.disabledColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),

      onPressed: () async {
        ValidationCheck().allUserInputValidation(formKey);

        setState(() {
          showSpinner = true;
        });

        try {

          await restClient.emailAuth(email);

          if (context.mounted) {
            navigateTo(context, EmailAuthCheckScreen(
              appBarTitle: widget.appBarTitle,
              userEmail: email),
            );
          }
        } catch(e) {
          final errorMessage = ErrorHandler.handle(e).failure;
          print(errorMessage);
        }

        setState(() {
          showSpinner = false;
        });

      },

      child: const Text(
        '이메일 인증 요청',
        style: TextStyle(
          color: Palette.whiteTextColor,
        ),
      ),
    );
  }
}
