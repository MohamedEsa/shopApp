import '../../../models/shopApp/shopAppModel.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitailState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final ShopAppLoginModel loginModel;
  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterBoolState extends ShopRegisterStates {}

class ShopRegisterSkipState extends ShopRegisterStates {}

class ShopRegisterErrorState extends ShopRegisterStates {
  final String? error;
  // final ShopAppLoginModel loginErrorModel;
  ShopRegisterErrorState({this.error});
}
