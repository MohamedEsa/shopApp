import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import 'cubit.dart';
import 'states.dart';

class RegisterShopScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneContoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
          listener: (context, state) {
        if (state is ShopRegisterSuccessState) {
          if (state.loginModel.status!) {
            shoWToast(
                text: state.loginModel.message!, states: ToastStates.SUCCESS);
            CacheHelper.saveData(
                    key: 'token', value: state.loginModel.data?.token)
                .then(
              (value) {
                token = state.loginModel.data!.token!;
                navigateAndFinish(
                  context,
                  ShopLayout(),
                );
              },
            );
          } else {
            shoWToast(
                text: state.loginModel.message!, states: ToastStates.ERROR);
          }
        }
      }, builder: (context, state) {
        return Scaffold(
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
                        'REGISTER',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        'Register Now to get our hot offers',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultTextFormField(
                          controller: nameController,
                          prefix: Icons.person,
                          validate: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Name must not be empty';
                            }
                            return null;
                          },
                          label: 'User Name',
                          type: TextInputType.name),
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
                            ShopRegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                phone: phoneContoller.text,
                                email: emailController.text,
                                password: passwordController.text);
                          },
                          suffixIcon: IconButton(
                            onPressed: () {
                              ShopRegisterCubit.get(context).changeBool();
                            },
                            icon: ShopRegisterCubit.get(context).isTrue
                                ? Icon(Icons.visibility_off_outlined)
                                : Icon(Icons.visibility),
                          ),
                          isPassword: ShopRegisterCubit.get(context).isTrue,
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
                      defaultTextFormField(
                          controller: phoneContoller,
                          prefix: Icons.phone,
                          validate: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Phone must not be empty';
                            }
                            return null;
                          },
                          label: 'Phone Number',
                          type: TextInputType.phone),
                      SizedBox(
                        height: 15.0,
                      ),
                      state is! ShopRegisterLoadingState
                          ? defaultButton(
                              text: 'Register',
                              function: () {
                                if (formKey.currentState!.validate()) ;
                                ShopRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    phone: phoneContoller.text,
                                    email: emailController.text,
                                    password: passwordController.text);
                              })
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
