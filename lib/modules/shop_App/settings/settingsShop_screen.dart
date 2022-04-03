import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';

class ShopSettingsScreen extends StatefulWidget {
  @override
  _ShopSettingsScreenState createState() => _ShopSettingsScreenState();
}

class _ShopSettingsScreenState extends State<ShopSettingsScreen> {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var model = ShopAppCubit.get(context).userModel;

    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneContoller.text = model.data!.phone!;
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                if (state is ShopLoadingUpdateUserDataState)
                  LinearProgressIndicator(),
                SizedBox(
                  height: 20.0,
                ),
                defaultTextFormField(
                  label: 'Name',
                  prefix: Icons.person,
                  controller: nameController,
                  type: TextInputType.name,
                  validate: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Name must Not Be Empty';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultTextFormField(
                  label: 'Email',
                  prefix: Icons.email,
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  validate: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Email must Not Be Empty';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultTextFormField(
                  label: 'Phone',
                  prefix: Icons.phone,
                  controller: phoneContoller,
                  type: TextInputType.phone,
                  validate: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Phone must Not Be Empty';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultButton(
                  text: 'UPDATE',
                  function: () {
                    if (formKey.currentState!.validate()) {
                      ShopAppCubit.get(context).updateUserData(
                          name: nameController.text,
                          phone: phoneContoller.text,
                          email: emailController.text);
                    }
                  },
                ),
                // قشطات
                SizedBox(
                  height: 20.0,
                ),
                defaultButton(
                  text: 'Log OUT',
                  function: () {
                    signOut(context);
                    // print(token);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
