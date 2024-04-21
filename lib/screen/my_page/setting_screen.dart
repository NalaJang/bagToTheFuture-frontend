import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_ex/config/custom_app_bar.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/screen/view_model/setting_view_model.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    Future.microtask(
      () => context.read<SettingViewModel>().checkNotificationStatus(),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      context.read<SettingViewModel>().checkNotificationStatus();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SettingViewModel>();

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
              _orderAlarmSetting(viewModel, context),
              _marketingAgreementSetting(viewModel),
              _logout(viewModel, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _orderAlarmSetting(SettingViewModel viewModel, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '주문 현황 알림',
          style: FontStyles.Body4.copyWith(color: AppColors.black),
        ),
        GestureDetector(
          onTap: () async {
            viewModel.notificationPermissionChange(context);
          },
          child: viewModel.orderAlarmStatus,
        ),
      ],
    );
  }

  Widget _marketingAgreementSetting(SettingViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '마케팅 목적의 개인정보 활용 동의',
          style: FontStyles.Body4.copyWith(color: AppColors.black),
        ),
        GestureDetector(
          onTap: () {
            viewModel.marketingPermissionChange();
          },
          child: viewModel.marketingAgreementStatus,
        ),
      ],
    );
  }

  Widget _logout(SettingViewModel viewModel, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        viewModel.logout(context);
      },
      child: Text(
        '로그아웃',
        style: FontStyles.Body4.copyWith(color: AppColors.black),
      ),
    );
  }
}
