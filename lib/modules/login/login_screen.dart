import 'package:flutter/material.dart';

import '../../shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool redEye = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  defaultTextFormField(
                      label: 'Email',
                      prefix: Icons.email,
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'email adress must not be empty ';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultTextFormField(
                    label: 'Password',
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    isPassword: redEye,
                    prefix: Icons.lock,
                    suffixIcon: IconButton(
                      icon: Icon(
                          redEye ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          redEye = !redEye;
                        });
                      },
                    ),
                    validate: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'password must not be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                      text: 'LOGIN',
                      function: () {
                        if (formKey.currentState!.validate()) {}
                      }),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account ?'),
                      SizedBox(
                        width: 10.0,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Regeister NOW'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
