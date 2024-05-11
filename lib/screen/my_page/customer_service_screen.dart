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

class CustomerServiceScreen extends StatefulWidget {
  const CustomerServiceScreen({super.key});

  @override
  State<CustomerServiceScreen> createState() => _CustomerServiceScreenState();
}

class _CustomerServiceScreenState extends State<CustomerServiceScreen> {
  final List<QNAModel> qnaList = QNAData.qnaData;

  @override
  void dispose() {
    for (int i = 0; i < qnaList.length; i++) {
      qnaList[i].isExpanded = false;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Constants.customerService,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _qnaTitle(),
              const Divider(height: 0,),
              _qnaList(),
              const Divider(height: 0,),
              _qnaChannel(),
              _serviceFeedback(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _qnaTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 0, 16),
      child: Text(
        '자주 묻는 질문',
        style: FontStyles.Body1.copyWith(
          color: AppColors.black,
        ),
      ),
    );
  }

  Widget _qnaList() {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemCount: qnaList.length,
      itemBuilder: (context, index) {
        return Theme(
          data: ThemeData(
            dividerColor: Colors.transparent,
          ),
          child: ExpansionTile(
            trailing: qnaList[index].isExpanded
                ? SvgIcon.arrowUp(color: AppColors.main)
                : SvgIcon.arrowDown(color: AppColors.main),
            onExpansionChanged: (bool expanded) {
              setState(() {
                qnaList[index].isExpanded = expanded;
              });
            },
            tilePadding: const EdgeInsets.fromLTRB(12, 0, 16, 0),
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 9.0),
                  child: Text(
                    'Q',
                    style: FontStyles.Body1.copyWith(
                      color: AppColors.main,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    qnaList[index].question,
                    style: FontStyles.Body7.copyWith(color: AppColors.black, overflow: TextOverflow.clip),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: AppColors.gray0,
                    border: Border(
                        top: BorderSide(
                          width: 2,
                          color: AppColors.gray3,
                        ),
                        bottom: BorderSide(
                          width: 1,
                          color: AppColors.gray3,
                        ),),),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 21, 16, 18),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 9.0),
                            child: Text(
                              'A',
                              style: FontStyles.Body1.copyWith(
                                color: AppColors.gray5,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              qnaList[index].answer,
                              // overflow: TextOverflow.clip,
                              // maxLines: 3,
                              style: FontStyles.Body7.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        height: 0,
        color: AppColors.gray3,
      ),
    );
  }

  Widget _qnaChannel() {
    return InkWell(
      onTap: () => _toKakaoChannel(),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(19, 21, 18, 0),
        leading: SvgIcon.headPhone(color: AppColors.black),
        title: const Text('기타 문의사항이 있으신가요?', style: FontStyles.Caption2),
        subtitle: const Text(
          '백투더퓨처 상담 채널 연결',
          style: FontStyles.Body1,
        ),
        trailing: SvgIcon.arrowRight(color: AppColors.gray4),
      ),
    );
  }

  Widget _serviceFeedback() {
    return InkWell(
      onTap: () => _toKakaoChannel(),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(19, 12, 18, 0),
        leading: SvgIcon.serviceFeedback(color: AppColors.black),
        title: const Text(
          '백투퓨처의 개선점을 보내주세요!',
          style: FontStyles.Caption2,
        ),
        subtitle: const Text(
          '서비스 피드백',
          style: FontStyles.Body1,
        ),
        trailing: SvgIcon.arrowRight(color: AppColors.gray4),
      ),
    );
  }

  Future<void> _toKakaoChannel() async {
    final Uri url = Uri.parse(dotenv.env['KAKAO_CHANNEL_URL']!);

    if (!await launchUrl(url)) {
      debugPrint('Could not launch $url');
    }
  }
}
