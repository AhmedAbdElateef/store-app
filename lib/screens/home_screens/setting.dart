import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/screens/auth/shop_login_screen/login.dart';
import 'package:storeapp/screens/home/cubit/main_cubit.dart';
import 'package:storeapp/screens/home_screens/profile_screen.dart';
import 'package:storeapp/service/helper_shared_pref.dart';
import 'package:storeapp/widgets/coustom_bottom.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    const Icon(
                      Icons.person_2_outlined,
                      size: 50,
                      color: Colors.blue,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const Text(
                      "PROFILE",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfileScrssn(),
                              ));
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blue,
                        ))
                  ],
                ),
              ),
            const  SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                       const Padding(
                          padding:  EdgeInsets.all(7),
                          child:  Text(
                            "Theme Color",
                            style: TextStyle(color: Colors.blue, fontSize: 20),
                          ),
                        ),
                        const Spacer(),
                         cubit.changeTheme ? const Icon(Icons.sunny , color: Colors.amber,):const Icon(Icons.dark_mode , color: Colors.blue,),
                        Switch(
                            value: cubit.changeTheme,
                            onChanged: (val) {
                              cubit.changeThemeColor(val);
                            }),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              coustomBottom(
                textColor: cubit.changeTheme ? Colors.white : Colors.blue,
                bgColor: cubit.changeTheme ? Colors.blue.withOpacity(0.3) : Colors.grey,
                onTap: () {
                  CachHelper.deleteItem(key: "saveToken").then((value) {
                    if (value) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShopLogin(),
                          ),
                          (route) => false);
                    }
                  });
                },
                text: "LogOut",
              ),
            ],
          ),
        );
      },
    );
  }
}
