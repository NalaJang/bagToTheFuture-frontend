import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rest_api_ex/config/common/sized_box_values.dart';
import 'package:rest_api_ex/config/navigate_to.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/design/svg_icon.dart';
import 'package:rest_api_ex/screen/home/store_review_list.dart';

class StoreInfoWidget extends StatelessWidget {
  const StoreInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 가게 정보
        storeInfo(context),

        const SizedBox(height: 5),

        // 찜, 길찾기, 공유 버튼
        placeMenus(),

        const SizedBox(height: 10),

        Container(
          height: 1.5,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 1,
            )
          ]),
        ),
      ],
    );
  }

  // 가게 정보
  Widget storeInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          // 가게명
          const Text(
            '참바른빵',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          // 리뷰
          GestureDetector(
            onTap: () => navigateTo(context, const StoreReviewList()),
            child: Container(
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgIcon.tagStar(
                      width: 14, height: 14, color: AppColors.yellow),
                  const SizedBox(width: 5),
                  const Text('4.8(21) 리뷰 16개'),
                  const Icon(
                    size: 20,
                    Icons.chevron_right,
                    color: AppColors.gray6,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),

          Divider(
            color: Colors.grey.shade300,
          ),

          const SizedBox(height: 5),
          // 픽업 가능 시간
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.clock,
                size: 16,
                color: Colors.grey.shade400,
              ),
              SizedBoxValues.gapW5,
              const Text('픽업 가능',
                  style: TextStyle(color: Colors.red, fontSize: 13)),
              SizedBoxValues.gapW5,
              const Text(
                '오후 8:00~오후 8:30',
                style: TextStyle(color: AppColors.gray6, fontSize: 13),
              )
            ],
          ),

          const SizedBox(height: 10),
          // 가게 주소
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.location_solid,
                color: Colors.green.shade200,
              ),
              SizedBoxValues.gapW5,
              Text(
                '서울특별시 종로구 명륜3가\n성균관로 1길 6-6, 1층',
                style: FontStyles.Caption2.copyWith(color: AppColors.gray6),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 찜, 길찾기, 공유 메뉴 버튼들
  Widget placeMenus() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(90, 0, 90, 0),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.heart,
                  size: 16,
                ),
                SizedBoxValues.gapW5,
                Text('75'),
              ],
            ),
            VerticalDivider(
              thickness: 1,
              color: Colors.grey.shade300,
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.arrow_swap,
                  size: 16,
                ),
                SizedBoxValues.gapW5,
                Text('길찾기'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
