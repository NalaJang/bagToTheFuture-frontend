import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rest_api_ex/config/constants.dart';
import 'package:rest_api_ex/data/source/rest_client.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';

class EmailAuthCheckScreen extends StatefulWidget {
  final String _userEmail;

  const EmailAuthCheckScreen({
    super.key,
    required String userEmail,
  }) : _userEmail = userEmail;

  @override
  State<EmailAuthCheckScreen> createState() => _EmailAuthCheckScreenState();
}

class _EmailAuthCheckScreenState extends State<EmailAuthCheckScreen> {
  bool showSpinner = false;
  final formKey = GlobalKey<FormState>();
  final int authCodeLength = 6;

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

                  // 이메일 재전송
                  emailResendButton(context, widget._userEmail),

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
          Constants.emailAuthDescription1,
          style: FontStyles.Body2.copyWith(color: AppColors.gray5),
        ),

        Text(
          Constants.emailAuthDescription2,
          style: FontStyles.Body2.copyWith(
            color: AppColors.gray5,
          ),
        ),
      ],
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
        await restClient.emailAuth(email);

        // 아직 디자인 안 나온 부분. 추후 수정 예정
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('이메일이 재전송되었습니다.'),
          ),
        );
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

  Widget requestResendEmailDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Constants.requestResendEmail1,
          style: FontStyles.Caption3.copyWith(color: AppColors.gray4),
        ),
        Row(
          children: [
            Text(
              Constants.requestResendEmail2,
              style: FontStyles.Caption3.copyWith(color: AppColors.gray4),
            ),
          ],
        ),
      ],
    );
  }
}
