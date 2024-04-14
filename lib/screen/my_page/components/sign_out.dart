import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_ex/config/social_sign_in.dart';
import 'package:rest_api_ex/screen/sign_in/sign_in_screen.dart';
import 'package:rest_api_ex/screen/sign_in/sign_in_view_model.dart';

class SignOut extends StatelessWidget {
  const SignOut({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<SignInViewModel>(context);

    return GestureDetector(
      onTap: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignInScreen()));

        await SocialSignIn(context).signOut(viewModel.signInPlatform);
      },
      child: const Padding(
        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: Center(
          child: Text(
            '로그아웃',
            style: TextStyle(decoration: TextDecoration.underline),
          ),
        ),
      ),
    );
  }
}
