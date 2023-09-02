import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/models/login_model.dart';
import 'package:storeapp/service/helper_service.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);

  bool showPassword = true;
  IconData icona = Icons.visibility_outlined;
  ShopLoginModel? model;
  void changeIcona() {
    showPassword = !showPassword;
    showPassword
        ? const Icon(Icons.visibility_outlined)
        : const Icon(Icons.visibility_off_outlined);
    emit(RegisterChangeIcon());
  }

  void userRegister(
      {required String name,
      required String phone,
      required String email,
      required dynamic password}) {
    emit(RegisterLoading());
    DioHelper.postData(
      url: "register",
      data: {
        "name": name,
        "phone": phone,
        "email": email,
        "password": password,
      },
    ).then((value) {
      model = ShopLoginModel.fromjson(value.data);
      // print(value.data.toString());
      emit(RegisterSuccess(model!));
    }).catchError((error) {
      emit(RegisterError(error));
    });
  }
}
