import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rest_api_ex/config/common/sized_box_values.dart';

import 'components/order/order_list_widget.dart';
import 'components/order/pay_button.dart';
import 'components/order/pick_up_time_info.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('예약하기'),
      ),

      // 결제 버튼
      bottomNavigationBar: const PayButton(),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // 픽업 시간 정보
            const PickUpTimeInfo(),
            Container(
              height: 1.5,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 1,
                )
              ]),
            ),

            // 예약 시 유의사항
            reservationNotice(),

            Container(
              height: 1.5,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 1,
                )
              ]),
            ),

            // 결제할 상품 목록
            const OrderList()
          ],
        ),
      ),
    );
  }

  // 예약 시 유의사항
  Widget reservationNotice() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '예약 시 유의사항',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBoxValues.gapH20,
          RichText(
            text: const TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 13),
              children: <TextSpan>[
                TextSpan(
                    text: '1. 예약 접수 후 20분 내',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: '로 미입금 시 예약이 자동 취소됩니다.'),
              ],
            ),
          ),
          SizedBoxValues.gapH5,
          RichText(
            text: const TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 13, height: 1.5),
              children: <TextSpan>[
                TextSpan(
                    text: '2. ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: '당일 매장 재고상황에 따라 '),
                TextSpan(
                    text: '픽업 가능 시간 1시간 전까지 예약 확정',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: ' 여부가 결정됩니다. 또한 매장별'),
                TextSpan(
                    text: ' 픽업 가능 시간 1시간 전까지 예약 취소',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: '가 가능합니다. (영업일 기준 1~2일 내로 환불)'),
              ],
            ),
          ),
          SizedBoxValues.gapH5,
          RichText(
            text: const TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 13, height: 1.5),
              children: <TextSpan>[
                TextSpan(
                    text: '3. 픽업 희망 시간 5분 후까지 픽업',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: '이 이뤄지지 않을 시 환불이 불가합니다.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
