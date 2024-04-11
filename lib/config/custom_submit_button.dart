import 'package:flutter/material.dart';
import 'package:rest_api_ex/config/navigate_to.dart';
import 'package:rest_api_ex/config/validation_check.dart';
import 'package:rest_api_ex/data/network/error_handler.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/screen/view_model/user_info_view_model.dart';

class CustomSubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String buttonText;
  final Widget nextPage;
  final UserInfoViewModel? viewModel;

  const CustomSubmitButton({
    super.key,
    required this.formKey,
    required this.buttonText,
    required this.nextPage,
    this.viewModel,
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
      onPressed: () {
        ValidationCheck().allUserInputValidation(formKey);

        try {
          viewModel!.submit(password: '12345');

          if (context.mounted) {
            navigateTo(context, nextPage);
          }
        } catch (error) {
          final errorMessage = ErrorHandler.handle(error).failure;

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
              ),
            );
          }
        }
      },
      child: Text(
        buttonText,
        style: FontStyles.Body2.copyWith(color: AppColors.white),
      ),
    );
  }
}
