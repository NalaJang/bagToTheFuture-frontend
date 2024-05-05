import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_ex/config/navigate_to.dart';
import 'package:rest_api_ex/config/social_sign_in.dart';
import 'package:rest_api_ex/design/svg_icon.dart';

import 'package:rest_api_ex/screen/sign_in/sign_in_screen.dart';
import 'package:rest_api_ex/screen/my_bottom_navigation.dart';
import 'package:rest_api_ex/screen/sign_up/sign_up_screen.dart';
import 'package:rest_api_ex/screen/view_model/sign_in_view_model.dart';


class SettingViewModel with ChangeNotifier {
  bool _isEnabledOrderAlarm = true;
  bool _isEnabledMarketingAgreement = true;
  Widget _orderAlarmStatus = SvgIcon.enabledToggle();
  Widget _marketingAgreementStatus = SvgIcon.enabledToggle();

  bool get isEnabledOrderAlarm => _isEnabledOrderAlarm;

  bool get isEnabledMarketingAgreement => _isEnabledMarketingAgreement;

  Widget get orderAlarmStatus => _orderAlarmStatus;

  Widget get marketingAgreementStatus => _marketingAgreementStatus;

  void checkNotificationStatus() async {
    var status = await Permission.notification.status;

    if (status.isGranted) {
      _isEnabledOrderAlarm = true;
      _orderAlarmStatus = SvgIcon.enabledToggle();
    } else {
      final response = await Permission.notification.request();
      debugPrint('response: $response');
      _isEnabledOrderAlarm = false;
      _orderAlarmStatus = SvgIcon.disabledToggle();
    }

    notifyListeners();
  }

  void notificationPermissionChange(BuildContext context) async {
    _isEnabledOrderAlarm = !_isEnabledOrderAlarm;
    notifyListeners();

    var result = await _showConfirmDialog(context);

    try {
      if (result) {
        openAppSettings();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void marketingPermissionChange() {
    _isEnabledMarketingAgreement = !_isEnabledMarketingAgreement;

    _marketingAgreementStatus = _isEnabledMarketingAgreement
        ? SvgIcon.enabledToggle()
        : SvgIcon.disabledToggle();

    notifyListeners();
  }

  void logout(BuildContext context) async {
    navigatePushAndRemoveUtilTo(context, const SignUpScreen(userEmail: ""));

    final viewModel = Provider.of<SignInViewModel>(context, listen: false);

    await SocialSignIn(context).signOut(viewModel.signInPlatform);
  }

  Future<bool> _showConfirmDialog(BuildContext context) async {
    bool result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("푸시알림 설정 변경은 '설정 > 알림 > 백투더퓨처 > 알림허용'에서 할 수 있어요."),
            actions: [
              // 취소 버튼
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('아니오'),
              ),

              // Gaps.gapW10,

              // 확인 버튼
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop(true);
                },
                child: Text('설정하러 가기'),
              ),
            ],
          );
        });

    return result;
  }
}
