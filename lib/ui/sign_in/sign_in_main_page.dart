import 'package:flutter/material.dart';
import 'package:rest_api_ex/config/gaps.dart';

import '../../config/social_sign_in.dart';
import 'sign_in_email.dart';

class MainSignInPage extends StatelessWidget {
  const MainSignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 로고와 인사말
            signInTitle(),

            // 카카오톡 로그인 버튼
            kakaoSignInButton(context),

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
        Image.asset('assets/images/btf_logo.png'),
        Gaps.gapH20,
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
  Widget kakaoSignInButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await SocialSignIn(context).kakaoTalkSignInProcess();
      },
      child: Text('카카오톡 로그인'),
    );
  }

  // 네이버 로그인
  Widget naverSignInButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await SocialSignIn(context).naverSignInProcess();
      },
      child: Text('네이버 로그인'),
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
      child: Text('이메일 로그인'),
    );
  }
}
