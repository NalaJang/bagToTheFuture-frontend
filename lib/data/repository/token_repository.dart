import 'package:get_it/get_it.dart';

import '../../config/secure_storage.dart';
import '../source/rest_client.dart';

class TokenRepository {
  final SecureStorage storage = SecureStorage();
  final RestClient restClient = GetIt.instance<RestClient>();

  Future<void> signIn(String email, String password) async {
    final result = await restClient.emailLogin(email, password);
    final String accessToken = result.data.accessToken;
    final String refreshToken = result.data.refreshToken;

    await Future.wait([
      storage.saveAccessToken(accessToken),
      storage.saveRefreshToken(refreshToken),
    ]);
  }

  Future<void> signOut() async {
    // final refreshToken = await storage.readRefreshToken();
    // dio.options.headers["authorization"] = "Bearer $refreshToken";
    // await dio.post('http://10.0.2.2:8080/v1/logout');
    await storage.signOut();
  }

}
