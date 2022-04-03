import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../models/shopApp/fav_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is! ShopLoadingFavDataState
            ? ListView.separated(
                itemBuilder: (context, index) {
                  return buildFavItem(
                      ShopAppCubit.get(context).favorModel!.data!.data1![index],
                      context);
                },
                separatorBuilder: (context, index) => myDividerInList(),
                itemCount:
                    ShopAppCubit.get(context).favorModel!.data!.data1!.length)
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}

Widget buildFavItem(Datum model, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                    image: NetworkImage(model.product!.image!),
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.cover),
                if (model.product?.discount != 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    color: Colors.red,
                    child: Text(
                      '${model.product?.discount} % ',
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
                    model.product!.name!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(height: 1.3),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.product?.price}',
                        style: TextStyle(height: 1.3, color: defaultColor),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      if (model.product?.discount != 0)
                        Text(
                          '${model.product?.oldPrice}',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            height: 1.3,
                            color: Colors.grey[500],
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopAppCubit.get(context)
                              .changeFavColor(model.product!.id!);
                        },
                        icon: CircleAvatar(
                          backgroundColor: ShopAppCubit.get(context)
                                  .favorites[model.product!.id]!
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
