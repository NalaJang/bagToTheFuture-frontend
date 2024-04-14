import 'package:flutter/cupertino.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:rest_api_ex/config/social_sign_in.dart';

class SignInViewModel with ChangeNotifier {
  final SocialSignIn _socialSignIn;
  SignInPlatform _signInPlatform = SignInPlatform.none;
  bool _isSignedIn = false;
  User? _user;

  SignInViewModel({
    required SocialSignIn socialSignIn,
  }) : _socialSignIn = socialSignIn;

  SocialSignIn get socialSignIn => _socialSignIn;

  bool get isSignedIn => _isSignedIn;

  User? get user => _user;

  SignInPlatform get signInPlatform => _signInPlatform;

  Future<void> kakaoSignIn() async {
    _isSignedIn = await _socialSignIn.kakaoTalkSignInProcess();

    try {
      if (_isSignedIn) {
        _user = await UserApi.instance.me();
        String? email = _user!.kakaoAccount?.email;
        String? nickName = _user!.kakaoAccount?.profile?.nickname;

        _signInPlatform = SignInPlatform.kakao;
      }
    } catch (error) {
      debugPrint(error.toString());
    }

    notifyListeners();
  }
}
