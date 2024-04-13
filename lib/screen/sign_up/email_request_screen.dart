import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_ex/config/common/sized_box_values.dart';
import 'package:rest_api_ex/config/custom_app_bar.dart';
import 'package:rest_api_ex/config/validation_check.dart';
import 'package:rest_api_ex/config/user_info_text_form_field.dart';
import 'package:rest_api_ex/data/network/error_handler.dart';
import 'package:rest_api_ex/screen/view_model/email_auth_view_model.dart';

import '../../config/palette.dart';

class EmailRequestScreen extends StatelessWidget {
  final String appBarTitle;

  const EmailRequestScreen({
    super.key,
    required this.appBarTitle,
  });

  // final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => SignInViewModel(),
      builder: (context, child) {
        final viewModel = context.watch<SignInViewModel>();
        return Scaffold(
          appBar: CustomAppBar(
            title: appBarTitle,
          ),
          body: ModalProgressHUD(
            inAsyncCall: viewModel.showSpinner,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
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
          style: TextStyle(
            fontSize: 17.0,
          ),
        )
      ],
    );
  }

  // 이메일 인증 요청 버튼
  Widget emailAuthRequestButton(
      BuildContext context, SignInViewModel viewModel, String email) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: viewModel.isButtonEnabled
            ? Palette.primaryColor
            : Palette.disabledColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      onPressed: () {
        if (viewModel.isButtonEnabled == false) {
          return;
        }

        try {
          viewModel.emailSubmit(context, appBarTitle, email);
        } catch (e) {
          final errorMessage = ErrorHandler.handle(e).failure;
          print('screen errorMessage: $errorMessage}');
        }
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
