import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:rest_api_ex/config/common/sized_box_values.dart';
import 'package:rest_api_ex/config/custom_app_bar.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/design/svg_icon.dart';

class RefundInfoScreen extends StatefulWidget {
  const RefundInfoScreen({super.key});

  @override
  State<RefundInfoScreen> createState() => _RefundInfoScreenState();
}

class _RefundInfoScreenState extends State<RefundInfoScreen> {
  final List<String> items = ['한국은행', '산업은행', '기업은행', '국민은행', '하나은행'];
  String? selectedItem;
  String? bankName;

  @override
  Widget build(BuildContext context) {
    // final bankName = TextEditingController(text: '신한은행');
    final accountHolder = TextEditingController(text: '남정광');
    final account = TextEditingController(text: '3020735977861');

    return Scaffold(
      appBar: const CustomAppBar(title: '환불 정보'),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(27, 10, 27, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBoxValues.gapH18,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '은행명',
                  style: FontStyles.Body2.copyWith(color: AppColors.black),
                ),
                SizedBoxValues.gapH7,
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.main),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        '은행명',
                        style: FontStyles.Body2.copyWith(color: AppColors.gray4),
                      ),
                      items: items
                          .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            item,
                            style: FontStyles.Body2.copyWith(color: AppColors.black),
                          ),
                        ),
                      ))
                          .toList(),
                      value: selectedItem,
                      onChanged: (String? value) {
                        setState(() {
                          selectedItem = value;
                          bankName = value;
                        });
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.only(right: 12),
                      ),
                      dropdownStyleData: const DropdownStyleData(
                        // padding: EdgeInsets.only(left: 0, bottom: 0),
                        offset: Offset(0, 0),
                        // width: 200,
                      ),
                      iconStyleData: IconStyleData(
                        icon: SvgIcon.arrowDown(
                          width: 16,
                          height: 16,
                          color: AppColors.main,
                        ),
                        openMenuIcon: SvgIcon.arrowUp(
                          width: 16,
                          height: 16,
                          color: AppColors.main,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
