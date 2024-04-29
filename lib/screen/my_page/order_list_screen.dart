import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rest_api_ex/config/common/sized_box_values.dart';
import 'package:rest_api_ex/config/custom_app_bar.dart';
import 'package:rest_api_ex/config/navigate_to.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/screen/my_page/order_detail_screen.dart';
import 'package:rest_api_ex/screen/my_page/write_review_screen.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: '주문 내역'),
        body: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 1),
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-1, 0),
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(1, 0),
                  )
                ]),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(17, 38, 17, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 주문한 가게 정보, 상품 정보, '주문 상세' 버튼
                      myRecentOrder(context),
                      const SizedBox(height: 19),

                      // '리뷰 쓰기' 버튼
                      reviewButton(context)
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                SizedBoxValues.gapH15,
            itemCount: 4));
  }

  // 주문한 가게 정보, 상품 정보, '주문 상세' 버튼
  Widget myRecentOrder(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 8),
      child: Row(
        children: [
          // 가게 이미지
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(40), // Image radius
                child:
                    Image.asset('assets/images/sample2.png', fit: BoxFit.cover),
              ),
            ),
          ),

          // 주문한 가게 정보
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 가게 이름
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('참바른빵', style: FontStyles.Title5),
                      // '주문 상세' 버튼
                      GestureDetector(
                        onTap: () =>
                            navigateTo(context, const OrderDetailScreen()),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.gray3),
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.fromLTRB(7, 3, 7, 3),
                              child: const Text(
                                '주문 상세',
                                style: FontStyles.Caption4,
                              )),
                        ),
                      )
                    ],
                  ),

                  // 주문 날짜 및 수령 정보
                  RichText(
                    text: TextSpan(
                      style: FontStyles.Body7.copyWith(color: AppColors.gray4),
                      children: const <TextSpan>[
                        TextSpan(text: '2024. 02. 21(수)'),
                        TextSpan(text: ' · '),
                        TextSpan(text: '수령 완료'),
                      ],
                    ),
                  ),
                  SizedBoxValues.gapH5,
                  // 주문한 상품 내역
                  const Text('서프라이즈 백 Large 1개 5900원', style: FontStyles.Body7),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // '리뷰 쓰기' 버튼
  Widget reviewButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () => navigateTo(context, const WriteReviewScreen()),
      style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.main)),
      child: Text(
        '별점 및 리뷰',
        style: FontStyles.Caption3.copyWith(color: AppColors.main),
      ),
    );
  }
}
