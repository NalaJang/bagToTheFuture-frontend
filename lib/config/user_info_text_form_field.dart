import 'package:flutter/material.dart';
import 'package:rest_api_ex/config/palette.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';

class UserInfoTextFormField extends StatelessWidget {
  const UserInfoTextFormField({
    super.key,
    this.autoFocus,
    this.isButtonEnabled,
    this.textInputType,
    required this.controller,
    required this.validator,
    required this.decorationLabelText,
  });

  final bool? autoFocus;
  final bool? isButtonEnabled;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final String? Function(String?) validator;
  final String decorationLabelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus ?? false,
      keyboardType: textInputType,
      controller: controller,
      validator: validator,
      decoration: _setTextFormDecoration(decorationLabelText),
    );
  }

  InputDecoration _setTextFormDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: FontStyles.Body2.copyWith(color: AppColors.gray4),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,

      // 이메일 인증 요청에서만 필요한 부분
      suffixIcon: isButtonEnabled != null && isButtonEnabled == true
          ? const Icon(
              Icons.check,
              color: Palette.primaryColor,
            )
          : null,
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.main,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.main,
        ),
      ),
    );
  }
}
