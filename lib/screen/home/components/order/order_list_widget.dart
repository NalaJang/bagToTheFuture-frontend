import 'package:flutter/material.dart';
import 'package:rest_api_ex/config/common/sized_box_values.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      child: Row(
        children: [
          // 상품 이미지
          _itemImage(context),

          SizedBoxValues.gapW5,
          // 상품 정보
          _itemInfo()
        ],
      ),
    );
  }

  // 상품 이미지
  Widget _itemImage(BuildContext context) {
    return Image.asset(
      'assets/images/img.png',
      width: MediaQuery.of(context).size.width * 0.25,
    );
  }

  // 상품 정보
  Widget _itemInfo() {
    int salePercent = ((14900 - 5900) / 14900 * 100).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              '서프라이즈 백 Medium, 1개',
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
        const SizedBox(height: 3),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(
            '$salePercent%',
            style: FontStyles.Price5.copyWith(
              color: AppColors.red,
            ),
          ),
          SizedBoxValues.gapW5,
          Text(
            "14,900원",
            style: FontStyles.Price6.copyWith(
              color: AppColors.gray5,
              decoration: TextDecoration.lineThrough,
              decorationColor: AppColors.gray5,
            ),
          ),
        ]),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '3,900',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('원'),
          ],
        )
      ],
    );
  }
}
