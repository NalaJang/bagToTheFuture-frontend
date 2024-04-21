import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/design/svg_icon.dart';
import 'package:rest_api_ex/design/color_styles.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<StatefulWidget> createState() => _OrderDetailScreen();
}

class _OrderDetailScreen extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: SvgIcon.arrowLeft(color: AppColors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            '주문상세',
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'PretendardSemiBold',
                color: AppColors.black),
          ),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 23, top: 20, right: 23),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('수령이 완료된 주문이에요',
                    style: FontStyles.Body5.copyWith(color: AppColors.main)),
                const SizedBox(
                  width: 9,
                ),
                Text(
                  '참바른빵',
                  style: FontStyles.Title5.copyWith(color: AppColors.black),
                ),
                const SizedBox(height: 7),
                Text(
                  '주문일시: 2024.03.20',
                  style: FontStyles.Body7.copyWith(color: AppColors.gray4),
                ),
                Text(
                  '주문번호: 2024.03.20',
                  style: FontStyles.Body7.copyWith(color: AppColors.gray4),
                ),
                const SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: AppColors.gray2,
                ),
                const SizedBox(height: 29),
                OrderPrice(FontStyles.Price2, '서프라이즈 백 Large 1개', '5900',
                    double.infinity),
                const SizedBox(height: 23),
                OrderPrice(FontStyles.Price1, '총 금액', '9800', double.infinity),
                const SizedBox(height: 36),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: OrderButton('문의하기', () {
                        print('문의하기');
                      }, AppColors.gray2, AppColors.black),
                    ),
                    const SizedBox(width: 19),
                    Expanded(
                      child: OrderButton('문의하기', () {
                        print('문의하기');
                      }, AppColors.gray2, AppColors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 17),
                OrderButton('별점 및 리뷰', () {
                  print('별점 및 리뷰');
                }, AppColors.main, AppColors.main),
              ],
            ),
          ),
        ));
  }
}

//가격위젯 추후 리스트로 확장
Widget OrderPrice(
    TextStyle fontStyle, String title, String price, double width) {
  return SizedBox(
    width: width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: fontStyle.copyWith(color: AppColors.black)),
        Text("$price원", style: fontStyle.copyWith(color: AppColors.black)),
      ],
    ),
  );
}

Widget OrderButton(String text, final void Function()? onTap,
    Color outlineColor, Color textColor) {
  return SizedBox(
    width: double.infinity,
    child: OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          side: BorderSide(color: outlineColor, width: 1),
          padding: const EdgeInsets.symmetric(vertical: 11.5)),
      child: Text(
        text,
        style: TextStyle(
            fontFamily: 'pretendardMedium', fontSize: 12, color: textColor),
      ),
    ),
  );
}
