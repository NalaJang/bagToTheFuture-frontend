import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyRecentOrderList extends StatelessWidget {
  const MyRecentOrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0, bottom: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '최근 주문',
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),

          // 주문한 가게 정보, 상품 정보, '주문 상세' 버튼
          myRecentOrder(context),

          // '리뷰 쓰기' 버튼
          reviewButton()
        ],
      ),
    );
  }

  // 주문한 가게 정보, 상품 정보, '주문 상세' 버튼
  Widget myRecentOrder(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.0, bottom: 10.0),
      child: Row(
        children: [

          // 가게 이미지
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/images/sample2.png',
              ),
            ),
          ),

          // 주문한 가게 정보
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 가게 이름
                  Text(
                    '참바른빵',
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  // 주문 날짜 및 수령 정보
                  Row(
                    children: [
                      Text('2024. 02. 21(수)'),
                      Text(' * '),
                      Text('수령 완료'),
                    ],
                  ),

                  // 주문한 상품 내역
                  Text('서프라이즈 백 Large 1개 5900원'),
                ],
              ),
            ),
          ),

          // '주문 상세' 버튼
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
            child: Column(
              children: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: ElevatedButton(
                      onPressed: (){},
                      child: const Text(
                        '주문 상세',
                        style: TextStyle(fontSize: 20),
                      )
                  ),
                ),

                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // '리뷰 쓰기' 버튼
  Widget reviewButton() {
    return ElevatedButton(
        onPressed: (){},
        child: Text(
            '리뷰 쓰기'
        )
    );
  }
}
