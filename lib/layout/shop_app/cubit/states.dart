import '../../../models/shopApp/favorites_model.dart';
import '../../../models/shopApp/shopAppModel.dart';

abstract class ShopAppStates {}

class ShopAppInitState extends ShopAppStates {}

class ShopAppChangeBottomNavState extends ShopAppStates {}

class ShopLoadingHomeDataState extends ShopAppStates {}

class ShopSuccessHomeDataState extends ShopAppStates {}

class ShopErrorHomeDataState extends ShopAppStates {
  String? error;
  ShopErrorHomeDataState({this.error});
}

class ShopSuccessCategoriesDataState extends ShopAppStates {}

class ShopErrorCategoriesDataState extends ShopAppStates {
  String? error;
  ShopErrorCategoriesDataState({this.error});
}

class ShopChangeSuccessFavState extends ShopAppStates {
  final FavoritesModel model;

  ShopChangeSuccessFavState(this.model);
}

class ShopChangeFavState extends ShopAppStates {}

class ShopChangeErrorFavState extends ShopAppStates {}

class ShopSuccessFavDataState extends ShopAppStates {}

class ShopLoadingFavDataState extends ShopAppStates {}

class ShopErrorFavDataState extends ShopAppStates {}

class ShopLoadingUserDataState extends ShopAppStates {}

class ShopSuccessUserDataState extends ShopAppStates {
  final ShopAppLoginModel model;
  ShopSuccessUserDataState(this.model);
}

class ShopErrorUserDataState extends ShopAppStates {}

class ShopLoadingUpdateUserDataState extends ShopAppStates {}

class ShopSuccessUpdateUserDataState extends ShopAppStates {
  final ShopAppLoginModel model;
  ShopSuccessUpdateUserDataState(this.model);
}

class ShopErrorUpdateUserDataState extends ShopAppStates {}

class ShopLogoutState extends ShopAppStates {}
