import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:storeapp/constans.dart';
import 'package:storeapp/screens/auth/shop_login_screen/cubit/login_cubit.dart';
import 'package:storeapp/screens/auth/shop_register_screen/register.dart';
import 'package:storeapp/screens/home/home_screen.dart';
import 'package:storeapp/service/helper_shared_pref.dart';
import 'package:storeapp/widgets/coustom_bottom.dart';
import 'package:storeapp/widgets/coustom_text_form.dart';
import 'package:storeapp/widgets/coustom_toast.dart';

// ignore: must_be_immutable
class ShopLogin extends StatelessWidget {
  ShopLogin({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            if (state.loginModel.status!) {
              // print(state.loginModel.message);
              // print(state.loginModel.data!.token);
              CachHelper.saveData(
                      key: "saveToken", value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
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
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 120,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            height: 250,
                            width: 250,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "images/logo.jpg"))),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CoustomTextForm(
                            validator: (data) {
                              if (data!.isEmpty) {
                                return "Please Enter your Email Address";
                              } else {
                                return null;
                              }
                            },
                            prefIcon: Icons.email_outlined,
                            prefIconColor: Colors.blue,
                            controller: emailController,
                            passwordText: false,
                            label: "Email",
                            text: TextInputType.emailAddress,
                            museTextColor: Colors.white,
                            borderColor: Colors.blue,
                            borderReduse: 30,
                            labelColor: Colors.blue,
                            userTextColor: Colors.blue),
                        const SizedBox(
                          height: 20,
                        ),
                        CoustomTextForm(
                            validator: (data) {
                              if (data!.isEmpty) {
                                return "Password is too Short";
                              } else {
                                return null;
                              }
                            },
                            suffixIcone: IconButton(
                              onPressed: () {
                                cubit.changeIcona();
                              },
                              icon: cubit.showPassword
                                  ? const Icon(Icons.visibility_outlined)
                                  : const Icon(Icons.visibility_off_outlined),
                            ),
                            suffixIconeColor: Colors.blue,
                            prefIconColor: Colors.blue,
                            prefIcon: Icons.lock_outline,
                            controller: passwordController,
                            passwordText: cubit.showPassword,
                            label: "Password",
                            text: TextInputType.visiblePassword,
                            museTextColor: Colors.blue,
                            borderColor: Colors.blue,
                            borderReduse: 30,
                            labelColor: Colors.blue,
                            userTextColor: Colors.blue),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLogin,
                          builder: (context) => coustomBottom(
                              textColor: Colors.blue,
                              bgColor: Colors.grey.shade300,
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.usersLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: "LOGIN"),
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
                              "Don`t Have Account ?",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterScreen(),
                                    ));
                              },
                              child: const Text(
                                "Register Now",
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
