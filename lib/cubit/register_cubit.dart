import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:company/UI/component/conts.dart';
import 'package:company/models/usermodel.dart';
import 'package:company/sevices/dio_helper.dart';
import 'package:company/util/local_cred.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);
  UserModel userModel;
  StorageUtil storageUtil = StorageUtil.getInstance();

  void userRegister({
    @required String email,
    @required String name,
    @required String number,
    @required String password,
    bool administration,
    String specialty,
  }) async {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: 'employee/register',
      data: {
        "name": name,
        "email": email,
        "password": password,
        "number": number,
        "administration": administration,
        "specialty": specialty
      },
    ).then((value) {
      print(value.data);
      if (!value.toString().startsWith("{")) throw Exception('${value}');

      userModel = UserModel.fromJson(value.data);

      print("user model ${userModel.name}");
      userId = userModel.id;
      SharedPreferences.getInstance().then((value) {
        value.setString("initRoute", '/profile');

        value.setInt("userId", userModel.id);
      });

      emit(RegisterSuccessState(userModel));
    }).catchError((error) {
      emit(RegisterErrorState(
          error.toString().substring(error.toString().indexOf(":") + 1)));
    });
  }

  File image;

  var imagepicker = ImagePicker();
  Future uploadImageCamera() async {
    emit(UploadImageloadingFromCameraState());
    var profileImage = await imagepicker.pickImage(source: ImageSource.camera);
    image = File(profileImage.path);
    emit(UploadImagesuccessFromCameraState());
  }

  Future uploadImageGallery() async {
    emit(UploadImageloadingFromGalleryState());
    var profileImage = await imagepicker.pickImage(source: ImageSource.gallery);
    image = File(profileImage.path);
    emit(UploadImagesuccessFromGalleryState());
  }

  bool secur = false;
  void changePasswordVisibility() {
    secur = !secur;

    emit(ShopChangePasswordVisibilityState());
  }

  bool admin = false;
  bool check;
  void adminCHick(bool value) {
    check = value;
    emit(adminCHickState());
  }

  Object selected;
  void tec_Choose(dynamic value) {
    selected = value;

    emit(technicalChooseState());
  }
}
