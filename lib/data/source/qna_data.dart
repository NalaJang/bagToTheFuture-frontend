import 'package:rest_api_ex/data/model/qna_model.dart';

class QNAData {
  static const List<QNAModel> qnaData = [
    QNAModel(
      question: '서프라이즈백',
      answer: '그것은..',
    ),

    QNAModel(
      question: '서프라이즈백?',
      answer: '그것은..',
    ),

    QNAModel(
      question: '서프라이즈백!',
      answer: '서프라이즈 백은 어쩌구저쩌구 솰라솰라 어쩌구저쩌구 솰라솰라어쩌구저쩌구 '
          '솰라솰라어쩌구저쩌구 솰라솰라어쩌구저쩌구 솰라솰라어쩌구저쩌구 솰라솰라어쩌구저쩌구',
    ),
  ];
}
