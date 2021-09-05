part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final UserModel userModel;

  RegisterSuccessState(this.userModel);
}

class RegisterErrorState extends RegisterState {
  final String message;

  RegisterErrorState(this.message);
}
//upload image statses

class UploadImagesuccessFromCameraState extends RegisterState {}

class UploadImageloadingFromCameraState extends RegisterState {}

class UploadImagesuccessFromGalleryState extends RegisterState {}

class UploadImageloadingFromGalleryState extends RegisterState {}

//change password visibility

class ShopChangePasswordVisibilityState extends RegisterState {}

//

class adminCHickState extends RegisterState {}

///
class technicalChooseState extends RegisterState {}
