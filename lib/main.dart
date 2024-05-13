import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_ex/config/di.dart';
import 'package:rest_api_ex/config/social_sign_in.dart';
import 'package:rest_api_ex/screen/home/home_viewmodel.dart';
import 'package:rest_api_ex/screen/view_model/edit_my_profile_view_model.dart';
import 'package:rest_api_ex/screen/view_model/reset_pw_view_model.dart';
import 'package:rest_api_ex/screen/view_model/email_auth_view_model.dart';
import 'package:rest_api_ex/screen/view_model/email_request_view_model.dart';
import 'package:rest_api_ex/screen/splash/first_splash_screen.dart';
import 'package:rest_api_ex/screen/view_model/setting_view_model.dart';
import 'package:rest_api_ex/screen/view_model/store_info_view_model.dart';
import 'package:rest_api_ex/screen/view_model/sign_in_view_model.dart';
import 'package:rest_api_ex/screen/sign_in/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if(Platform.isAndroid) {
    print('백그라운드 메시지 처리.. ${message.notification!.body}');
  }
}

void initializeNotification() async {
  if(Platform.isAndroid) {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    if(Platform.isAndroid) {
      final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(const AndroidNotificationChannel(
          'high_importance_channel', 'high_importance_notification',
          importance: Importance.max));

      await flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
        android:AndroidInitializationSettings("@mipmap/ic_launcher"),
      ));
      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  String? clientId = dotenv.env['NAVER_MAP_CLIENT_ID'];
  await NaverMapSdk.instance.initialize(clientId: clientId);
  await initModule();
  if(Platform.isAndroid) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StoreInfoViewModel()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider<HomeViewModel>(create: (_) => HomeViewModel()),
        ChangeNotifierProvider<EmailRequestViewModel>(create: (_) => EmailRequestViewModel()),
        ChangeNotifierProvider<EmailAuthViewModel>(create: (_) => EmailAuthViewModel()),
        ChangeNotifierProvider(
            create: (context) =>
                SignInViewModel(socialSignIn: SocialSignIn(context))),
        ChangeNotifierProvider(create: (_) => ResetPwViewModel()),
        ChangeNotifierProvider(create: (_) => EditMyProfileViewModel()),
        ChangeNotifierProvider(create: (_) => SettingViewModel()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FirstSplashScreen(),
      ),
    );
  }
}