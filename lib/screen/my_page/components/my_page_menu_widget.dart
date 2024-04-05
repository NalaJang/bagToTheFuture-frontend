import 'package:flutter/material.dart';

import '../../../config/common/sized_box_values.dart';
import '../../../config/my_text.dart';

class MyPageMenuWidget extends StatelessWidget {
  const MyPageMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {

    List<String> menuList = ['공지사항', '약관 및 정책', '고객센터'];
    List<IconData> menuIcons = [
      Icons.notifications_none,
      Icons.info_outline_rounded,
      Icons.question_mark_outlined
    ];

    return Column(
      children: [
        for( int i = 0; i < menuList.length; i++ )
          InkWell(
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Icon(menuIcons[i]),
                  SizedBoxValues.gapW10,
                  Text(
                    menuList[i],
                    style: MyText.fontSize17,
                  )
                ],
              ),
            ),
          )
      ],
    );
  }
}
