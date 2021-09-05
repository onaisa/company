class EmployeeModel {
  int id;
  String name;
  String password;
  String email;
  String img;
  String number;
  int offDays;
  bool administration;

  String specialty;

  EmployeeModel({
    this.id,
    this.name,
    this.password,
    this.email,
    this.img,
    this.number,
    this.offDays,
    this.administration,
    this.specialty,
  });

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    password = json['password'];
    email = json['email'];
    img = json['img'];
    number = json['number'];
    offDays = json['off_days'];
    administration = json['administration'];

    specialty = json['specialty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['password'] = this.password;
    data['email'] = this.email;
    data['img'] = this.img;
    data['number'] = this.number;
    data['off_days'] = this.offDays;
    data['administration'] = this.administration;

    data['specialty'] = this.specialty;
  }
}



// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);



// List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

// String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class UserModel {
//     UserModel({
//         this.userId,
//         this.id,
//         this.title,
//         this.body,
//     });

//     int userId;
//     int id;
//     String title;
//     String body;

//     factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//         userId: json["userId"],
//         id: json["id"],
//         title: json["title"],
//         body: json["body"],
//     );

//     Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "id": id,
//         "title": title,
//         "body": body,
//     };
// }
