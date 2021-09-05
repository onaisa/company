class SchedualModel {
  int id;
  String enterTime;
  String exitTime;
  String dayDate;
  Null employee;

  SchedualModel(
      {this.id, this.enterTime, this.exitTime, this.dayDate, this.employee});

  SchedualModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enterTime = json['enter_time'];
    exitTime = json['exit_time'];
    dayDate = json['day_date'];
    employee = json['employee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['enter_time'] = this.enterTime;
    data['exit_time'] = this.exitTime;
    data['day_date'] = this.dayDate;
    data['employee'] = this.employee;
    return data;
  }
}
