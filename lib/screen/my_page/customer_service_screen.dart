import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rest_api_ex/config/constants.dart';
import 'package:rest_api_ex/config/custom_app_bar.dart';
import 'package:rest_api_ex/data/model/qna_model.dart';
import 'package:rest_api_ex/data/source/qna_data.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/design/svg_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerServiceScreen extends StatelessWidget {
  final List<QNAModel> qnaList = QNAData.qnaData;

  const CustomerServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Constants.customerService,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              '자주 묻는 질문',
              style: FontStyles.Body1.copyWith(
                color: AppColors.black,
              ),
            ),
          ),
          Divider(),
          _qnaList(),
          _qnaChannel(),
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
                        style:
                            FontStyles.Body7.copyWith(color: AppColors.black),
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

  Widget _qnaChannel() {
    return ListTile(
      leading: SvgIcon.headPhone(color: AppColors.black),
      title: Text('기타 문의사항이 있으신가요?', style: FontStyles.Caption2,),
      subtitle: Text('백투더퓨처 상담 채널 연결', style: FontStyles.Body1,),
      trailing: IconButton(
        icon: const Icon(CupertinoIcons.forward, color: AppColors.gray4,),
        onPressed: _toKakaoChannel,
      ),
      contentPadding: EdgeInsets.only(left: 8.0, right: 8.0),

    );
  }

  Future<void> _toKakaoChannel() async {
    final Uri url = Uri.parse(dotenv.env['KAKAO_CHANNEL_URL']!);

    if (!await launchUrl(url)) {
      debugPrint('Could not launch $url');
    }
  }

}
