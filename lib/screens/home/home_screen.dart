import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/screens/home/cubit/main_cubit.dart';
import 'package:storeapp/screens/home_screens/search.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        return Scaffold(
          backgroundColor: cubit.changeTheme ? Colors.black : Colors.white,
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  Search(),
                        ));
                  },
                  icon: const Icon(
                    Icons.search_outlined,
                    color: Colors.blue,
                  ))
            ],
            title: const Text(
              "YumYum Store",
              style: TextStyle(color: Colors.blue , fontSize: 20),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          bottomNavigationBar: BottomNavigationBar(
              onTap: (value) {
                cubit.changeIcon(value);
              },
              currentIndex: cubit.index,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              backgroundColor: cubit.changeTheme ? Colors.black : Colors.white,
              elevation: 0,
              items:  [
                BottomNavigationBarItem(
                  icon:const Icon(Icons.home_outlined),
                  label: "Home",
                  backgroundColor:  cubit.changeTheme ? Colors.black : Colors.white,
                ),
                BottomNavigationBarItem(
                  icon:const Icon(Icons.apps_outlined),
                  label: "Category",
                   backgroundColor:  cubit.changeTheme ? Colors.black : Colors.white,
                ),
                BottomNavigationBarItem(
                  icon:const Icon(Icons.favorite_outline),
                  label: "Favorite",
                   backgroundColor:  cubit.changeTheme ? Colors.black : Colors.white,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.settings),
                  label: "Setting",
                  backgroundColor:  cubit.changeTheme ? Colors.black : Colors.white,
                ),
              ]),
          body: cubit.screens[cubit.index],
        );
      },
    );
  }
}
