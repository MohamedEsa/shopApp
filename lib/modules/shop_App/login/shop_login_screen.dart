import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../register/shop_register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
      listener: (context, states) {
        if (states is ShopLoginSuccessState) {
          if (states.loginModel.status!) {
            shoWToast(
                text: states.loginModel.message!, states: ToastStates.SUCCESS);
            CacheHelper.saveData(
                    key: 'token', value: states.loginModel.data?.token)
                .then(
              (value) {
                token = states.loginModel.data!.token!;

                ShopAppCubit.get(context)
                    .getUserData()
                    .then((value) => navigateAndFinish(
                          context,
                          ShopLayout(),
                        ));
              },
            );
          } else {
            print(token);
            shoWToast(
                text: states.loginModel.message!, states: ToastStates.ERROR);
          }
        }
      },
      builder: (context, states) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LOGIN',
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: Colors.black),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'login to get our hot offers',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    defaultTextFormField(
                        controller: emailController,
                        prefix: Icons.email_outlined,
                        validate: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Email must not be empty';
                          }
                          return null;
                        },
                        label: 'email',
                        type: TextInputType.emailAddress),
                    SizedBox(
                      height: 15.0,
                    ),
                    defaultTextFormField(
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) ;
                          ShopLoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text);
                        },
                        suffixIcon: IconButton(
                          onPressed: () {
                            ShopLoginCubit.get(context).changeBool();
                          },
                          icon: ShopLoginCubit.get(context).isTrue
                              ? Icon(Icons.visibility_off_outlined)
                              : Icon(Icons.visibility),
                        ),
                        isPassword: ShopLoginCubit.get(context).isTrue,
                        controller: passwordController,
                        prefix: Icons.lock,
                        validate: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Password is too short !';
                          }
                        },
                        label: 'password',
                        type: TextInputType.visiblePassword),
                    SizedBox(
                      height: 15.0,
                    ),
                    states is! ShopLoginLoadingState
                        ? defaultButton(
                            text: 'Login',
                            function: () {
                              if (formKey.currentState?.validate() ?? false) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            })
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t Have Account ?',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        defaultTextButton(
                            onpress: () {
                              navigateTo(
                                context,
                                RegisterShopScreen(),
                              );
                            },
                            text: 'Register')
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
