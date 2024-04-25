import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rest_api_ex/design/color_styles.dart';

import '../../../../design/font_styles.dart';
import '../../../../design/svg_icon.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputAction textInputAction;
  final bool isReadOnly;

  const TextFieldWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.textInputAction,
    required this.isReadOnly
  }): super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 11, horizontal: 12),
          filled: true,
          fillColor: AppColors.gray0,
          hintText: hintText,
          hintStyle: FontStyles.Caption1.copyWith(color: AppColors.gray5),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color:  AppColors.gray0,)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color:  AppColors.gray0,)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color:  AppColors.gray0,)
          ),
          suffixIcon: IconButton(
            icon: SvgIcon.search(width: 16, height: 16, color: AppColors.black),
            onPressed: () {
              //검색동작으로
            },
          )
      ),
      readOnly: isReadOnly,
    );
  }
}