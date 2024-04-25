import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rest_api_ex/design/font_styles.dart';

import '../../design/color_styles.dart';
import 'components/home/textfield_widget.dart';

class SearchingScreen extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  SearchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            SizedBox(height: 35),
            Padding(padding: EdgeInsets.symmetric(
              horizontal: 13,
            ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        controller: controller,
                        hintText: '검색어를 입력해주세요.',
                        textInputAction: TextInputAction.search,
                        isReadOnly: false,
                      ),
                    ),
                    SizedBox(width: 23),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Text(
                        '취소',
                        style: FontStyles.Caption1.copyWith(color: AppColors.black),
                      ),
                    )
                  ],
                )
            )
          ],
        )
    );
  }
}