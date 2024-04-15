import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/common/sized_box_values.dart';

class StoreInfoWidget extends StatelessWidget {
  const StoreInfoWidget({required this.selectedStoreIndex, super.key});

  final int selectedStoreIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 가게 정보
        storeInfo(selectedStoreIndex),

        const SizedBox(height: 20),

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
  Widget storeInfo(int selectedStoreIndex) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          // 가게명
          const Text(
            '참바른빵',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 5),
          // 리뷰
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.star_fill,
                size: 20,
                color: Colors.yellow.shade700,
              ),
              const Text('4.8(21) 리뷰 16개 >'),
            ],
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
                size: 20,
                color: Colors.grey.shade400,
              ),
              SizedBoxValues.gapW5,
              const Text('픽업 가능',
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold)),
              SizedBoxValues.gapW5,
              const Text('오후 8:00 ~ 오후 8:30')
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
              const Text('서울특별시 종로구 명륜3가\n성균관로 1길 6-6, 1층'),
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
