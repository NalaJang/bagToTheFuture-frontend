import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:rest_api_ex/data/network/custom_interceptor.dart';
import 'package:rest_api_ex/data/source/rest_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final instance = GetIt.instance;

Future<void> initModule() async {

  final dio = Dio();

  dio.interceptors.add(CustomInterceptor());

  instance.registerLazySingleton(() => RestClient(dio));

  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsFlutterBinding.ensureInitialized();
  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    // 네이티브 앱만 서비스
    nativeAppKey: '81744e25b42accb8e343708484a15cda',
  );

  await dotenv.load(fileName: 'assets/config/.env');
}