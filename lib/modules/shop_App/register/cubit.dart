import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/shopApp/shopAppModel.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/network/remote/endpoints.dart';
import 'states.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitailState());
  bool isTrue = true;
  static ShopAppLoginModel? loginModel;
  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone
      },
    ).then((value) {
      loginModel = ShopAppLoginModel.fromJson(value.data);

      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());

      emit(ShopRegisterErrorState());
    });
  }

  void changeBool() {
    isTrue = !isTrue;
    emit(ShopRegisterBoolState());
  }
}
