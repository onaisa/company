part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoudingState extends LoginState {}

class LoginSucessState extends LoginState {
  final userModel;

  LoginSucessState(this.userModel);
}

class LoginErorrState extends LoginState {
  String message;
  LoginErorrState(this.message);
}
