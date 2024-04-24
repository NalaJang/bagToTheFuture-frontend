import 'package:daum_postcode_search/data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_ex/screen/home/daum_postcode_screen.dart';
import 'package:rest_api_ex/screen/home/home_viewmodel.dart';
import 'package:rest_api_ex/screen/home/set_location_map_screen.dart';

import '../../../design/color_styles.dart';
import '../../../design/font_styles.dart';
import '../../../design/svg_icon.dart';

class SetLocationScreen extends StatefulWidget {
  const SetLocationScreen({Key? key}) : super(key:key);

  @override
  _SetLocationScreenState createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {
  DataModel? _dataModel;
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: SvgIcon.arrowLeft(color: AppColors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
            '위치 설정',
            style: FontStyles.Title3.copyWith(color: AppColors.black)
        ),
        centerTitle: true,
      ),
      body: Container(
        color: AppColors.white,
        child: Column(
          children: [
            SizedBox(height: 39,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 27),
              child: AddLocationBtn(
                  '위치 추가하기',
                      (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SetLocationMapScreen(),
                        )
                    );
                  }
              ),
            ),
            SizedBox(height: 36,),
            Expanded(
                child: ListView.builder(
                    itemCount: viewModel.items.length,
                    itemBuilder: (context, index) {
                      var items = viewModel.items[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: LocationList(
                            items.title,
                            items.description,
                                () => viewModel.removeItem(index)
                        ),
                      );
                    },
                )
            ),
          ],
        ),
      ),
    );
  }
}

Widget AddLocationBtn(String text, final void Function()? onTap) {
  return SizedBox(
    width: double.infinity,
    child: OutlinedButton(
      onPressed: onTap,
      child: Text(
          text,
          style: FontStyles.Body2.copyWith(color: AppColors.main)
      ),
      style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))
          ),
          side: BorderSide(
              color: AppColors.main,
              width: 1
          ),
          padding: EdgeInsets.symmetric(vertical: 14.5)
      ),
    ),
  );
}

Widget LocationList(
    String title,
    String detail,
    final void Function()? removeAction
    ) {
  return Container(
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Row(
            children: [
              IconButton(
                icon: SvgIcon.locationPin(width: 24, height: 24, color: AppColors.main),
                onPressed: (){},
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: FontStyles.Body1.copyWith(color: AppColors.black),
                  ),
                  //SizedBox(height: 6,),
                  Text(
                    detail,
                    style: FontStyles.Caption2.copyWith(color: AppColors.gray6),
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                  onPressed: removeAction,
                  icon: SvgIcon.delete(width: 11, height: 11, color: AppColors.gray4))
            ],
          ),
        ),
        SizedBox(height: 16,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Container(
            width: double.infinity,
            height: 1,
            color: AppColors.gray2,
          ),
        )
      ],
    ),
  );
}