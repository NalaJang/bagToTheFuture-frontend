import 'package:flutter/material.dart';

import '../../order_screen.dart';

class OrderButton extends StatelessWidget {
  const OrderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(
          color: Color(0xffe8e8e8),
        )),
        boxShadow: [
          BoxShadow(
            color: Color(0xffe8e8e8),
            spreadRadius: 10,
            blurRadius: 5,
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),

        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            )
          ),

          // 예약 페이지로 이동
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => const OrderScreen()
              ));
          },

          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('예약하기'),
          )
        ),
      ),
    );
  }
}
