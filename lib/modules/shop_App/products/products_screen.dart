import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../models/shopApp/categories_model.dart';
import '../../../models/shopApp/home_Model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        if (state is ShopChangeSuccessFavState) {
          if (!state.model.status!) {
            shoWToast(
                text: state.model.message ?? '', states: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        return ShopAppCubit.get(context).homeModel != null &&
                ShopAppCubit.get(context).categoriesModel != null
            ? productsBuilder(ShopAppCubit.get(context).homeModel!,
                ShopAppCubit.get(context).categoriesModel!, context)
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}

Widget productsBuilder(
        HomeModel model, CategoriesModel categoriesModel, context) =>
    SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
            items: model.data!.banners
                .map(
                  (e) => Image(
                    image: NetworkImage('${e.image}'),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              height: 100.0,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => stackBuilder(
                  categoriesModel.data?.data[index],
                ),
                separatorBuilder: (context, index) => SizedBox(
                  width: 10.0,
                ),
                itemCount: categoriesModel.data!.data.length,
              ),
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.70,
              children: List.generate(
                model.data!.products.length,
                (index) =>
                    buildGridProduct(model.data!.products[index], context),
              ),
            ),
          )
        ],
      ),
    );

Widget stackBuilder(DataModel? model) => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          height: 100.0,
          width: 100.0,
          image: NetworkImage(model?.image ?? ''),
          fit: BoxFit.cover,
        ),
        Container(
          width: 100.0,
          color: Colors.black.withOpacity(0.7),
          child: Text(
            model?.name ?? '',
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
Widget buildGridProduct(ProductModel model, context) {
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image!),
              width: double.infinity,
              height: 200.0,
            ),
            if (model.discount != 0)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                color: Colors.red,
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(color: Colors.white, fontSize: 8.0),
                ),
              )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(height: 1.3),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: TextStyle(height: 1.3, color: defaultColor),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  if (model.discount != 0)
                    Text(
                      '${model.oldPrice.round()}',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        height: 1.3,
                        color: Colors.grey[500],
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      ShopAppCubit.get(context).changeFavColor(model.id!);
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
  );
}
