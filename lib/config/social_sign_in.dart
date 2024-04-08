import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get_it/get_it.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_ex/data/model/oauth_model.dart';
import 'package:rest_api_ex/data/source/rest_client.dart';
import 'package:rest_api_ex/screen/sign_in/user_provider.dart';

import '../data/network/error_handler.dart';

enum SignInPlatform {
  kakao,
  naver,
  email,
  none,
}

class SocialSignIn {
  final RestClient _restClient = GetIt.instance<RestClient>();
  var userProvider;

  SocialSignIn(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  Future<void> kakaoTalkSignInProcess() async {
    // 카카오 실행 가능 여부 확인
    final bool result = await isKakaoTalkInstalled();
    if (result) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공 ${token.accessToken}');
        userProvider.signInState = SignInPlatform.kakao;
      } catch (error) {
        // 사용자가 카카오톡 설치 후 디바이스 권한 요청에서 로그인을 취소한 경우(의도적인 취소)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }

        // 카카오톡에 연결된 카카오 계정이 없는 경우, 카카오 계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
        } catch (error) {
          debugPrint('Kakao PlatformException');
        }
      }
    } else {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공 ${token.accessToken}');
        userProvider.signInState = SignInPlatform.kakao;
        _postAccountInfo();

        // todo: 회원정보 가져오기
      } catch (error) {
        print('[KakaoTalk is not installed] If you want KakaoTalk Login, please install KakaoTalk');
      }
    }
  }

  Future<void> naverSignInProcess() async {
    final NaverLoginResult result = await FlutterNaverLogin.logIn();

    if (result.status == NaverLoginStatus.loggedIn) {
      print(result.accessToken);
      print(result.account.name);
      _postAccountInfo();

      userProvider.signInState = SignInPlatform.naver;
    } else {
      debugPrint('네이버 로그인 에러');
    }
  }

  Future<void> signOut(SignInPlatform signInPlatform) async {
    switch (signInPlatform) {
      case SignInPlatform.kakao:
        await UserApi.instance.logout();
        break;
      case SignInPlatform.naver:
        await FlutterNaverLogin.logOut();
        break;
      case SignInPlatform.email:
        break;
      case SignInPlatform.none:
        break;
    }
    userProvider.signInState = SignInPlatform.none;
  }

  Future<void> _postAccountInfo() async {
    try {
      final oauthModel = OAuthModel(
        authorization: "authorization",
        providerType: "providerType",
        rolesType: "rolesType",
        state: "state",
      );

      await _restClient.oauthLogin(oauthModel.toJson());
    } catch (error) {
      debugPrint(ErrorHandler.handle(error).failure);
    }
  }
}
