import 'package:flutter/cupertino.dart';

import '../../config/social_sign_in.dart';

class UserProvider with ChangeNotifier {
  var signInState = SignInPlatform.none;

  void signInStatus(SignInPlatform signInPlatform) {
    signInState = signInPlatform;
    notifyListeners();
  }
}
