import 'package:flutter/material.dart';
import 'package:rest_api_ex/config/common/sized_box_values.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // 상품 이미지
          _itemImage(context),

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
      width: MediaQuery.of(context).size.width * 0.3,
    );
  }

  // 상품 정보
  Widget _itemInfo() {
    int salePercent = ((14900 - 5900) / 14900 * 100).toInt();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [Text('서프라이즈 백 Medium'), Text('1개')],
        ),
        Row(children: [
          Text(
            '$salePercent%',
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
          SizedBoxValues.gapW5,
          const Text(
            "14,900원",
            style: TextStyle(
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ]),
        const Row(
          children: [
            Text(
              '3,900',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Text('원'),
          ],
        )
      ],
    );
  }
}
