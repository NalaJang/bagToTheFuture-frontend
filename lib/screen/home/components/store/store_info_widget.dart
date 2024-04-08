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

        // 찜, 길찾기, 공유 버튼
        placeMenus(),
      ],
    );
  }

  // 가게 정보
  Widget storeInfo(int selectedStoreIndex) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: [

          // 가게명
          Text(
            '참바른빵($selectedStoreIndex)',
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
            ),
          ),

          // 리뷰
          Text('97%(21) 리뷰 16개 >'),

          Divider(color: Colors.grey,),

          // 픽업 가능 시간
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.clock),
              SizedBoxValues.gapW5,
              Text('픽업 가능'),
              SizedBoxValues.gapW5,
              Text('오후 8:00 ~ 오후 8:30')
            ],
          ),

          // 가게 주소
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.location_solid),
              SizedBoxValues.gapW5,
              Text('서울특별시 종로구 명륜3가\n성균관로 1길 6-6, 1층'),
            ],
          ),
        ],
      ),
    );
  }


  // 찜, 길찾기, 공유 메뉴 버튼들
  Widget placeMenus() {
    return const Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(CupertinoIcons.heart),
              Text('75'),
            ],
          ),

          Text('|'),

          Row(
            children: [
              Icon(CupertinoIcons.arrow_swap),
              Text('길찾기'),
            ],
          ),

          Text('|'),

          Row(
            children: [
              Icon(CupertinoIcons.share),
              Text('공유'),
            ],
          ),
        ],
      ),
    );
  }
}
