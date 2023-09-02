import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/models/login_model.dart';
import 'package:storeapp/service/helper_service.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool showPassword = true;
  IconData icona = Icons.visibility_outlined;
  late ShopLoginModel loginModel;

  void changeIcona() {
    showPassword = !showPassword;
    showPassword
        ? const Icon(Icons.visibility_outlined)
        : const Icon(Icons.visibility_off_outlined);
    emit(LoginChangeIcon());
  }

  void usersLogin({required String email, required String password}) {
    emit(LoginLogin());
    DioHelper.postData(
        url: "login",       
        data: {"email": email, "password": password}).then((value) {
      // print(value.data);
      loginModel = ShopLoginModel.fromjson(value.data);
      emit(LoginSuccess(loginModel));
    }).catchError((error) {
      
      // print(error.toString());
      emit(LoginError(error.toString()));
    });
  }
}
