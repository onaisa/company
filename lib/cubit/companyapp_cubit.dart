import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:company/UI/component/conts.dart';
import 'package:company/UI/pages/alluser_screen.dart';
import 'package:company/UI/pages/profil_screen.dart';
import 'package:company/UI/pages/taskes_screen.dart';
import 'package:company/models/EmployeeModel.dart';
import 'package:company/models/schedualmodel.dart';
import 'package:company/models/taskmodel.dart';
import 'package:company/models/usermodel.dart';
import 'package:company/sevices/dio_helper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'companyapp_state.dart';

class CompanyappCubit extends Cubit<CompanyappState> {
  CompanyappCubit() : super(CompanyappInitial());

  static CompanyappCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    ProfileScreen(),
    AllusersScreen(),
    TaskesScreen(),
  ];
  int currentIndex = 0;
  void chaangeBottobNavBar(int index) {
    currentIndex = index;
    emit(ChangebottomNavBarState());
  }

  // StorageUtil storage = StorageUtil.getInstance();

  // void getUserModelFromShared() async {
  //   emit(GetUserModelLoudinFromSharedgState());
  //   try {
  //     SharedPreferences sheared = await SharedPreferences.getInstance();
  //     userModel = jsonDecode(sheared.get('usermodel'));
  //     print('${userModel.email}');
  //     emit(GetUserModelSuccessFromSharedState());
  //   } catch (e) {
  //     emit(GetUserModelErrorFromSharedState());
  //   }
  // }

  List<EmployeeModel> employees = [];

  void getAllEmployee() {
    emit(GetAllEmployeeLoudingState());

    DioHelper.postData(url: 'employee/showAllEmployees', data: {})
        .then((value) {
      employees = [];
      var data = value.data;

      data.forEach((element) {
        employees.add(EmployeeModel.fromJson(element));
      });

      print(employees[0].name);

      emit(GetAllEmployeeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetAllEmployeeErrorState());
    });
  }

  UserModel userModel;

  void getUserProfle() {
    DioHelper.postData(url: "employee/showEmployee", data: {"id": userId})
        .then((value) {
      emit(GetUserProfileLoudingState());
      userModel = UserModel.fromJson(value.data);

      emit(GetUserProfileSuccessState());
    }).catchError((error) {
      emit(GetUserProfileErrorState());
    });
  }

  void updateProfile({
    String email,
    String number,
    String password,
  }) {
    emit(UpdateProfileLoudingState());
    DioHelper.postData(url: 'employee/update', data: {
      "email": email,
      "password": password,
      "number": number,
      "id": userId,
    }).then((value) {
      userModel = UserModel.fromJson(value.data);
      print(userModel.name);
      emit(UpdateProfileSuccessState());
    }).catchError((error) {
      emit(UpdateProfileErrorState());
    });
  }

  List<TaskModel> allTaskes = [];
  void getAllTaskes() {
    emit(GetTaskesLoudingState());

    DioHelper.getData(url: "Tasks/showTasks/$userId").then((value) {
      allTaskes = [];
      var data = value.data;

      data.forEach((element) {
        allTaskes.add(TaskModel.fromJson(element));
      });

      allTaskes.forEach((element) {
        isdone.addAll({element.id: element.done});
      });
      print(isdone.toString());

      print(allTaskes[0].title);

      emit(GetTaskesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetTaskesErrorState());
    });
  }

  TaskModel taskModel;
  void createTask({
    @required String title,
    @required String description,
    @required int id,
  }) {
    emit(CreateTaskLoudingState());
    DioHelper.postData(url: "Tasks/createTask/${id}", data: {
      "title": title,
      "description": description,
      "id": id,
    }).then((value) {
      taskModel = TaskModel.fromJson(value.data);
      print(taskModel.title);
      getAllTaskes();
      emit(CreateTaskSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreateTaskErrorState());
    });
  }

  Map<int, bool> isdone = {};
  void taskesDone({
    @required int id,
  }) {
    emit(DoneTaskLoudingState());
    DioHelper.getData(url: 'Tasks/DoneTask/$id').then((value) {
      if (!value.toString().startsWith("{")) throw Exception('${value}');
      {
        emit(DoneTaskErrorState(
            value.toString().substring(value.toString().indexOf(":") + 1)));
      }
      getAllTaskes();
      emit(DoneTaskSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(DoneTaskErrorState(
          error.toString().substring(error.toString().indexOf(":") + 1)));
    });
  }

  void logout() {
    emit(LogoutLoudingState());
    DioHelper.getData(url: 'employee/logout/$userId').then((value) {
      if (!value.toString().startsWith("{")) throw Exception('${value}');

      {
        emit(LogoutSuccessState(
            value.toString().substring(value.toString().indexOf(":") + 1)));
      }
    }).catchError((error) {
      SharedPreferences.getInstance().then((value) {
        value.remove('userId');
        value.remove('initRoute');
      });
      print(error.toString());
      emit(LogoutSuccessState(
          error.toString().substring(error.toString().indexOf(":") + 1)));
    });
  }

  EmployeeModel employeeModel;

  void getEmployeeProfle({@required int id}) {
    DioHelper.postData(url: "employee/showEmployee", data: {"id": id})
        .then((value) {
      emit(GetEmployeeProfileLoudingState());
      employeeModel = EmployeeModel.fromJson(value.data);

      emit(GetEmployeeProfileSuccessState());
    }).catchError((error) {
      emit(GetEmployeeProfileErrorState());
    });
  }

  List<SchedualModel> listschedual = [];

  SchedualModel schedualModel;
  void showScedual({
    @required int id,
  }) {
    emit(ShowSchedualLoudingState());
    DioHelper.getData(url: "Schedual/showSchedual/$id").then((value) {
      listschedual = [];
      var Data = value.data;
      Data.forEach((element) {
        listschedual.add(SchedualModel.fromJson(element));
        print(listschedual.toString());
        emit(ShowSchedualSuccessState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(ShowSchedualErrorState());
    });
  }
}
