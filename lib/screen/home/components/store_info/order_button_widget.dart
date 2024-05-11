import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/screen/home/order_screen.dart';
import 'package:rest_api_ex/screen/view_model/store_info_view_model.dart';
import 'package:rest_api_ex/utils/number_util.dart';

class OrderButtonWidget extends StatelessWidget {
  const OrderButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final storeInfoViewModel = Provider.of<StoreInfoViewModel>(context);
    String? totalPrice = addCommasToNumber(storeInfoViewModel.totalPrice);

    return Container(
      decoration: const BoxDecoration(
          color: AppColors.white,
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
                foregroundColor: AppColors.white,
                backgroundColor: AppColors.main,
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
                  ? const Text('예약하기', style: FontStyles.Body1)
                  : Text(
                      '$totalPrice원 예약하기',
                      style: FontStyles.Body1,
                    ),
            )),
      ),
    );
  }
}
