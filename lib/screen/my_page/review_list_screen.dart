import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rest_api_ex/config/common/sized_box_values.dart';
import 'package:rest_api_ex/config/custom_app_bar.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/design/svg_icon.dart';

class ReviewListScreen extends StatefulWidget {
  const ReviewListScreen({super.key});

  @override
  State<ReviewListScreen> createState() => _ReviewListScreenState();
}

class _ReviewListScreenState extends State<ReviewListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: '리뷰 관리',
      ),
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
                padding: const EdgeInsets.fromLTRB(18, 13, 23, 19),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('참바른빵', style: FontStyles.Body1),
                    const SizedBox(height: 3),
                    _reviewHeader(index + 1),
                    const SizedBox(height: 13),
                    _itemImage(),
                    const SizedBox(height: 18),
                    _userComment(),
                    const SizedBox(height: 27),
                    _managerComment()
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              SizedBoxValues.gapH15,
          itemCount: 4),
    );
  }

  // 리뷰 헤더
  Row _reviewHeader(int rateScore) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _starRate(rateScore),
            const SizedBox(width: 8),
            const Text('1일 전', style: TextStyle(color: AppColors.gray5)),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                SvgIcon.edit(
                  width: 12,
                  height: 12,
                  color: AppColors.gray5,
                ),
                Text('수정',
                    style:
                        FontStyles.Caption3.copyWith(color: AppColors.gray5)),
              ],
            ),
            const SizedBox(width: 18),
            Row(
              children: [
                SvgIcon.trash(
                  width: 12,
                  height: 12,
                  color: AppColors.gray5,
                ),
                Text('삭제',
                    style:
                        FontStyles.Caption3.copyWith(color: AppColors.gray5)),
              ],
            )
          ],
        )
      ],
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
                      height: 14,
                      color:
                          i <= rateScore ? AppColors.yellow : AppColors.gray4)
                  : SvgIcon.reviewRightStar(
                      height: 14,
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
      padding: const EdgeInsets.only(left: 34, right: 21),
      child: Image.asset(
        'assets/images/img.png',
      ),
    );
  }

  // 유저 리뷰
  Widget _userComment() {
    return const Padding(
      padding: EdgeInsets.only(left: 34, right: 21),
      child: Text('합리적인 가격에 환경까지 지킬 수 있다니, 완전 꿩먹고 알먹고네요 ^^',
          style: FontStyles.Body4),
    );
  }

  // 사장님 답급
  Widget _managerComment() {
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 1),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.gray4,
            width: 1,
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(14),
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
