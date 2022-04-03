import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../modules/shop_App/categories/categories_screen.dart';
import '../../../modules/shop_App/favorites/favorites_screen.dart';
import '../../../modules/shop_App/products/products_screen.dart';
import '../../../modules/shop_App/settings/settingsShop_screen.dart';
import 'states.dart';

class HomeIndexCubit extends Cubit<ShopAppStates> {
  HomeIndexCubit() : super(ShopAppInitState());
  int currentIndex = 0;
  static HomeIndexCubit get(context) => BlocProvider.of(context);
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    ShopSettingsScreen()
  ];
  void changeIndex(int index) {
    currentIndex = index;
    emit(ShopAppChangeBottomNavState());
  }
}
