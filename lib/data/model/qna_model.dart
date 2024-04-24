class QNAModel {
  final String question;
  final String answer;
  bool isExpanded;

  QNAModel({
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });
}
