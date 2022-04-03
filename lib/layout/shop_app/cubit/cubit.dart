import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/shopApp/categories_model.dart';
import '../../../models/shopApp/fav_model.dart';
import '../../../models/shopApp/favorites_model.dart';
import '../../../models/shopApp/home_Model.dart';
import '../../../models/shopApp/shopAppModel.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/network/remote/endpoints.dart';
import 'states.dart';

class ShopAppCubit extends Cubit<ShopAppStates> {
  ShopAppCubit() : super(ShopAppInitState());

  static ShopAppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(ShopAppChangeBottomNavState());
  }

  Map<int, bool> favorites = {};
  HomeModel? homeModel;
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel?.data!.products.forEach((element) {
        favorites.addAll({element.id!: element.inFavorites!});
      });
      print(token);
      print(homeModel?.data!.banners[0].image);

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  Future<void> getCategoriesData() async {
    try {
      final response = await DioHelper.getData(url: CATEGORIES);
      if (response.statusCode == 200) {
        categoriesModel = CategoriesModel.fromJson(response.data);
        emit(ShopSuccessCategoriesDataState());
      } else {
        emit(ShopErrorCategoriesDataState());
      }
    } catch (e) {
      print(e);
      emit(ShopErrorCategoriesDataState());
    }
  }

  FavoritesModel? favoritesModel;
  void changeFavColor(int id) {
    favorites[id] = !favorites[id]!;
    emit(ShopChangeFavState());
    DioHelper.postData(url: FAVOURITES, token: token, data: {'product_id': id})
        .then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      if (!favoritesModel!.status!) {
        favorites[id] = !favorites[id]!;
      } else {
        getFav();
      }
      emit(ShopChangeSuccessFavState(favoritesModel!));
    }).catchError((error) {
      favorites[id] = !favorites[id]!;

      emit(ShopChangeErrorFavState());
    });
  }

  FavoritessModel? favorModel;
  void getFav() {
    emit(ShopLoadingFavDataState());
    DioHelper.getData(url: FAVOURITES, token: token).then((value) {
      favorModel = FavoritessModel.fromJson(value.data);

      emit(ShopSuccessFavDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorFavDataState());
    });
  }

  ShopAppLoginModel? userModel;
  Future<void> getUserData() async {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userModel = ShopAppLoginModel.fromJson(value.data);
      print(userModel?.data?.name);

      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({@required name, @required phone, @required email}) {
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {'name': name, 'email': email, 'phone': phone},
    ).then((value) {
      userModel = ShopAppLoginModel.fromJson(value.data);
      print(userModel?.data?.name);

      emit(ShopSuccessUpdateUserDataState(userModel!));
    }).catchError((error) {
      emit(ShopErrorUpdateUserDataState());
    });
  }
}
