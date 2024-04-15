import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_ex/config/common/sized_box_values.dart';
import 'package:rest_api_ex/screen/home/store_info_view_model.dart';

class MenuWidget extends StatefulWidget {
  final String menuName;
  const MenuWidget({super.key, required this.menuName});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  int quantity = 0;
  int salePercent = ((14900 - 5900) / 14900 * 100).toInt();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 350,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: Column(
          children: [
            Column(
              children: [
                itemImage(),

                SizedBoxValues.gapH10,
                // 상품 남은 수량, 픽업까지 남은 시간, 가격, 수량 변경 버튼
                Column(
                  children: [
                    // 상품 남은 수량, 픽업까지 남은 시간, 가격
                    itemInfo(),

                    const SizedBox(height: 10),
                    // 아이템 수량 변경 버튼
                    setItemQuantity(context)
                  ],
                ),
              ],
            )
          ],
        ),
      ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.menuName),
        Row(children: [
          Text(
            '$salePercent%',
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
          SizedBoxValues.gapW5,
          const Text(
            "14,900원",
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ]),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '5,900',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const Text('원'),
            SizedBoxValues.gapW5,
            Container(
                decoration: BoxDecoration(color: Colors.purple.shade100),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                  child: Text(
                    '2개 남음',
                    style: TextStyle(fontSize: 10, color: Colors.purple),
                  ),
                )),
          ],
        ),
        SizedBoxValues.gapH5,
        Text(
          '주문 마감까지 2시간 13분',
          style: TextStyle(fontSize: 10, color: Colors.green.shade700),
        ),
      ],
    );
  }

  // 아이템 수량 변경 버튼
  Widget setItemQuantity(BuildContext context) {
    final storeInfoViewModel = Provider.of<StoreInfoViewModel>(context);

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 빼기
            GestureDetector(
                onTap: () {
                  setState(() {
                    if (quantity > 0) {
                      quantity--;
                      storeInfoViewModel.minusTotalPrice(5900);
                    }
                  });
                },
                child: Icon(
                  CupertinoIcons.minus,
                  color: quantity == 0 ? Colors.grey : Colors.black,
                )),

            // 현재 수량
            Text(
              '$quantity개',
              style: TextStyle(
                color: quantity == 0 ? Colors.grey : Colors.black,
              ),
            ),

            // 더하기
            GestureDetector(
                onTap: () {
                  setState(() {
                    if (quantity < 10) {
                      quantity++;
                      storeInfoViewModel.addTotalPrice(5900);
                    }
                  });
                },
                child: Icon(
                  CupertinoIcons.plus,
                  color: quantity == 0 ? Colors.grey : Colors.black,
                )),
          ],
        ),
      ),
    );
  }
}
