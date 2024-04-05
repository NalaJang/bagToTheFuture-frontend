
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rest_api_ex/design/svg_icon.dart';
import 'package:rest_api_ex/design/color_styles.dart';

class OrderDetailScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrderDetailScreen();
}

class _OrderDetailScreen extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        leading: IconButton(
          icon: SvgIcon.arrowLeft(color: AppColors.black),
          onPressed: () {
            //이전 화면 돌아가기 로직 추가
          },
        ),
        title: const Text(
          '주문상세',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'PretendardSemiBold',
            color: AppColors.black
          ),
        ),
        centerTitle: true,
      ),
      body: Container(

      )
    );
  }

}
