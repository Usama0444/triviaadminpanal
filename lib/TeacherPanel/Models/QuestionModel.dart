class QuestionModel {
  String question;
  List<dynamic> choiceList = [];
  String qid;
  int answer;

  QuestionModel({
    required this.question,
    required this.choiceList,
    required this.qid,
    required this.answer,
  });

  factory QuestionModel.fromJson(json) {
    return QuestionModel(
      question: json['question'],
      choiceList: json['choices'],
      qid: json['qid'],
      answer: json['answer'],
    );
  }
}
