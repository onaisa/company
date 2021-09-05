class TaskModel {
  int id;
  String title;
  String description;
  Null employee;
  bool done;

  TaskModel({this.id, this.title, this.description, this.employee, this.done});

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    employee = json['employee'];
    done = json['done'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['employee'] = this.employee;
    data['done'] = this.done;
    return data;
  }
}
