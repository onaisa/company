import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:company/UI/component/conts.dart';

import 'package:company/models/usermodel.dart';
import 'package:company/sevices/dio_helper.dart';
import 'package:company/util/local_cred.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  UserModel userModel;
  StorageUtil storageUtil = StorageUtil.getInstance();

  void userLogin({@required String email, @required String password}) async {
    emit(LoginLoudingState());
    DioHelper.postData(
      url: 'employee/signin',
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      if (!value.toString().startsWith("{")) throw Exception('${value}');
      {
        emit(LoginErorrState(
            value.toString().substring(value.toString().indexOf(":") + 1)));
      }

      userModel = UserModel.fromJson(value.data);
      print("user model ${userModel.toString()}");

      userId = userModel.id;

      // StorageUtil.getInstance().storeAuth();
      SharedPreferences.getInstance().then((value) {
        value.setString("initRoute", '/profile');
        // value.setString("userName", userModel.name);
        // value.setString("userEmail", userModel.email);
        // value.setString("userPhone", userModel.number);
        // value.setString("userPassword", userModel.name);
        value.setInt("userId", userModel.id);
        // value.setBool("useradministration", userModel.administration);
        // value.setString("specialty", userModel.specialty);
      });

      emit(LoginSucessState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErorrState(
          error.toString().substring(error.toString().indexOf(":") + 1)));
    });
  }
}
