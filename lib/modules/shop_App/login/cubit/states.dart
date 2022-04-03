import '../../../../models/shopApp/shopAppModel.dart';

abstract class ShopLoginStates {}

class ShopLoginInitailState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  final ShopAppLoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginBoolState extends ShopLoginStates {}

class ShopLoginSkipState extends ShopLoginStates {}

class ShopLoginErrorState extends ShopLoginStates {
  final String? error;
  // final ShopAppLoginModel loginErrorModel;
  ShopLoginErrorState({this.error});
}
