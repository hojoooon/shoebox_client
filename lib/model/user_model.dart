class UserModel {
  final int userId;
  final String userName;
  final int age;
  final String gender;
  final String email;
  final String id;
  final String password;
  final Object shoesSizes;

  // UserModel({
  //   required this.userId,
  //   required this.userName,
  //   required this.age,
  //   required this.gender,
  //   required this.email,
  //   required this.id,
  //   required this.password,
  //   required this.shoesSizes,
  // });

  UserModel.fromJson({required Map<String, dynamic> json})
      : userId = json["userId"],
        userName = json["userName"],
        age = json["age"],
        gender = json["gender"],
        email = json["email"],
        id = json["id"],
        password = json["password"],
        shoesSizes = json["shoesSizes"];
}
