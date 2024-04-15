import 'package:flutter/material.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';

class CustomSubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String buttonText;
  final Widget nextPage;
  final VoidCallback onPressedCallback;

  const CustomSubmitButton({
    super.key,
    required this.formKey,
    required this.buttonText,
    required this.nextPage,
    required this.onPressedCallback,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.main,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      onPressed: onPressedCallback,
      child: Text(
        buttonText,
        style: FontStyles.Body2.copyWith(color: AppColors.white),
      ),
    );
  }
}
