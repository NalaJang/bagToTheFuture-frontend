import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rest_api_ex/data/model/qna_model.dart';
import 'package:rest_api_ex/data/source/qna_data.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:url_launcher/url_launcher.dart';

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
          ListTile(
            title: Text('기타 문의사항이 있으신가요?'),
            subtitle: Text('백투더퓨처 상담 채널 연결'),
            trailing: IconButton(
              icon: Icon(CupertinoIcons.forward),
              onPressed: _toKakaoChannel,
            ),
          )
        ],
      ),
    );
  }

  Future<void> _toKakaoChannel() async {
    final Uri url = Uri.parse(dotenv.env['KAKAO_CHANNEL_URL']!);

    if (!await launchUrl(url)) {
      debugPrint('Could not launch $url');
    }
  }

  Widget _qnaList() {
    return ExpansionPanelList.radio(
      children: qnaList
          .map(
            (qna) => ExpansionPanelRadio(
              canTapOnHeader: true,
              value: qna,
              headerBuilder: (context, isExpanded) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Q ',
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
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'A ',
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
            ),
          )
          .toList(),
    );
  }
}
