part of 'register_cubit.dart';


abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterChangeIcon extends RegisterState {}
class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final ShopLoginModel loginModel;
  RegisterSuccess(this.loginModel);
}

class RegisterError extends RegisterState {
  final String error;
  RegisterError(this.error);
}

