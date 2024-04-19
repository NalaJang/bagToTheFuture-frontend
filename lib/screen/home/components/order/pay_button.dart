import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_ex/screen/home/store_info_screen.dart';
import 'package:rest_api_ex/screen/view_model/store_info_view_model.dart';
import 'package:rest_api_ex/utils/number_util.dart';

class PayButton extends StatelessWidget {
  const PayButton({super.key});

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

            // 결제 페이지로 이동
            onPressed: () {
              storeInfoViewModel.openDialog();
              Navigator.pop(context, const StoreInfoScreen());
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('$totalPrice원 결제하기'),
            )),
      ),
    );
  }
}
