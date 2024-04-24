import 'package:daum_postcode_search/data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:provider/provider.dart';
import '../../design/color_styles.dart';
import '../../design/font_styles.dart';
import '../../design/svg_icon.dart';
import 'daum_postcode_screen.dart';
import 'home_viewmodel.dart';

class SetLocationMapScreen extends StatefulWidget {
  const SetLocationMapScreen({super.key});
  @override
  State<SetLocationMapScreen> createState() =>
      _SetLocationMapScreen();
}

class _SetLocationMapScreen extends State<SetLocationMapScreen> {
  //TextEditingController textController = TextEditingController();
  DataModel? _dataModel;
  final TextEditingController _controller = TextEditingController();

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
              '위치 추가하기',
              style: FontStyles.Title3.copyWith(color: AppColors.black)
          ),
          centerTitle: true,
        ),
        body: Stack (
          children: [
            NaverMap(
              options: const NaverMapViewOptions(
                indoorEnable: true,
                locationButtonEnable: true
              ),
              onMapReady: (controller) {
                print('네이버맵 로딩');
              },
            ),
            Positioned(
                top: 22,
                left: 14,
                right: 14,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return DaumPostcodeScreen();
                    })).then((value){
                      setState(() {
                        _dataModel = value;
                      });
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.black.withOpacity(0.85),
                              blurRadius: 4,
                              offset: Offset(0,4)
                          )
                        ]
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 0),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: (){

                              },
                              icon: SvgIcon.search(width: 16, height: 16, color: AppColors.black)
                          ),
                          SizedBox(width: 12),
                          Text(
                            '주소를 검색하세요',
                            style: FontStyles.Body2.copyWith(color: AppColors.gray5),
                          )
                        ],
                      ),
                    ),
                  ),
                )
            ),
            if(_dataModel?.address != null && _dataModel?.jibunAddress != null)
              Positioned(
                  bottom: 0,
                  child: AddressBottomSheet(_dataModel!.address, 
                      _dataModel!.jibunAddress,
                      _controller, context,
                      () async => await viewModel.addItem(_dataModel!.address, _controller.text)
                  )
              )
          ],
        )
    );
  }
}

Widget AddressBottomSheet(String address, String detail, TextEditingController controller, BuildContext context, Future<void> Function() onAction) {
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(45),
          topRight: Radius.circular(45),
        )
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 37,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 17),
          child: Text(
            address,
            style: FontStyles.Title3.copyWith(color: AppColors.black),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 17),
          child: Text(
            '[지번] ${detail}',
            style: FontStyles.Caption1.copyWith(color: AppColors.gray5),
          ),
        ),
        SizedBox(height: 19),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 17),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 13 ),
              filled: true,
              fillColor: AppColors.gray0,
              hintText: '별칭을 정해주세요 (ex. 우리집, 최대 5자)',
              hintStyle: FontStyles.Body3.copyWith(color: AppColors.gray5),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color:  AppColors.gray0,)
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color:  AppColors.gray0,)
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color:  AppColors.gray0,)
              ),
            ),
          ),
        ),
        SizedBox(height: 23),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 17, vertical: 23),
          child: TextButton(
            onPressed: () async {
              if(controller.text.isNotEmpty) {
                await onAction();
                Navigator.pop(context);
              } else {

              }
            },
            style: TextButton.styleFrom(
              backgroundColor: controller.text.isEmpty ? AppColors.gray4 : AppColors.main,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4)
                )
              ),
              padding: EdgeInsets.symmetric(vertical: 15),
              minimumSize: const Size.fromHeight(50)
            ),
            child: Text('설정하기',
              style: FontStyles.Body2.copyWith(color: AppColors.white),
            ),
          )

        )
      ],
    ),
  );
}