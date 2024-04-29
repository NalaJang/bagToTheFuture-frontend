import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/design/svg_icon.dart';
import 'package:rest_api_ex/screen/home/searching_screen.dart';
import 'package:rest_api_ex/screen/home/home_viewmodel.dart';
import '../../design/color_styles.dart';
import 'set_location_screen.dart';
import 'components/home/home_category_item.dart';
import 'components/home/store_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

  class _HomeScreenState extends State<HomeScreen> {
    var messageString = "";
    void getMyDeviceToken() async {
      final token = await FirebaseMessaging.instance.getToken();
      print('내 디바이스 토큰: $token');
    }

    @override
    void initState() {
      getMyDeviceToken();
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        RemoteNotification? notification = message.notification;
        if(notification != null) {
          FlutterLocalNotificationsPlugin().show(
              notification.hashCode,
              notification.title,
              notification.body,
              const NotificationDetails(
                  android: AndroidNotificationDetails(
                    'high_importance_channel',
                    'high_importance_notification',
                    importance: Importance.max,)
              )
          );
          setState((){
            messageString = message.notification!.body!;
            print("Foreground 메시지 수신: $messageString");
          });
        }
      });
      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
              backgroundColor: AppColors.white,
              titleSpacing: 0.0,
              title: GestureDetector(
                onTap: () async {
                  Navigator.push(
                      context, MaterialPageRoute(
                    builder: (context) => SetLocationScreen(),
                  )
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: SvgIcon.locationPin(width: 24, height: 24, color: AppColors.main),
                      onPressed: (){},
                    ),
                    //선정한 데이터 기반으로 바뀌어지도록 하기
                    Text(
                      '우리집',
                      style: FontStyles.Title4.copyWith(color: AppColors.black),
                    ),
                    IconButton(
                      icon: SvgIcon.arrowDown_1(width: 11, height: 5, color: AppColors.gray5),
                      onPressed: (){},
                    ),
                  ],
                ),
              )
          ),
          body: Container(
            color: AppColors.white,
            child: Column(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => SearchingScreen())
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColors.gray0,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                              child: Text(
                                '검색어를 입력해주세요',
                                style: FontStyles.Caption1.copyWith(color: AppColors.gray5),
                              ),
                            ),
                            IconButton(
                                onPressed: (){
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => SearchingScreen())
                                  );
                                }
                                , icon: SvgIcon.search(width: 16, height: 16, color: AppColors.black))
                          ],
                        ),
                      ),
                    )
                ),
                SizedBox(height: 13,),
                Container(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: [
                      Container(child: CategoryItem(text: '추천순', icon: SvgIcon.tagHome(width: 14, height: 13, color: AppColors.black))),
                      Container(child: CategoryItem(text: '마감임박순'),),
                      Container(child: CategoryItem(text: '별점높은순', icon: SvgIcon.tagStar(width: 12, height: 12, color: AppColors.yellow))),
                      Container(child: CategoryItem(text: '가격낮은순'))
                    ].map((item) => Container(child: item, margin: EdgeInsets.symmetric(horizontal: 7))).toList(),
                  ),
                ),
                SizedBox(height: 13,),
                Expanded(
                    child: StoreListWidget()
                )
              ],
            ),
          )
      );

    }
  }
