import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../models/shopApp/fav_model.dart';
import '../../../models/shopApp/search_model.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchShopCubit(),
      child: BlocConsumer<SearchShopCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultTextFormField(
                          label: 'Search',
                          prefix: Icons.search,
                          controller: searchController,
                          type: TextInputType.text,
                          onChanged: (value) {
                            SearchShopCubit.get(context).search(value);
                          },
                          validate: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter Text to search';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 10.0,
                      ),
                      if (state is SearchLoadingstat) LinearProgressIndicator(),
                      if (state is SearchSucessState)
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return buildFavItem(
                                    SearchShopCubit.get(context)
                                        .searchModel!
                                        .data!
                                        .data1[index],
                                    context,
                                    isOldPrice: false);
                              },
                              separatorBuilder: (context, index) =>
                                  myDividerInList(),
                              itemCount: SearchShopCubit.get(context)
                                  .searchModel!
                                  .data!
                                  .data1
                                  .length),
                        )
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}

Widget buildFavItem(Products model, context, {bool isOldPrice = false}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                    image: NetworkImage(model.image!),
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.cover),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    color: Colors.red,
                    child: Text(
                      '${model.discount} % ',
                      style: TextStyle(color: Colors.white, fontSize: 8.0),
                    ),
                  )
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(height: 1.3),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style: TextStyle(height: 1.3, color: defaultColor),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          '${model.oldPrice}',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            height: 1.3,
                            color: Colors.grey[500],
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          //SearchShopCubit.get(context).changeFavColor(model.id);
                        },
                        icon: CircleAvatar(
                          backgroundColor:
                              ShopAppCubit.get(context).favorites[model.id]!
                                  ? defaultColor
                                  : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
