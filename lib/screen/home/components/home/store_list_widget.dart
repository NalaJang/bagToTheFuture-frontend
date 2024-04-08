import 'package:flutter/material.dart';

import '../../../../config/common/sized_box_values.dart';
import '../../store_info_screen.dart';

class StoreListWidget extends StatelessWidget {
  const StoreListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return GestureDetector(

          // 가게 클릭, 페이지 이동
          onTap: (){
            print('가게 클릭 : $index');
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => StoreInfoScreen(selectedStoreIndex: index,)
            ));
          },

          child: Card(
            margin: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15.0, right: 15.0),
            color: Colors.white,
            elevation: 5.0,
            child: Column(
              children: [
                // 상단 세 장 이미지
                imagesWidget(context),

                // 하단 가게 정보(이름, 리뷰 수, 픽업 시간 등)
                storeInfo()
              ],
            ),
          ),
        );
      }
    );
  }

  // 상단 세 장 이미지
  Widget imagesWidget(BuildContext context) {
    return Row(
      children: [

        // 왼쪽 한 장
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0)),
            child:
            Container(
              color: Colors.grey,
              height: MediaQuery.of(context).size.height * 0.2,
            )
            // Image.asset(
            //   'assets/images/sample.png',
            //   fit: BoxFit.fill,
            //   height: MediaQuery.of(context).size.height * 0.2,
            // ),
          ),
        ),

        SizedBoxValues.gapW5,

        // 오른쪽 위, 아래 두 장
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.35,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(10.0)),
                child:
                Container(
                  color: Colors.grey,
                  height: MediaQuery.of(context).size.height * 0.1,
                )

                // Image.asset(
                //   'assets/images/sample.png',
                //   height: MediaQuery.of(context).size.height * 0.1,
                // ),
              ),

              SizedBoxValues.gapH5,

              Container(
                color: Colors.grey,
                height: MediaQuery.of(context).size.height * 0.1,
              )

              // Image.asset(
              //   'assets/images/sample2.png',
              //   fit: BoxFit.fill,
              //   height: MediaQuery.of(context).size.height * 0.1,
              // ),
            ],
          ),
        )
      ],
    );
  }

  // 하단 가게 정보(이름, 리뷰 수, 픽업 시간 등)
  Widget storeInfo() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 가게 이름
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '참바른빵',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),

            // 리뷰 수, 픽업 시간, 거리 시간
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
              child: Row(
                children: [
                  Text(
                    '97%(21)',
                    style: TextStyle(
                      fontSize: 12.0
                    ),
                  ),

                  SizedBoxValues.gapW15,

                  Text(
                    '픽업 오후 6:00 ~ 10:00',
                    style: TextStyle(
                      fontSize: 12.0
                    )
                  ),

                  SizedBoxValues.gapW15,

                  Text(
                    '도보 8분',
                    style: TextStyle(
                      fontSize: 12.0
                    )
                  ),
                ],
              ),
            )
          ],
        ),

        // 가격
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            '₩3,900',
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold
            )
          ),
        )
      ],
    );
  }
}
