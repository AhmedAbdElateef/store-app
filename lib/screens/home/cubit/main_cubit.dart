import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/models/add_favorites_model.dart';
import 'package:storeapp/models/categores_model.dart';
import 'package:storeapp/models/get_favorites_model.dart';
import 'package:storeapp/models/login_model.dart';
import 'package:storeapp/models/products_model.dart';
import 'package:storeapp/models/search_model.dart';
import 'package:storeapp/screens/home_screens/catecory.dart';
import 'package:storeapp/screens/home_screens/favorite.dart';
import 'package:storeapp/screens/home_screens/product.dart';
import 'package:storeapp/screens/home_screens/setting.dart';
import 'package:storeapp/service/helper_service.dart';
import '../../../constans.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit get(context) => BlocProvider.of(context);
  HomeData? homeModel;
  CategorisModel? categorisModel;
  Map<int, bool> favorites = {};
  int index = 0;
  late ChangeFavoritesModel changeFavoritesModel;
  GetFavorites? getFavorites;
  List<Widget> screens = [
    const Products(),
    const Category(),
    const Favorite(),
    const Setting(),
  ];
  bool changeTheme = false;

  void changeIcon(val) {
    index = val;
    emit(ChangeBottomNavBar());
  }

  void getHomeData() {
    emit(LoadingHomeData());
    DioHelper.getData(
      url: "home",
      token: token,
    ).then((value) {
      homeModel = HomeData.fromjson(value.data);
      // print(homeModel!.data!.products[0].image);
      // print(homeModel!.status);
      for (var e in homeModel!.data!.products) {
        favorites.addAll({e.id!: e.inFavorites!});
      }

      // print(favorites.toString());
      emit(SuccessHomeData());
    }).catchError((error) {
      // print(error.toString());
      emit(ErrorHomeData());
    });
  }

  void getCategorisData() {
    DioHelper.getData(
      url: "categories",
      token: token,
    ).then((value) {
      categorisModel = CategorisModel.fromjson(value.data);
      // print(categorisModel!.status);
      // print(categorisModel!.data!.dataModel[0].name);
      emit(SuccessCategoresData());
    }).catchError((error) {
      // print(error.toString());
      emit(ErrorCategoreseData());
    });
  }

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(SuccessFavorites());
    DioHelper.postData(
            url: "favorites", data: {"product_id": productId}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromjson(value.data);
      // print(value.data);
      if (changeFavoritesModel.status == false) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoritesData();
      }
      emit(SuccessFavoritesData(changeFavoritesModel));
    }).catchError((error) {
      emit(ErrorFavoritesData());
    });
  }

  void getFavoritesData() {
    emit(LoadingGetFavoritesData());
    DioHelper.getData(url: "favorites", token: token).then((value) {
      getFavorites = GetFavorites.fromjson(value.data);
      // print(value.data.toString());
      emit(SuccessGetFavoritesData());
    }).catchError((error) {
      emit(ErrorGetFavoriteseData());
    });
  }

  ShopLoginModel? userdata;
  void getUserdata() {
    DioHelper.getData(url: "profile", token: token).then((value) {
      userdata = ShopLoginModel.fromjson(value.data);
      // print(value.data.toString());
      emit(SuccessGetUserData());
    }).catchError((error) {
      emit(ErrorGetUserData());
    });
  }

  void updateUserData(
      {required String name,
      required String phone,
      required String email,
      required String password}) {
    emit(LoadingUpdateData());
    DioHelper.updateData(token: token, url: "update-profile", data: {
      "name": name,
      "phone": phone,
      "email": email,
      "password": password,
    }).then((value) {
      userdata = ShopLoginModel.fromjson(value.data);
      emit(SuccessUpdateData(userdata!));
    }).catchError((error) {
      emit(ErrorUpdateData());
    });
  }

  void changeThemeColor(value) {
    changeTheme = value;
    saveDarkMode(value);
    emit(ChangeTheme());
  }

  GetSearch? getSearch;
  void getSearchData(String textSearch) {
    emit(LoadingGetSearchData());
    DioHelper.postData(
      url: "products/search",
      data: {"text": textSearch},
      token: token,
    ).then((value) {
      getSearch = GetSearch.fromjson(value.data);
      emit(SuccessGetSearchData());
    }).catchError((error) {
      // print(error.toString());
      emit(ErrorGetSearchData());
    });
  }

  void saveDarkMode(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', changeTheme);
    // print(prefs.getBool("darkMode"));
  }

  Future<void> getDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    changeTheme = prefs.getBool('darkMode') ?? false;
    emit(ChangeThemeApp());
  }

// ميسود بتقوم بطباعه الداتا من الاى بى اى كامله
  // void printFullText(String text) {
  //   final Pattern = RegExp(".{1,800}");
  //   Pattern.allMatches(text).forEach((match) => print(match.group(0)));
  // }
}
