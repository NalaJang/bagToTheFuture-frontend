import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FoodListWidget extends StatefulWidget {
  const FoodListWidget({super.key});

  @override
  State<FoodListWidget> createState() => _FoodListWidgetState();
}

class _FoodListWidgetState extends State<FoodListWidget> {

  bool _isChecked = false;
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [

            // 아이템 체크 박스
            itemCheckBox(),

            Row(
              children: [

                // 상품 이미지
                itemImage(),

                // 상품 남은 수량, 픽업까지 남은 시간, 가격, 수량 변경 버튼
                Expanded(
                  child: Column(
                    children: [

                      // 상품 남은 수량, 픽업까지 남은 시간, 가격
                      itemInfo(),

                      // 아이템 수량 변경 버튼
                      setItemQuantity()
                    ],
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
  }

  // 아이템 체크 박스
  Widget itemCheckBox() {
    return Row(
      children: [

        // 체크 박스
        Checkbox(
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = value!;
            });
          }
        ),


        // 상품명
        GestureDetector(
          onTap: (){
            setState(() {
              _isChecked = !_isChecked;
            });
          },

          child: Text('서프라이즈 백 Large')
        )
      ],
    );
  }


  // 상품 이미지
  Widget itemImage() {
    return Image.asset(
      'assets/images/img.png',
      width: MediaQuery.of(context).size.width * 0.4,
    );
  }


  // 상품 남은 수량, 픽업까지 남은 시간, 가격
  Widget itemInfo() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('남은 수량 2개'),
        Text('픽업 마감까지 2시간 13분'),
        Row(
          children: [
            Text(
              '5,900',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ),
            ),
            Text('원')
          ],
        )
      ],
    );
  }

  // 아이템 수량 변경 버튼
  Widget setItemQuantity() {
    return Container(
      margin: EdgeInsets.only(left: 15.0, right: 15.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5)
      ),

      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            // 빼기
            GestureDetector(
              onTap: (){
                setState(() {
                  if( quantity > 0 ) quantity--;
                });
              },
              child: Icon(CupertinoIcons.minus)
            ),

            // 현재 수량
            Text('$quantity개'),

            // 더하기
            GestureDetector(
              onTap: (){
                setState(() {
                  if( quantity < 10 ) quantity++;
                });
              },
              child: Icon(CupertinoIcons.plus)
            ),
          ],
        ),
      ),
    );
  }
}
