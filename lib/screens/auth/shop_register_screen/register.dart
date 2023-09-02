import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:storeapp/constans.dart';
import 'package:storeapp/screens/auth/shop_login_screen/login.dart';
import 'package:storeapp/screens/auth/shop_register_screen/cubit/register_cubit.dart';
import 'package:storeapp/service/helper_shared_pref.dart';
import 'package:storeapp/widgets/coustom_bottom.dart';
import 'package:storeapp/widgets/coustom_text_form.dart';
import 'package:storeapp/widgets/coustom_toast.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            if (state.loginModel.status!) {
              // print(state.loginModel.message);
              // print(state.loginModel.data!.token);
              CachHelper.saveData(
                      key: "saveToken", value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) =>  ShopLogin()),
                    (route) => false);
              });
            } else {
              // print(state.loginModel.message);
              coustomToast(
                  message: state.loginModel.message!,
                  bgColor: Colors.red,
                  textColor: Colors.white,
                  lengthMessage: Toast.LENGTH_LONG,
                  whereMessage: ToastGravity.BOTTOM);
            }
          }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: formKey,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Center(
                      child: Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("images/logo.jpg"))),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CoustomTextForm(
                      controller: nameController,
                      validator: (data) {
                        if (data!.isEmpty) {
                          return "field your name";
                        }
                        return null;
                      },
                      label: "Your Name",
                      text: TextInputType.text,
                      museTextColor: Colors.blue,
                      borderColor: Colors.blue,
                      borderReduse: 30,
                      labelColor: Colors.blue,
                      userTextColor: Colors.blue,
                      prefIcon: Icons.person,
                      prefIconColor: Colors.blue,
                      passwordText: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CoustomTextForm(
                      controller: phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "field your Number";
                        }
                        return null;
                      },
                      label: "Your Phone Number",
                      text: TextInputType.number,
                      museTextColor: Colors.blue,
                      borderColor: Colors.blue,
                      borderReduse: 30,
                      labelColor: Colors.blue,
                      userTextColor: Colors.blue,
                      prefIcon: Icons.phone_android_outlined,
                      prefIconColor: Colors.blue,
                      passwordText: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CoustomTextForm(
                      controller: emailController,
                      validator: (data) {
                        if (data!.isEmpty) {
                          return "field your Email";
                        }
                        return null;
                      },
                      label: "Email",
                      text: TextInputType.emailAddress,
                      museTextColor: Colors.blue,
                      borderColor: Colors.blue,
                      borderReduse: 30,
                      labelColor: Colors.blue,
                      userTextColor: Colors.blue,
                      prefIcon: Icons.email_outlined,
                      prefIconColor: Colors.blue,
                      passwordText: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CoustomTextForm(
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "field your password";
                        }
                        return null;
                      },
                      passwordText: cubit.showPassword,
                      label: "New Password",
                      text: TextInputType.visiblePassword,
                      museTextColor: Colors.blue,
                      borderColor: Colors.blue,
                      borderReduse: 30,
                      labelColor: Colors.blue,
                      userTextColor: Colors.blue,
                      suffixIcone: IconButton(
                          onPressed: () {
                            cubit.changeIcona();
                          },
                          icon: cubit.showPassword
                              ? const Icon(Icons.visibility_outlined)
                              : const Icon(Icons.visibility_off_outlined)),
                      prefIcon: Icons.lock_outline,
                      prefIconColor: Colors.blue,
                      suffixIconeColor: Colors.blue,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ConditionalBuilder(
                      condition: state is !RegisterLoading,
                      builder: (context) => coustomBottom(
                          textColor: Colors.blue,
                          bgColor: Colors.grey.shade300,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              RegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  );
                            }
                          },
                          text: "REGISTER"),
                      fallback: (context) => const Center(
                          child: CircularProgressIndicator(
                        color: Colors.blue,
                      )),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "You Have Account ?",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
