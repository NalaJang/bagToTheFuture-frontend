import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/screen/home/components/store_info/menu_widget.dart';

import 'components/store_info/surprise_bag_widget.dart';
import 'components/store_info/order_button_widget.dart';
import 'components/store_info/store_info_widget.dart';

class StoreInfoScreen extends StatelessWidget {
  const StoreInfoScreen({required this.selectedStoreIndex, super.key});

  final int selectedStoreIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // 예약 버튼
        bottomNavigationBar: const OrderButtonWidget(),
        body: CustomScrollView(
          slivers: [
            // appBar 배경 이미지
            appBarWidget(context),

            SliverToBoxAdapter(
              child: Column(children: [
                // 가게 정보
                StoreInfoWidget(selectedStoreIndex: selectedStoreIndex),

                // 메뉴 정보
                const SurpriseBagWidget(),

                menuTitle(),

                Wrap(
                  children: <Widget>[
                    ...['1', '2', '3'].map((element) => MenuWidget(
                          menuName: element,
                        ))
                  ],
                ),
              ]),
            ),
          ],
        ));
  }

  Row menuTitle() {
    return const Row(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
          child: Text(
            '개별 메뉴',
            style: FontStyles.Body2,
          ),
        ),
      ],
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
