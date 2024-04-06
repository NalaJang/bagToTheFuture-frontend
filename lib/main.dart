import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_ex/config/di.dart';
import 'package:rest_api_ex/screen/my_bottom_navigation.dart';
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
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyBottomNavigation(),
      ),
    );
  }
}
