import 'package:flutter/material.dart';
import 'package:rest_api_ex/config/constants.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/design/svg_icon.dart';

class TermsOfUse extends StatelessWidget {
  final bool isCheckedAllTermsOfUse;
  final bool isCheckedNecessaryTermsOfUse1;
  final bool isCheckedNecessaryTermsOfUse2;
  final bool isCheckedNecessaryTermsOfUse3;
  final bool isCheckedNecessaryTermsOfUse4;
  final bool isCheckedMarketing;
  final void Function() onAllTermsOfUsePressed;
  final void Function() onTermsOfUse1Pressed;
  final void Function() onTermsOfUse2Pressed;
  final void Function() onTermsOfUse3Pressed;
  final void Function() onTermsOfUse4Pressed;
  final void Function() onMarketingPressed;

  const TermsOfUse({
    super.key,
    required this.isCheckedAllTermsOfUse,
    required this.isCheckedNecessaryTermsOfUse1,
    required this.isCheckedNecessaryTermsOfUse2,
    required this.isCheckedNecessaryTermsOfUse3,
    required this.isCheckedNecessaryTermsOfUse4,
    required this.isCheckedMarketing,
    required this.onAllTermsOfUsePressed,
    required this.onTermsOfUse1Pressed,
    required this.onTermsOfUse2Pressed,
    required this.onTermsOfUse3Pressed,
    required this.onTermsOfUse4Pressed,
    required this.onMarketingPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                Constants.termsOfUse,
                style: FontStyles.Body2.copyWith(color: AppColors.black),
              ),
              const Text(
                '*',
                style: TextStyle(color: AppColors.red),
              ),
            ],
          ),

          // 모두 동의
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
              padding: const EdgeInsets.only(left: 11),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.main),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('모두 동의'),
                  IconButton(
                    onPressed: () {
                      onAllTermsOfUsePressed();
                    },
                    icon: isCheckedAllTermsOfUse
                        ? SvgIcon.checked()
                        : SvgIcon.unchecked(),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 만 14세 이상 (필수)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('만 14세 이상 (필수)'),
                    IconButton(
                      onPressed: () => onTermsOfUse1Pressed(),
                      icon: isCheckedNecessaryTermsOfUse1
                          ? SvgIcon.checked()
                          : SvgIcon.unchecked(),
                    ),
                  ],
                ),

                // 서비스 이용약관 (필수)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('서비스 이용약관 (필수)'),
                    IconButton(
                      onPressed: () => onTermsOfUse2Pressed(),
                      icon: isCheckedNecessaryTermsOfUse2
                          ? SvgIcon.checked()
                          : SvgIcon.unchecked(),
                    ),
                  ],
                ),

                // 개인정보 수집/이용 동의 (필수)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('개인정보 수집/이용 동의 (필수)'),
                    IconButton(
                      onPressed: () => onTermsOfUse3Pressed(),
                      icon: isCheckedNecessaryTermsOfUse3
                          ? SvgIcon.checked()
                          : SvgIcon.unchecked(),
                    ),
                  ],
                ),

                // 위치기반서비스 이용약관 (필수)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('위치기반서비스 이용약관 (필수)'),
                    IconButton(
                      onPressed: () => onTermsOfUse4Pressed(),
                      icon: isCheckedNecessaryTermsOfUse4
                          ? SvgIcon.checked()
                          : SvgIcon.unchecked(),
                    ),
                  ],
                ),

                // 마케팅 활용 동의 (선택)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('마케팅 활용 동의 (선택)'),
                    IconButton(
                      onPressed: () => onMarketingPressed(),
                      icon: isCheckedMarketing
                          ? SvgIcon.checked()
                          : SvgIcon.unchecked(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
