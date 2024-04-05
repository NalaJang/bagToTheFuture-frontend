import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rest_api_ex/data/model/user_model.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage();

  // 엑세스 토큰 저장
  Future<void> saveAccessToken(String accessToken) async {
    try {
      print('[SaveAccessToken]: $accessToken');
      await storage.write(key: '${Token.accessToken}', value: accessToken);
    } catch (e) {
      print('[ERROR AccessToken 저장 실패: $e]');
    }
  }

  // 엑세스 토큰 불러오기
  Future<String?> readAccessToken() async {
    try {
      final accessToken = await storage.read(key: '${Token.accessToken}');

      return accessToken;
    } catch (e) {
      print('[ERROR AccessToken 불러오기 실패: $e]');
      return '';
    }
  }

  // 리프레시 토큰 저장
  Future<void> saveRefreshToken(String refreshToken) async {
    try {
      print('[SaveRefreshToken]: $refreshToken');
      await storage.write(key: '${Token.refreshToken}', value: refreshToken);
    } catch (e) {
      print('[ERROR RefreshToken 저장 실패: $e]');
    }
  }

  // 리프레시 토큰 불러오기
  Future<String?> readRefreshToken() async {
    try {
      final refreshToken = await storage.read(key: '${Token.refreshToken}');

      return refreshToken;
    } catch (e) {
      print('[ERROR RefreshToken 불러오기 실패: $e]');
      return '';
    }
  }

  Future<void> saveUserInfo(UserModel userInfo) async {
    try {
      print('[SaveUserInfo]');
      String phoneNumList = jsonEncode(userInfo.phoneNumber);
      await storage.write(key: '${Token.userName}', value: userInfo.name);
      await storage.write(key: '${Token.userEmail}', value: userInfo.email);
      await storage.write(key: '${Token.userPhoneNumber}', value: phoneNumList);
    } catch (e) {
      print('[ERROR UserInfo 저장 실패: $e]');
    }
  }

  Future<UserModel?> readUserInfo() async {
    try {
      final name = await storage.read(key: '${Token.userName}');
      final email = await storage.read(key: '${Token.userEmail}');
      final phoneNumber = await storage.read(key: '${Token.userPhoneNumber}');

      return UserModel(
        name: name!,
        email: email!,
        password: '',
        passwordConfirm: '',
        phoneNumber: jsonDecode(phoneNumber!),
      );
    } catch (e) {
      print('[ERROR UserInfo 불러오기 실패: $e]');
      return null;
    }
  }

  Future<void> signOut() async {
    await storage.delete(key: '${Token.accessToken}');
    await storage.delete(key: '${Token.refreshToken}');
    print('signOut');
  }
}

enum Token { accessToken, refreshToken, userEmail, userName, userPhoneNumber }
