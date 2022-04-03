import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/shop_App/search/search_screen.dart';
import '../../shared/components/components.dart';
import 'cubit/homeIndexCubit.dart';
import 'cubit/states.dart';

class ShopLayout extends StatefulWidget {
  @override
  _ShopLayoutState createState() => _ShopLayoutState();
}

class _ShopLayoutState extends State<ShopLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeIndexCubit(),
      child: BlocConsumer<HomeIndexCubit, ShopAppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = HomeIndexCubit.get(context);
            return Scaffold(
              appBar: AppBar(title: Text('Salla '), actions: [
                IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search),
                )
              ]),
              body: cubit.bottomScreens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                currentIndex: cubit.currentIndex,
                items: [
                  BottomNavigationBarItem(
                    label: 'Home',
                    icon: Icon(Icons.home),
                  ),
                  BottomNavigationBarItem(
                    label: 'Categories',
                    icon: Icon(Icons.apps),
                  ),
                  BottomNavigationBarItem(
                    label: 'Favorites',
                    icon: Icon(Icons.favorite),
                  ),
                  BottomNavigationBarItem(
                    label: 'Settings',
                    icon: Icon(Icons.settings),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
