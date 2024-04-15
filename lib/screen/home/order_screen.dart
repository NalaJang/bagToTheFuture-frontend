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
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '예약 시 유의사항',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Wrap(
            direction: Axis.horizontal, // 나열 방향
            alignment: WrapAlignment.start, // 정렬 방식
            children: [
              Text(
                '1. 예약 접수 후 20분 내',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('로 미입금 시 예약이 자동 취소됩니다.'),
            ],
          ),
          SizedBoxValues.gapH10,
          Wrap(
            direction: Axis.horizontal, // 나열 방향
            children: [
              Text('2. 당일 매장 재고상황에 따라 '),
              Text(
                '픽업 가능 시간 1시간 전까지 예약 확정',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text('3. 예약 확정 후 픽업이 이뤄지지 않으면 환불 조치는 불가합니다.')
        ],
      ),
    );
  }
}
