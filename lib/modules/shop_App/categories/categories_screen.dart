import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../models/shopApp/categories_model.dart';
import '../../../shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) {
              return cateogoriesListBuilder(
                  ShopAppCubit.get(context).categoriesModel?.data?.data[index]);
            },
            separatorBuilder: (context, index) => myDividerInList(),
            itemCount:
                ShopAppCubit.get(context).categoriesModel?.data?.data.length ??
                    0);
      },
    );
  }
}

Widget cateogoriesListBuilder(DataModel? model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model!.image!),
            height: 80.0,
            width: 80.0,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            model.name!,
            style: TextStyle(fontSize: 20.0),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
