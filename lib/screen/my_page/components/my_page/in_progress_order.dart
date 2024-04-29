import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';

class InProgressOrder extends StatelessWidget {
  const InProgressOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.shade100,
          spreadRadius: 1,
          blurRadius: 5,
        ),
        const BoxShadow(
          color: Colors.white,
          offset: Offset(-2, 0),
        ),
        const BoxShadow(
          color: Colors.white,
          offset: Offset(2, 0),
        )
      ]),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(26, 23, 26, 0),
        child: Column(
          children: [
            SizedBox(
              height: 215,
              child: Column(
                children: [
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '진행 중인 주문',
                          style: FontStyles.Title4,
                        ),
                      ]),
                  Flexible(
                    child: Center(
                      child: Text(
                        '진행 중인 주문이 없습니다',
                        style:
                            FontStyles.Body4.copyWith(color: AppColors.gray5),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
