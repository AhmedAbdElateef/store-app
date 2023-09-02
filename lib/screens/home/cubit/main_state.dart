part of 'main_cubit.dart';

abstract class MainState {}

class MainInitial extends MainState {}

class ChangeBottomNavBar extends MainState {}

class LoadingHomeData extends MainState {}

class SuccessHomeData extends MainState {}

class ErrorHomeData extends MainState {}

class SuccessCategoresData extends MainState {}

class ErrorCategoreseData extends MainState {}

class SuccessFavoritesData extends MainState {
  final ChangeFavoritesModel model;

  SuccessFavoritesData(this.model);
}

class SuccessFavorites extends MainState {}

class ErrorFavoritesData extends MainState {}

class SuccessGetFavoritesData extends MainState {}

class ErrorGetFavoriteseData extends MainState {}

class LoadingGetFavoritesData extends MainState {}

class SuccessGetUserData extends MainState {}

class ErrorGetUserData extends MainState {}

class LoadingUpdateData extends MainState {}

class SuccessUpdateData extends MainState {
  final ShopLoginModel model;

  SuccessUpdateData(this.model);

}

class ErrorUpdateData extends MainState {}
class ChangeTheme extends MainState {}
class ChangeThemeApp extends MainState {}

class LoadingGetSearchData extends MainState {}

class SuccessGetSearchData extends MainState {}

class ErrorGetSearchData extends MainState {}