import 'package:get_it/get_it.dart';

import 'secure_storage.dart';
import 'source/rest_client.dart';

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
}
