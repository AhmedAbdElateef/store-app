import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/screens/home/home_screen.dart';
import 'constans.dart';
import 'screens/auth/shop_login_screen/login.dart';
import 'screens/home/cubit/main_cubit.dart';
import 'screens/on_bording/bording_screen.dart';
import 'service/helper_shared_pref.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CachHelper.init();
  Widget widget;
  dynamic onBoarding = CachHelper.getData(key: "onBoarding");
  // print(onBoarding);
  token = CachHelper.getData(key: "saveToken");

// ignore: unnecessary_null_comparison
  if (onBoarding != null) {
// ignore: unnecessary_null_comparison
    if (token != null) {
      widget = const HomeScreen();
    } else {
      widget = ShopLogin();
    }
  } else {
    widget = const OnBordingScreen();
  }
  runApp(ShopApp(startWidget: widget));
}

// ignore: must_be_immutable
class ShopApp extends StatelessWidget {
  ShopApp({super.key, this.startWidget});

  Widget? startWidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()
        ..getHomeData()
        ..getCategorisData()
        ..getFavoritesData()
        ..getUserdata()..getDarkMode(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
