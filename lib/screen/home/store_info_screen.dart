import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/store/food_list_widget.dart';
import 'components/store/order_button.dart';
import 'components/store/store_info_widget.dart';

class StoreInfoScreen extends StatelessWidget {
  const StoreInfoScreen({required this.selectedStoreIndex, super.key});

  final int selectedStoreIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // 예약 버튼
      bottomNavigationBar: const OrderButton(),

      body: CustomScrollView(
        slivers: [
          // appBar 배경 이미지
          appBarWidget(context),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: [

                  // 가게 정보
                  StoreInfoWidget(selectedStoreIndex: selectedStoreIndex),

                  // 메뉴 정보
                  const FoodListWidget(),
                ],
              ),
            ),
          )
        ],
      )
    );
  }

  // appBar 배경 이미지
  Widget appBarWidget(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.15,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          'assets/images/sample.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
