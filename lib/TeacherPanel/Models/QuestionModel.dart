class QuestionModel {
  String question;
  List<dynamic> choiceList = [];
  String qid;
  int answer;
  String article;

  QuestionModel({
    required this.question,
    required this.choiceList,
    required this.qid,
    required this.answer,
    required this.article,
  });

  factory QuestionModel.fromJson(json) {
    return QuestionModel(
      question: json['question'],
      choiceList: json['choices'],
      qid: json['qid'],
      answer: json['answer'],
      article: json['article'],
    );
  }
}
