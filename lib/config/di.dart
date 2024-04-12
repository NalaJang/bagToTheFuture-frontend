import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:rest_api_ex/data/network/custom_interceptor.dart';
import 'package:rest_api_ex/data/source/rest_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final instance = GetIt.instance;

Future<void> initModule() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dio = Dio();

  dio.interceptors.add(CustomInterceptor());

  instance.registerLazySingleton(() => RestClient(dio));

  await dotenv.load(fileName: '.env');

  // KakaoSdk.init(nativeAppKey: '81744e25b42accb8e343708484a15cda');
  KakaoSdk.init(nativeAppKey: dotenv.env['KAKAO_NATIVE_APP_KEY']);
}