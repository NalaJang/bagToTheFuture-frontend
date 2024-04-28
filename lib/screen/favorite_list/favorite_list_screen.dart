import 'package:flutter/material.dart';
import 'package:rest_api_ex/config/navigate_to.dart';
import 'package:rest_api_ex/data/model/store_card_info_model.dart';
import 'package:rest_api_ex/data/source/store_card_info_data.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/screen/favorite_list/components/store_card_widget.dart';
import 'package:rest_api_ex/screen/home/store_info_screen.dart';

class FavoriteListScreen extends StatelessWidget {
  final List<StoreCardInfoModel> cardInfoList = StoreCardInfoData.cardInfoList;

  const FavoriteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '찜 목록',
          style: FontStyles.Title3,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 29, 0, 21),
                child: Text(
                  '총 ${cardInfoList.length}개',
                  style: FontStyles.Body2.copyWith(color: AppColors.black),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cardInfoList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        // 가게 클릭, 페이지 이동
                        onTap: () => navigateTo(context, const StoreInfoScreen()),

                        child: Card(
                          margin: const EdgeInsets.only(bottom: 20),
                          color: AppColors.white,
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            children: [
                              StoreCardWidget(
                                storeCardInfoModel: StoreCardInfoModel(
                                  name: cardInfoList[index].name,
                                  stock: cardInfoList[index].stock,
                                  averageStars: cardInfoList[index].averageStars,
                                  reviews: cardInfoList[index].reviews,
                                  pickUpTime: cardInfoList[index].pickUpTime,
                                  distance: cardInfoList[index].distance,
                                  discount: cardInfoList[index].discount,
                                  originalPrice: cardInfoList[index].originalPrice,
                                  salePrice: cardInfoList[index].salePrice,
                                  image1: cardInfoList[index].image1,
                                  image2: cardInfoList[index].image2,
                                  image3: cardInfoList[index].image3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
