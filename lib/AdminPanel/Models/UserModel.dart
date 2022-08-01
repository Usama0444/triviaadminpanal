class UserModel {
  String uid;
  String username;
  String email;
  String fullname;
  int points;
  int worldrank;
  int socialrank;
  String password;
  String phonono;
  String image;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.fullname,
    required this.image,
    required this.password,
    required this.phonono,
    required this.points,
    required this.worldrank,
    required this.socialrank,
  });

  factory UserModel.fromJson(json) {
    return UserModel(
      uid: json['uid'],
      username: json['username'],
      email: json['email'],
      fullname: json['fullname'],
      points: json['points'],
      worldrank: json['worldrank'],
      socialrank: json['socialrank'],
      password: json['password'],
      phonono: json['phonono'],
      image: json['image'],
    );
  }
}
