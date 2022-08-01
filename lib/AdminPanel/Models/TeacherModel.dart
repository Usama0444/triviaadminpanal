class TeacherModel {
  String email;
  String password;
  String tid;

  TeacherModel({
    required this.email,
    required this.password,
    required this.tid,
  });

  factory TeacherModel.fromJson(json) {
    return TeacherModel(
      email: json['email'],
      password: json['password'],
      tid: json['tid'],
    );
  }
}
