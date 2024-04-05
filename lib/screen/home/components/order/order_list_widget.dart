import 'package:flutter/material.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        // 상품 이미지
        _itemImage(context),

        // 상품 정보
        _itemInfo()
      ],
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
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('서프라이즈 백 Medium'),
            Text('1개')
          ],
        ),

        Row(
          children: [
            Text(
              '3,900',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ),
            ),
            Text('원'),
          ],
        )
      ],
    );
  }
}
