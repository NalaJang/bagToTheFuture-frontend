import 'package:flutter/material.dart';

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

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
          
              // 픽업 시간 정보
              const PickUpTimeInfo(),
          
              Divider(color: Colors.grey),
          
              // 예약 시 유의사항
              reservationNotice(),
          
              Divider(color: Colors.grey,),
          
              // 결제할 상품 목록
              const OrderList()
            ],
          ),
        ),
      ),
    );
  }


  // 예약 시 유의사항
  Widget reservationNotice() {
    return const Padding(
      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('예약 시 유의사항'),
          Text('1. 가게 재고 상황에 따라 예약이 취소될 수 있습니다. 예약 취소시 결제 금액은 100% 환불됩니다.'),
          Text('2. 예약이 확정되면, 희망 픽업시간 내 픽업 부탁드립니다'),
          Text('3. 예약 확정 후 픽업이 이뤄지지 않으면 환불 조치는 불가합니다.')
        ],
      ),
    );
  }
}
