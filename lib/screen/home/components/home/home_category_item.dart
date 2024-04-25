import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/design/svg_icon.dart';

import '../../../../design/color_styles.dart';

class CategoryItem extends StatelessWidget {
  final String text;
  final Widget? icon;

  const CategoryItem({
    Key? key,
    required this.text,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(vertical: 6),
      child: Container(
        //height: 31,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: AppColors.gray0,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: AppColors.tagBorder, width: 1)
          ),
          child: Row(
            children: [
              Container(
                  padding: EdgeInsets.only(right: 5),
                  child: icon != null ? icon : SizedBox.shrink()
              ),
              Text(
                text,
                style: FontStyles.Caption3.copyWith(color: AppColors.black),
              ),
            ],
          )
      ),
    );
  }
}