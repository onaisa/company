class UserModel {
  int id;
  String name;
  String password;
  String email;
  String img;
  String number;
  int offDays;
  bool administration;
  String birthday;
  String specialty;
  // List tasks;
  // List scheduals;

  UserModel({
    this.id,
    this.name,
    this.password,
    this.email,
    this.img,
    this.number,
    this.offDays,
    this.administration,
    this.birthday,
    this.specialty,
    // this.tasks,
    // this.scheduals
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    password = json['password'];
    email = json['email'];
    img = json['img'];
    number = json['number'];
    offDays = json['off_days'];
    administration = json['administration'];
    birthday = json['birthday'];
    specialty = json['specialty'];
    //   if (json['tasks'] != null) {

    //     json['tasks'].forEach((v) {
    //       tasks.add(new Null.fromJson(v));
    //     });
    //   }

    //     json['scheduals'].forEach((v) {
    //       scheduals.add(new Null.fromJson(v));
    //     });
    //   }
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
    data['birthday'] = this.birthday;
    data['specialty'] = this.specialty;
    //   if (this.tasks != null) {
    //     data['tasks'] = this.tasks.map((v) => v.toJson()).toList();
    //   }
    //   if (this.scheduals != null) {
    //     data['scheduals'] = this.scheduals.map((v) => v.toJson()).toList();
    //   }
    //   return data;
  }
}
