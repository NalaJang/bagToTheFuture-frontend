import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_ex/config/common/sized_box_values.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/design/svg_icon.dart';
import 'package:rest_api_ex/screen/home/components/store_info/menu_widget.dart';
import 'package:rest_api_ex/screen/view_model/store_info_view_model.dart';

import 'components/store_info/surprise_bag_widget.dart';
import 'components/store_info/order_button_widget.dart';
import 'components/store_info/store_info_widget.dart';

class StoreInfoScreen extends StatefulWidget {
  const StoreInfoScreen({super.key});

  @override
  State<StoreInfoScreen> createState() => _StoreInfoScreenState();
}

class _StoreInfoScreenState extends State<StoreInfoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final storeInfoViewModel = Provider.of<StoreInfoViewModel>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (storeInfoViewModel.isDialogOpen) {
        _dialogBuilder(context).then((_) => storeInfoViewModel.closeDialog());
      }
    });

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
              const StoreInfoWidget(),

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
      ),
    );
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

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          surfaceTintColor: Colors.white,
          content: SizedBox(
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.gray5,
                    ),
                  )
                ]),
                SvgIcon.logo(width: 80, height: 80),
                SizedBoxValues.gapH10,
                Text(
                  '에약이 접수되었어요!',
                  style: FontStyles.Title5.copyWith(color: AppColors.black),
                ),
                SizedBoxValues.gapH20,
                Stack(children: [
                  const Text('농협 302-0735-9778-61 (김창영)'),
                  Positioned.fill(
                    child: Container(
                        decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide()))),
                  )
                ]),
                SizedBoxValues.gapH5,
                const Text(
                  '으로 0시 0분까지 00000원을 입금해주세요.',
                  style: TextStyle(color: AppColors.gray6),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
