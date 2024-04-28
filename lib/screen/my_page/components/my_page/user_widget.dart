import 'package:flutter/material.dart';
import 'package:rest_api_ex/config/common/sized_box_values.dart';
import 'package:rest_api_ex/config/navigate_to.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/design/svg_icon.dart';
import 'package:rest_api_ex/screen/my_page/edit_my_profile_screen.dart';
import 'package:rest_api_ex/screen/my_page/order_list_screen.dart';
import 'package:rest_api_ex/screen/my_page/review_list_screen.dart';
import 'package:rest_api_ex/screen/my_page/setting_screen.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.shade200,
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 1),
        ),
        const BoxShadow(
          color: Colors.white,
          offset: Offset(-1, 0),
        ),
        const BoxShadow(
          color: Colors.white,
          offset: Offset(1, 0),
        )
      ]),
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 60),
            // 사용자 프로필
            userProfile(context),

            const SizedBox(height: 30),
            // 사용자 메뉴 리스트(주문 내역, 리뷰 관리, 나의 찜)
            privateMenuList(context)
          ],
        ),
      ),
    );
  }

  // 사용자 프로필
  Widget userProfile(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 프로필 사진
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.green1,
            borderRadius: BorderRadius.circular(50),
          ),
        ),

        SizedBoxValues.gapH10,

        // 이름
        GestureDetector(
          onTap: () => navigateTo(context, const EditMyProfileScreen()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '김창영 님',
                style: FontStyles.Title3,
              ),
              SvgIcon.arrowRight(width: 16, height: 16, color: AppColors.gray4)
            ],
          ),
        ),
      ],
    );
  }

  // 사용자 메뉴 리스트(주문 내역, 리뷰 관리, 나의 찜)
  Widget privateMenuList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => navigateTo(context, const OrderListScreen()),
            child: SizedBox(
              width: 70,
              child: Column(
                children: [
                  SvgIcon.order(width: 30, height: 30),
                  SizedBoxValues.gapH10,
                  const Text('주문 내역', style: FontStyles.Body2),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => navigateTo(context, const ReviewListScreen()),
            child: SizedBox(
              width: 70,
              child: Column(
                children: [
                  SvgIcon.comment(width: 30, height: 30),
                  SizedBoxValues.gapH10,
                  const Text('리뷰 관리', style: FontStyles.Body2),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => navigateTo(context, const SettingScreen()),
            child: SizedBox(
              width: 70,
              child: Column(
                children: [
                  SvgIcon.setting(width: 30, height: 30),
                  SizedBoxValues.gapH10,
                  const Text('설정', style: FontStyles.Body2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
