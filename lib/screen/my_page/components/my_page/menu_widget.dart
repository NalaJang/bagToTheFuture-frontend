import 'package:flutter/material.dart';
import 'package:rest_api_ex/config/common/sized_box_values.dart';
import 'package:rest_api_ex/config/constants.dart';
import 'package:rest_api_ex/config/navigate_to.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/design/svg_icon.dart';
import 'package:rest_api_ex/screen/my_page/customer_service_screen.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        _myPageMenu(
          context,
          const CustomerServiceScreen(),
          SvgIcon.info(width: 20, height: 20),
          Constants.termsAndPolicies,
        ),
        _myPageMenu(
          context,
          const CustomerServiceScreen(),
          SvgIcon.question(width: 20, height: 20),
          Constants.customerService,
        ),
      ],
    );
  }

  Widget _myPageMenu(
    BuildContext context,
    Widget where,
    Widget icon,
    String appBarTitle,
  ) {
    return InkWell(
      onTap: () => navigateTo(context, where),
      child: SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
          child: Row(
            children: [
              icon,
              SizedBoxValues.gapW10,
              Text(
                appBarTitle,
                style: FontStyles.Body6.copyWith(color: AppColors.gray6),
              )
            ],
          ),
        ),
      ),
    );
  }
}
