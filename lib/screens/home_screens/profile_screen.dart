import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/screens/home/cubit/main_cubit.dart';
import 'package:storeapp/screens/home_screens/update_profile.dart';
import 'package:storeapp/widgets/coustom_bottom.dart';

// ignore: must_be_immutable
class ProfileScrssn extends StatelessWidget {
 const ProfileScrssn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        var model = MainCubit.get(context).userdata!;
        return Scaffold(
          backgroundColor: cubit.changeTheme ? Colors.black : Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              "Profile",
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 55,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(model.data!.image!),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Your Name : ${model.data!.name}",
                  style: const TextStyle(fontSize: 23, color: Colors.blue),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Your Email : ${model.data!.email}",
                  style: const TextStyle(fontSize: 23, color: Colors.blue),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Phone Number : ${model.data!.phone}",
                  style: const TextStyle(fontSize: 23, color: Colors.blue),
                ),
                const Divider(
                  color: Colors.blue,
                  endIndent: 50,
                  indent: 50,
                  thickness: 1,
                  height: 100,
                ),
                Text(
                  "Pointes : ${model.data!.points.toString()}",
                  style: const TextStyle(fontSize: 27, color: Colors.blue),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Credit : ${model.data!.credit.toString()}",
                  style: const TextStyle(fontSize: 27, color: Colors.blue),
                ),
                const SizedBox(
                  height: 50,
                ),
                coustomBottom(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfileScrssn(),));
                  },
                  text: "UPDATE PROFILE",
                  textColor: cubit.changeTheme ? Colors.white : Colors.blue,
                bgColor: cubit.changeTheme ? Colors.blue.withOpacity(0.3) : Colors.grey,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
