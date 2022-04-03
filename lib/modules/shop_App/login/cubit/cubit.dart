import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/shopApp/shopAppModel.dart';
import 'states.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/network/local/cache_helper.dart';
import '../../../../shared/network/remote/dio_helper.dart';
import '../../../../shared/network/remote/endpoints.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitailState());
  bool isTrue = true;
  static ShopAppLoginModel? loginModel;
  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {'email': email, 'password': password},
    ).then((value) {
      loginModel = ShopAppLoginModel.fromJson(value.data);

      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());

      emit(ShopLoginErrorState());
    });
  }

  void changeBool() {
    isTrue = !isTrue;
    emit(ShopLoginBoolState());
  }
}
