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

  Future<bool> kakaoTalkSignInProcess() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      if (isInstalled) {
        try {
          await UserApi.instance.loginWithKakaoTalk();
          return true;
        } catch (error) {
          return false;
        }
      } else {
        try {
          await UserApi.instance.loginWithKakaoAccount();
          return true;
        } catch (error) {
          return false;
        }
      }
    } catch (error) {
      return false;
    }
  }

  Future<void> naverSignInProcess() async {
    final NaverLoginResult result = await FlutterNaverLogin.logIn();
    if(result.status == NaverLoginStatus.loggedIn) {
      NaverAccessToken result = await FlutterNaverLogin.currentAccessToken;
      print("내토큰토큰${result.accessToken}");
      //토큰 저장 api 로직
    } else if(result.status == NaverLoginStatus.error) {
      print('네이버 로그인 에러에러에러');
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
