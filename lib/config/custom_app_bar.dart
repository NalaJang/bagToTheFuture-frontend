import 'package:flutter/material.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/design/svg_icon.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: SvgIcon.arrowLeft(color: AppColors.black),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: Text(
        title,
        style: FontStyles.Title3.copyWith(color: AppColors.black),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
