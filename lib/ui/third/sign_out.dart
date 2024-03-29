import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_ex/config/social_sign_in.dart';
import 'package:rest_api_ex/ui/sign_in/sign_in_main_page.dart';

import '../sign_in/user_provider.dart';

class SignOut extends StatelessWidget {
  const SignOut({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return GestureDetector(
      onTap: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainSignInPage()));
        await SocialSignIn(context).signOut(userProvider.signInState);
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
