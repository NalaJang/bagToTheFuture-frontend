import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rest_api_ex/config/custom_app_bar.dart';
import 'package:rest_api_ex/config/navigate_to.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/design/svg_icon.dart';
import 'package:rest_api_ex/screen/sign_in/sign_in_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with WidgetsBindingObserver {
  bool _isEnabledOrderAlarm = true;
  bool _isEnabledMarketingAgreement = true;
  Widget _orderAlarmStatus = SvgIcon.enabledToggle();
  Widget _marketingAgreementStatus = SvgIcon.enabledToggle();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      var status = await Permission.notification.status;

      if (status.isGranted) {
        debugPrint('isGranted');
        _isEnabledOrderAlarm = true;
        _orderAlarmStatus = SvgIcon.enabledToggle();
      } else {
        debugPrint('status.isDenied');
        debugPrint('status.isGranted');
        _isEnabledOrderAlarm = false;
        _orderAlarmStatus = SvgIcon.disabledToggle();
      }

      setState(() {

      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: '설정',
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 14, 17, 75),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _orderAlarmSetting(),
              _marketingAgreementSetting(),
              _logout(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _orderAlarmSetting() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '주문 현황 알림',
          style: FontStyles.Body4.copyWith(color: AppColors.black),
        ),
        GestureDetector(
          onTap: () async {
            _isEnabledOrderAlarm = !_isEnabledOrderAlarm;

            setState(() {
              _orderAlarmStatus = _isEnabledOrderAlarm
                  ? SvgIcon.enabledToggle()
                  : SvgIcon.disabledToggle();
            });
          },
          child: _orderAlarmStatus,
        ),
      ],
    );
  }

  Widget _marketingAgreementSetting() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '마케팅 목적의 개인정보 활용 동의',
          style: FontStyles.Body4.copyWith(color: AppColors.black),
        ),
        GestureDetector(
          onTap: () {
            _isEnabledMarketingAgreement = !_isEnabledMarketingAgreement;

            setState(() {
              _marketingAgreementStatus = _isEnabledMarketingAgreement
                  ? SvgIcon.enabledToggle()
                  : SvgIcon.disabledToggle();
            });
          },
          child: _marketingAgreementStatus,
        ),
      ],
    );
  }

  Widget _logout() {
    // var viewModel = Provider.of<SignInViewModel>(context);

    return GestureDetector(
      onTap: () async {
        navigateTo(context, const SignInScreen());

        // await SocialSignIn(context).signOut(viewModel.signInPlatform);
      },
      child: Text(
        '로그아웃',
        style: FontStyles.Body4.copyWith(color: AppColors.black),
      ),
    );
  }
}
