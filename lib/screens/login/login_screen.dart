import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/screens/login/bloc/loginCubit.dart';
import 'package:gp/screens/login/bloc/loginStates.dart';
import 'package:gp/screens/myHome.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../components/components.dart';
import '../../components/constants.dart';
import '../../network/local/cashe_helper.dart';
import '../register/register_screen.dart';

class LoginScreeen extends StatelessWidget {
  TextEditingController emailConrtoller = TextEditingController();
  TextEditingController passConrtoller = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          listener: (context, state) async {
        if (state is ShopLoginSuccessState) {
          if (state.loginModel.status == true) {
            //   var cashHelper = CashHelper;
            CashHelper.setData("token", state.loginModel.data!.token)
                .then((value) {
              token = state.loginModel.data!.token;
              if (value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              }
            });
          } else {
            buildShowToast(
              message: "${state.loginModel.message}",
            );
          }
        }
      }, builder: (context, state) {
        var cubit = BlocProvider.of<ShopLoginCubit>(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "LOGIN",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: hexColor),
                      ),
                      Text(
                        "login now to detect insect images",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        controller: emailConrtoller,
                        type: TextInputType.emailAddress,
                        label: "Email address",
                        prefix: Icons.email_outlined,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "email address must not be empty";
                          } else if (!value.contains("@")) {
                            return "email must be contain @";
                          } else
                            return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: passConrtoller,
                        type: TextInputType.visiblePassword,
                        obscure: cubit.isObscure,
                        label: "password",
                        prefix: Icons.lock,
                        suffix: cubit.suffixicon,
                        onPressSuffix: () {
                          cubit.changeVisibilty();
                        },
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "password must not be empty";
                          } else if (value.length < 6) {
                            return "password must be at least 6 character";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                                backgound: hexColor,
                                textColor: Colors.orange,
                                text: "login",
                                onpressed: () {
                                  if (formkey.currentState!.validate()) {
                                    cubit.userLogin(
                                        email: emailConrtoller.text,
                                        password: passConrtoller.text);
                                  }
                                },
                              ),
                          fallback: (context) => const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.orange,
                                ),
                              )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?",
                              style: TextStyle(color: hexColor)),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            RegisterScreen())));
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(color: Colors.orange),
                              ))
                        ],
                      )
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
