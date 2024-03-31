import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage();

  // 엑세스 토큰 저장
  Future<void> saveAccessToken(String accessToken) async {
    try {
      print('[SaveAccessToken]: $accessToken');
      await storage.write(
          key: '${Token.accessToken}', value: accessToken);

    } catch (e) {
      print('[ERROR AccessToken 저장 실패: $e]');
    }
  }

  // 엑세스 토큰 불러오기
  Future<String?> readAccessToken() async {
    try {
      final accessToken =
          await storage.read(key: '${Token.accessToken}');

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
      await storage.write(
          key: '${Token.refreshToken}', value: refreshToken);
    } catch (e) {
      print('[ERROR RefreshToken 저장 실패: $e]');
    }
  }

  // 리프레시 토큰 불러오기
  Future<String?> readRefreshToken() async {
    try {
      final refreshToken =
          await storage.read(key: '${Token.refreshToken}');

      return refreshToken;
    } catch (e) {
      print('[ERROR RefreshToken 불러오기 실패: $e]');
      return '';
    }
  }
}

enum Token { accessToken, refreshToken }
