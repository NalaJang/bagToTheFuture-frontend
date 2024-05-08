import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rest_api_ex/config/custom_app_bar.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/design/svg_icon.dart';

class StoreReviewList extends StatelessWidget {
  const StoreReviewList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: '별점 및 리뷰',
      ),
      body: Column(
        children: [
          // 가게 리뷰 헤더
          _header(),

          Expanded(
            child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return _storeReview(index);
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 27),
                itemCount: 4),
          ),
        ],
      ),
    );
  }

  Container _header() {
    return Container(
      decoration: const BoxDecoration(color: AppColors.white),
      child: Padding(
        padding: const EdgeInsets.only(left: 35, top: 25, bottom: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgIcon.tagStar(width: 27, height: 27, color: AppColors.yellow),
                const SizedBox(width: 7),
                const Text(
                  '4.8',
                  style: FontStyles.Title1,
                )
              ],
            ),
            const SizedBox(height: 10),
            Text(
              '리뷰 22개',
              style: FontStyles.Body2.copyWith(color: AppColors.gray6),
            )
          ],
        ),
      ),
    );
  }

  Container _storeReview(int index) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 리뷰한 유저 정보
          _userInfo(index),
          const SizedBox(height: 12),
          // 리뷰 사진
          _itemImage(),
          const SizedBox(height: 18),
          // 유저 리뷰
          _userComment(),
          const SizedBox(height: 18),
          if (index % 2 == 1) ...[
            // 사장님 답글
            _managerComment(
                '단골손님! 오늘도 참바른빵을 믿고 주문주셔서 감사합니다.빵이 생각날 때는 저희 "참바른빵" 꼬옥 기억해주시구, 다음번에도 또 찾아주세요^^'),
            const SizedBox(height: 20)
          ]
        ],
      ),
    );
  }

  Padding _userInfo(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 15),
      child: Row(children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.green1,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('남정광 님', style: FontStyles.Body1),
            Row(
              children: [
                _starRate(index + 1),
                const SizedBox(width: 6),
                Text('1일 전',
                    style:
                        FontStyles.Caption3.copyWith(color: AppColors.gray5)),
              ],
            )
          ],
        )
      ]),
    );
  }

  // 별점
  Row _starRate(int rateScore) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 1; i <= 10; i++) ...[
          Transform.translate(
            offset: i % 2 == 0 ? const Offset(-0.4, 0) : const Offset(0, 0),
            child: Container(
              margin: i % 2 == 0 ? const EdgeInsets.only(right: 1.75) : null,
              child: i % 2 == 1
                  ? SvgIcon.reviewLeftStar(
                      width: 8,
                      height: 8,
                      color:
                          i <= rateScore ? AppColors.yellow : AppColors.gray4)
                  : SvgIcon.reviewRightStar(
                      width: 8,
                      height: 8,
                      color:
                          i <= rateScore ? AppColors.yellow : AppColors.gray4),
            ),
          ),
        ],
      ],
    );
  }

  // 상품 이미지
  Widget _itemImage() {
    return Padding(
      padding: const EdgeInsets.only(left: 48, right: 47),
      child: Image.asset(
        'assets/images/sample2.png',
        fit: BoxFit.fill,
      ),
    );
  }

  // 유저 리뷰
  Widget _userComment() {
    return const Padding(
      padding: EdgeInsets.only(left: 48, right: 47),
      child: Text('합리적인 가격에 환경까지 지킬 수 있다니, 완전 꿩먹고 알먹고네요 ^^',
          style: FontStyles.Body4),
    );
  }

  // 사장님 답글
  Widget _managerComment(String comment) {
    return Padding(
      padding: const EdgeInsets.only(left: 27, right: 27),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.gray4,
            width: 1,
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('사장님', style: FontStyles.Body1),
              SizedBox(height: 8),
              Text(
                  '단골손님! 오늘도 참바른빵을 믿고 주문주셔서 감사합니다.빵이 생각날 때는 저희 "참바른빵" 꼬옥 기억해주시구, 다음번에도 또 찾아주세요^^',
                  style: FontStyles.Body7),
            ],
          ),
        ),
      ),
    );
  }
}
