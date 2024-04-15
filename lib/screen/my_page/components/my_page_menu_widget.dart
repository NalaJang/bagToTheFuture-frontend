import 'package:flutter/material.dart';
import 'package:rest_api_ex/config/navigate_to.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/screen/my_page/customer_service_screen.dart';

import '../../../config/common/sized_box_values.dart';

class MyPageMenuWidget extends StatelessWidget {
  const MyPageMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _myPageMenu(
          context,
          const CustomerServiceScreen(),
          Icons.info_outline_rounded,
          '약관 및 정책',
        ),

        _myPageMenu(
          context,
          const CustomerServiceScreen(),
          Icons.question_mark_outlined,
          '고객센터',
        ),
      ],
    );
  }

  Widget _myPageMenu(
    BuildContext context,
    Widget where,
    IconData icon,
    String appBarTitle,
  ) {
    return InkWell(
      onTap: () => navigateTo(context, where),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            Icon(icon),
            SizedBoxValues.gapW10,
            Text(
              appBarTitle,
              style: FontStyles.Body6.copyWith(color: AppColors.gray6),
            )
          ],
        ),
      ),
    );
  }
}
