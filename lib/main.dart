import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopApp/layout/shop_app/cubit/states.dart';
import 'package:shopApp/modules/shop_App/on_boarding/on_boarding_screen.dart';

import 'layout/shop_app/cubit/cubit.dart';
import 'modules/shop_App/login/cubit/cubit.dart';
import 'modules/shop_App/login/cubit/states.dart';
import 'modules/shop_App/login/shop_login_screen.dart';
import 'shared/components/constants.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';
import 'shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  print('Token');
  print(token);

  //token = CacheHelper.getData(key: 'token');
  uId = CacheHelper.getData(key: 'uId');
  print(uId);
  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'onBoard');

  print('onBoarding: $onBoarding');
  runApp(MyApp(
      // startWidget: widget,
      ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;
  MyApp({this.startWidget, this.isDark});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopLoginCubit(),
        ),
        BlocProvider(
          create: (context) => ShopAppCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getUserData()
            ..getFav(),
        ),
      ],
      child: BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (context, states) {},
        builder: (context, states) => MaterialApp(
            themeMode: ThemeMode.light,
            darkTheme: darkTheme,
            theme: lightTheme,
            home: OnBoardingScreen()
            //  startWidget

            //
            ),
      ),
    );
  }
}
