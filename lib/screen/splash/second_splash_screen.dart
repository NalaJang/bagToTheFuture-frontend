import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rest_api_ex/config/navigate_to.dart';
import 'package:rest_api_ex/design/svg_icon.dart';
import 'package:rest_api_ex/screen/sign_in/sign_in_screen.dart';

class SecondSplashScreen extends StatefulWidget {
  const SecondSplashScreen({super.key});

  @override
  State<SecondSplashScreen> createState() => _SecondSplashScreenState();
}

class _SecondSplashScreenState extends State<SecondSplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 2000), checkNotificationStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgIcon.backToTheFutureTextLogo(),
      ),
    );
  }

  void checkNotificationStatus() async {
    await Permission.notification.request();

    if (mounted) {
      navigatePushAndRemoveUtilTo(context, const SignInScreen());
    }
  }
}
