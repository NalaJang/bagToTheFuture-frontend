import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_ex/screen/home/store_info_view_model.dart';
import 'package:rest_api_ex/utils/number_util.dart';

import '../../order_screen.dart';

class OrderButtonWidget extends StatelessWidget {
  const OrderButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final storeInfoViewModel = Provider.of<StoreInfoViewModel>(context);
    String? totalPrice = addCommasToNumber(storeInfoViewModel.totalPrice);

    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(
            color: Color(0xffe8e8e8),
          )),
          boxShadow: [
            BoxShadow(
              color: Color(0xffe8e8e8),
              spreadRadius: 10,
              blurRadius: 5,
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),

            // 예약 페이지로 이동
            onPressed: () {
              if (totalPrice == null) {
                return;
              }

              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => const OrderScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: totalPrice == null
                  ? const Text('예약하기')
                  : Text('$totalPrice원 예약하기'),
            )),
      ),
    );
  }
}
