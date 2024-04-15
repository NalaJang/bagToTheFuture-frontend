import 'package:flutter/material.dart';
import 'package:rest_api_ex/data/model/qna_model.dart';
import 'package:rest_api_ex/data/source/qna_data.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';

class CustomerServiceScreen extends StatelessWidget {
  final List<QNAModel> qnaList = QNAData.qnaData;

  const CustomerServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('고객센터'),
      ),
      body: Column(
        children: [
          Text(
            '자주 묻는 질문',
            style: FontStyles.Body1.copyWith(
              color: AppColors.black,
            ),
          ),
          _qnaList(),
        ],
      ),
    );
  }

  Widget _qnaList() {
    return ExpansionPanelList.radio(
      children: qnaList
          .map(
            (qna) => ExpansionPanelRadio(
              canTapOnHeader: true,
              value: qna,
              headerBuilder: (context, isExpanded) => Row(
                children: [
                  Text(
                    'Q',
                    style: FontStyles.Body1.copyWith(
                      color: AppColors.main,
                    ),
                  ),
                  Text(
                    qna.question,
                    style: FontStyles.Body7.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              body: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'A',
                    style: FontStyles.Body1.copyWith(
                      color: AppColors.gray5,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      qna.answer,
                      // overflow: TextOverflow.clip,
                      // maxLines: 3,
                      style: FontStyles.Body7.copyWith(color: AppColors.black),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
