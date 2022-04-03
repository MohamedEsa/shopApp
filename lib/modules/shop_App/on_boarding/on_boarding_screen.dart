import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/colors.dart';
import '../login/cubit/cubit.dart';
import '../login/cubit/states.dart';
import '../login/shop_login_screen.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/shop1.jpg',
        title: 'On board 1 title',
        body: 'On board 1 body'),
    BoardingModel(
        image: 'assets/images/shop2.jpg',
        title: 'On board 2 title',
        body: 'On board 2 body'),
    BoardingModel(
        image: 'assets/images/shop3.jpg',
        title: 'On board 3 title',
        body: 'On board 3 body')
  ];

  bool isLast = false;

  var boardingController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, states) {},
        builder: (context, states) => Scaffold(
              appBar: AppBar(
                actions: [
                  defaultTextButton(
                      onpress: () {
                        navigateAndFinish(context, ShopLoginScreen());
                      },
                      text: 'skip')
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        onPageChanged: (int index) {
                          if (index == boarding.length - 1) {
                            setState(() {
                              isLast = true;
                            });
                          } else {
                            setState(() {
                              isLast = false;
                            });
                          }
                        },
                        controller: boardingController,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            buildOnboardingItem(boarding[index]),
                        itemCount: boarding.length,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SmoothPageIndicator(
                            effect: ExpandingDotsEffect(
                                activeDotColor: defaultColor,
                                dotColor: Colors.grey,
                                dotHeight: 10.0,
                                expansionFactor: 4.0,
                                dotWidth: 10.0,
                                spacing: 5.0),
                            controller: boardingController,
                            count: boarding.length),
                        Spacer(),
                        FloatingActionButton(
                          onPressed: () {
                            if (isLast) {
                              submit();
                            } else {
                              boardingController.nextPage(
                                  duration: Duration(milliseconds: 750),
                                  curve: Curves.fastLinearToSlowEaseIn);
                            }
                          },
                          child: Icon(Icons.arrow_forward_ios),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  void submit() {
    CacheHelper.saveData(key: 'onBoard', value: true).then((value) {
      if (value) {
        navigateAndFinish(
          context,
          ShopLoginScreen(),
        );
      }
    });
  }

  Widget buildOnboardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text('${model.title}', style: TextStyle(fontSize: 30.0)),
          SizedBox(
            height: 20.0,
          ),
          Text(
            '${model.body}',
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      );
}
