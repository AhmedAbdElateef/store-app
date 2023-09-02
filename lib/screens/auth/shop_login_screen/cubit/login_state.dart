part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLogin extends LoginState {}

class LoginSuccess extends LoginState {
  final ShopLoginModel loginModel;
  LoginSuccess(this.loginModel);
}

class LoginError extends LoginState {
  final String error;
  LoginError(this.error);
}

class LoginChangeIcon extends LoginState {}
