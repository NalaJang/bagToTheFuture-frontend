import 'package:flutter/material.dart';
import 'package:rest_api_ex/config/common/sized_box_values.dart';
import 'package:rest_api_ex/data/model/store_card_info_model.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/design/svg_icon.dart';

class StoreCardWidget extends StatelessWidget {
  final StoreCardInfoModel storeCardInfoModel;

  const StoreCardWidget({
    super.key,
    required this.storeCardInfoModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 카드뷰 상단 이미지
        _images(context),

        // 카드뷰 하단 가게 정보(이름, 리뷰 수, 픽업 시간 등)
        _info(),
      ],
    );
  }

  // 카드뷰 상단 이미지
  Widget _images(BuildContext context) {
    return Row(
      children: [
        // 왼쪽
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.width * 0.25,
            // padding: const EdgeInsets.only(right: 4),
            child: Image.asset(
              storeCardInfoModel.image1,
              fit: BoxFit.cover,
            ),
          ),
        ),

        SizedBoxValues.gapW4,

        // 오른쪽
        Expanded(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(4),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.12,
                  child: Image.asset(
                    storeCardInfoModel.image2,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBoxValues.gapH4,
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(4),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.12,
                  child: Image.asset(
                    storeCardInfoModel.image3,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 카드뷰 하단 가게 정보(이름, 리뷰 수, 픽업 시간 등)
  Widget _info() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 가게 이름, 잔여 수량
              Row(
                children: [
                  Text(
                    storeCardInfoModel.name,
                    style: FontStyles.Price1.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    color: AppColors.lightPurple,
                    padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                    child: Row(
                      children: [
                        SvgIcon.purpleBag(color: AppColors.purple),
                        SizedBoxValues.gapW3,
                        Text(
                          '${storeCardInfoModel.stock}개 남음',
                          textAlign: TextAlign.center,
                          style: FontStyles.Caption5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBoxValues.gapW4,

              // 리뷰 수, 픽업 시간, 거리 시간
              Row(
                children: [
                  Row(
                    children: [
                      SvgIcon.tagStar(
                        width: 12,
                        height: 12,
                        color: AppColors.yellow,
                      ),
                      Text(
                        ' ${storeCardInfoModel.averageStars} (${storeCardInfoModel.reviews})',
                        style: FontStyles.Caption5.copyWith(
                            color: AppColors.gray6),
                      ),
                    ],
                  ),
                  SizedBoxValues.gapW11,
                  Text(
                    '픽업 ${storeCardInfoModel.pickUpTime}',
                    style: FontStyles.Caption5.copyWith(color: AppColors.gray6),
                  ),
                  Text(
                    ' • ',
                    style: FontStyles.Caption5.copyWith(color: AppColors.gray6),
                  ),
                  Text(
                    storeCardInfoModel.distance,
                    style: FontStyles.Caption5.copyWith(color: AppColors.gray6),
                  ),
                ],
              )
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    storeCardInfoModel.discount,
                    style: FontStyles.Body8.copyWith(color: AppColors.red),
                  ),
                  const SizedBox(width: 1),
                  Text(
                    storeCardInfoModel.originalPrice,
                    style: FontStyles.Price3.copyWith(
                      color: AppColors.gray4,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: AppColors.gray4,
                    ),
                  ),
                ],
              ),
              Text(
                '${storeCardInfoModel.salePrice}원~',
                style: FontStyles.Title5.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
