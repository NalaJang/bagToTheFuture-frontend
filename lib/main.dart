import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_ex/config/di.dart';
import 'package:rest_api_ex/config/social_sign_in.dart';
import 'package:rest_api_ex/screen/my_bottom_navigation.dart';
import 'package:rest_api_ex/screen/sign_in/sign_in_view_model.dart';
import 'package:rest_api_ex/screen/sign_in/user_provider.dart';


void main() async {
  await initModule();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(
            create: (context) => SignInViewModel(socialSignIn: SocialSignIn(context))),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyBottomNavigation(),
      ),
    );
  }
}
