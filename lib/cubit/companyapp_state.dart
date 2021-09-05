part of 'companyapp_cubit.dart';

@immutable
abstract class CompanyappState {}

class CompanyappInitial extends CompanyappState {}

// bottombar
class ChangebottomNavBarState extends CompanyappState {}

// logout
class LogoutLoudingState extends CompanyappState {}

class LogoutSuccessState extends CompanyappState {
  final String message;
  LogoutSuccessState(this.message);
}

class LogoutErrorState extends CompanyappState {
  final String error;
  LogoutErrorState(this.error);
}

// notify
// class GetNotifyLoudingState extends CompanyappState {}

// class GetNotifySuccessState extends CompanyappState {}

// class GetNotifyErrorState extends CompanyappState {}

// get taskes
class GetTaskesLoudingState extends CompanyappState {}

class GetTaskesSuccessState extends CompanyappState {}

class GetTaskesErrorState extends CompanyappState {}

// get all employee
class GetAllEmployeeLoudingState extends CompanyappState {}

class GetAllEmployeeSuccessState extends CompanyappState {}

class GetAllEmployeeErrorState extends CompanyappState {}

//get user profile

class GetUserProfileLoudingState extends CompanyappState {}

class GetUserProfileSuccessState extends CompanyappState {}

class GetUserProfileErrorState extends CompanyappState {}

//update profile

class UpdateProfileLoudingState extends CompanyappState {}

class UpdateProfileSuccessState extends CompanyappState {}

class UpdateProfileErrorState extends CompanyappState {}

//DoneTask

class DoneTaskLoudingState extends CompanyappState {}

class DoneTaskSuccessState extends CompanyappState {}

class DoneTaskErrorState extends CompanyappState {
  final String error;
  DoneTaskErrorState(this.error);
}

//create Task

class CreateTaskLoudingState extends CompanyappState {}

class CreateTaskSuccessState extends CompanyappState {}

class CreateTaskErrorState extends CompanyappState {}

///get user profile

class GetEmployeeProfileLoudingState extends CompanyappState {}

class GetEmployeeProfileSuccessState extends CompanyappState {}

class GetEmployeeProfileErrorState extends CompanyappState {}

/// show scedual

class ShowSchedualLoudingState extends CompanyappState {}

class ShowSchedualSuccessState extends CompanyappState {}

class ShowSchedualErrorState extends CompanyappState {}
