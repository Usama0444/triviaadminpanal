class QuestionModel {
  String question;
  List<dynamic> choiceList = [];
  String qid;

  QuestionModel({
    required this.question,
    required this.choiceList,
    required this.qid,
  });

  factory QuestionModel.fromJson(json) {
    return QuestionModel(
      question: json['question'],
      choiceList: json['choices'],
      qid: json['qid'],
    );
  }
}
