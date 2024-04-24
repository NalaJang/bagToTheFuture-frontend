import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_ex/config/common/sized_box_values.dart';
import 'package:rest_api_ex/config/custom_snack_bar.dart';
import 'package:rest_api_ex/design/svg_icon.dart';
import 'package:rest_api_ex/screen/view_model/sign_in_view_model.dart';

import '../../config/social_sign_in.dart';
import 'sign_in_email_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SignInViewModel>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 로고와 인사말
            signInTitle(),

            // 카카오톡 로그인 버튼
            kakaoSignInButton(context, viewModel),

            // 네이버 로그인 버튼
            naverSignInButton(context),

            // 이메일 로그인 버튼
            emailSignInButton(context),
          ],
        ),
      ),
    );
  }

  // 로고와 인사말
  Widget signInTitle() {
    return Column(
      children: [
        SvgIcon.logo(width: 50, height: 50),
        SizedBoxValues.gapH20,
        const Text(
          '마감 세일 상품을 \n서프라이즈 백으로 만나보세요',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // 카카오톡 로그인
  Widget kakaoSignInButton(BuildContext context, SignInViewModel viewModel) {
    return ElevatedButton(
      onPressed: () async {
        try {
          await viewModel.kakaoSignIn();
        } catch (error) {
          debugPrint(error.toString());
        }

        if (viewModel.user == null) {
          CustomSnackBar().showSnackBar(context, '로그인 실패');
        }
        if (viewModel.user != null) {
          CustomSnackBar().showSnackBar(context, '로그인 성공');
        }
      },
      child: const Text('카카오톡 로그인'),
    );
  }

  // 네이버 로그인
  Widget naverSignInButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await SocialSignIn(context).naverSignInProcess();
      },
      child: const Text('네이버 로그인'),
    );
  }

  Widget emailSignInButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EmailSignIn(),
          ),
        );
      },
      child: const Text('이메일 로그인'),
    );
  }
}
