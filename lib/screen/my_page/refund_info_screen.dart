import 'package:flutter/material.dart';
import 'package:rest_api_ex/config/common/sized_box_values.dart';
import 'package:rest_api_ex/config/custom_app_bar.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';

class RefundInfoScreen extends StatelessWidget {
  const RefundInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bankName = TextEditingController(text: '신한은행');
    final accountHolder = TextEditingController(text: '남정광');
    final account = TextEditingController(text: '3020735977861');

    return Scaffold(
      appBar: const CustomAppBar(title: '환불 정보'),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(27, 10, 27, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _textField(formName: '은행명', controller: bankName),
            SizedBoxValues.gapH18,
            _textField(formName: '예금주명', controller: accountHolder),
            SizedBoxValues.gapH18,
            _textField(formName: '계좌번호', controller: account),
            Padding(
              padding: const EdgeInsets.only(top: 28),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                  backgroundColor: AppColors.main,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  '수정하기',
                  style: FontStyles.Body2.copyWith(color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textField({
    required String formName,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formName,
          style: FontStyles.Body2.copyWith(color: AppColors.black),
        ),
        SizedBoxValues.gapH7,
        TextFormField(
          controller: controller,
          style: FontStyles.Body2.copyWith(color: AppColors.black),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10, 12, 10, 12),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.main),
            ),
          ),
        ),
      ],
    );
  }
}
