import 'package:flutter/material.dart';

import '../../../config/common/sized_box_values.dart';
import '../../../config/palette.dart';

class TermOfUse extends StatelessWidget {
  const TermOfUse({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Text('이용약관 동의'),
            Text('*', style: TextStyle(color: Colors.red)),
          ],
        ),

        SizedBoxValues.gapH5,

        // 모두 동의
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: Border.all(color: Palette.primaryColor),
              borderRadius: BorderRadius.circular(4.0)),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('모두 동의'),
              Icon(
                Icons.check,
              ),
            ],
          ),
        ),


        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                // 만 14세 이상 (필수)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('만 14세 이상 (필수)'),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.check,
                        color: Palette.primaryColor,
                      ),
                    )
                  ],
                ),


                // 서비스 이용약관 (필수)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('서비스 이용약관 (필수)'),
                    Icon(Icons.check),
                  ],
                ),

                // 개인정보 수집/이용 동의 (필수)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('개인정보 수집/이용 동의 (필수)'),
                    Icon(Icons.check),
                  ],
                ),


                // 위치기반서비스 이용약관 (필수)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('위치기반서비스 이용약관 (필수)'),
                    Icon(Icons.check),
                  ],
                ),


                // 마케팅 활용 동의 (선택)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('마케팅 활용 동의 (선택)'),
                    Icon(Icons.check),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
