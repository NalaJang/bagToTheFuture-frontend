import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_ex/data/di.dart';

import 'ui/bottom_nav_controller.dart';
import 'ui/my_bottom_navigation.dart';
import 'ui/sign_in/user_provider.dart';

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
        ChangeNotifierProvider<BottomNavController>(
            create: (_) => BottomNavController()),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyBottomNavigation(),
      ),
    );
  }
}
