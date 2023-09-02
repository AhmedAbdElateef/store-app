import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:storeapp/constans.dart';
import 'package:storeapp/screens/home/cubit/main_cubit.dart';
import 'package:storeapp/screens/home_screens/profile_screen.dart';
import 'package:storeapp/service/helper_shared_pref.dart';
import 'package:storeapp/widgets/coustom_bottom.dart';
import 'package:storeapp/widgets/coustom_text_form.dart';
import 'package:storeapp/widgets/coustom_toast.dart';

// ignore: must_be_immutable
class UpdateProfileScrssn extends StatelessWidget {
  UpdateProfileScrssn({super.key});
  var name = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state is SuccessUpdateData) {
          if (state.model.status!) {
            // print(state.loginModel.message);
            // print(state.loginModel.data!.token);
            CachHelper.saveData(
                    key: "saveToken", value: state.model.data!.token)
                .then((value) {
              token = state.model.data!.token;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScrssn()),
                  (route) => false);
            });
          } else {
            // print(state.loginModel.message);
            coustomToast(
                message: state.model.message!,
                bgColor: Colors.red,
                textColor: Colors.white,
                lengthMessage: Toast.LENGTH_LONG,
                whereMessage: ToastGravity.BOTTOM);
          }
        }
       
      },
      builder: (context, state) {
         MainCubit cubit = MainCubit.get(context);
        var model = MainCubit.get(context).userdata!;
        return Scaffold(
          backgroundColor: cubit.changeTheme ? Colors.black : Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              " Update Profile",
              style: TextStyle(color: Colors.blue, fontSize: 30),
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.blue,
                )),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state is LoadingUpdateData)
                       const LinearProgressIndicator(
                        color: Colors.blue,
                       )
                     ,
                      const SizedBox(
                        height: 20,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 55,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(model.data!.image!),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CoustomTextForm(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Pleasce Enter your New name";
                          }
                          return null;
                        },
                        textStyle: 20,
                        controller: name,
                        prefIcon: Icons.person,
                        prefIconColor: Colors.blue,
                        passwordText: false,
                        label: "Create New Name",
                        text: TextInputType.text,
                        museTextColor: Colors.blue,
                        borderColor: Colors.blue,
                        borderReduse: 20,
                        labelColor: Colors.blue,
                        userTextColor: Colors.blue,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CoustomTextForm(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Pleasce Enter your New Email";
                          }
                          return null;
                        },
                        textStyle: 20,
                        controller: email,
                        prefIcon: Icons.email_outlined,
                        prefIconColor: Colors.blue,
                        passwordText: false,
                        label: "Create New Email",
                        text: TextInputType.text,
                        museTextColor: Colors.blue,
                        borderColor: Colors.blue,
                        borderReduse: 20,
                        labelColor: Colors.blue,
                        userTextColor: Colors.blue,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CoustomTextForm(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Pleasce Enter your New NumberPhone";
                          }
                          return null;
                        },
                        textStyle: 20,
                        controller: phone,
                        prefIcon: Icons.phone_iphone,
                        prefIconColor: Colors.blue,
                        passwordText: false,
                        label: " Create New Phone",
                        text: TextInputType.phone,
                        museTextColor: Colors.blue,
                        borderColor: Colors.blue,
                        borderReduse: 20,
                        labelColor: Colors.blue,
                        userTextColor: Colors.blue,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CoustomTextForm(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Pleasce Enter your New Password";
                          }
                          return null;
                        },
                        textStyle: 20,
                        controller: password,
                        prefIcon: Icons.lock_outline,
                        prefIconColor: Colors.blue,
                        passwordText: false,
                        label: "Create New Password",
                        text: TextInputType.text,
                        museTextColor: Colors.blue,
                        borderColor: Colors.blue,
                        borderReduse: 20,
                        labelColor: Colors.blue,
                        userTextColor: Colors.blue,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoadingUpdateData,
                        builder: (context) => coustomBottom(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                MainCubit.get(context).updateUserData(
                                    name: name.text,
                                    phone: phone.text,
                                    email: email.text,
                                    password: password.text);
                                name.clear();
                                phone.clear();
                                email.clear();
                                password.clear();
                              }
                            },
                            text: "SAVE UPDATE",
                             textColor: cubit.changeTheme ? Colors.white : Colors.blue,
                bgColor: cubit.changeTheme ? Colors.blue.withOpacity(0.3) : Colors.grey,),
                        fallback: (context) => const Center(
                            child: CircularProgressIndicator(
                          color: Colors.blue,
                        )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
