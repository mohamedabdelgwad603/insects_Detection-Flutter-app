import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/screens/myHome.dart';

import '../../components/components.dart';
import '../../components/constants.dart';
import '../../network/local/cashe_helper.dart';

import '../login/bloc/loginStates.dart';
import '../login/login_screen.dart';
import 'bloc/registerCubit.dart';
import 'bloc/registerStates.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController nameConrtoller = TextEditingController();
  TextEditingController phoneConrtoller = TextEditingController();
  TextEditingController emailConrtoller = TextEditingController();
  TextEditingController passConrtoller = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
          listener: (context, state) async {
        if (state is ShopRegisterSuccessState) {
          if (state.registerModel.status == true) {
            CashHelper.setData("token", state.registerModel.data!.token)
                .then((value) {
              token = state.registerModel.data!.token;
              if (value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              }
            });
          } else {
            buildShowToast(
              message: "${state.registerModel.message}",
            );
          }
        }
      }, builder: (context, state) {
        var cubit = BlocProvider.of<ShopRegisterCubit>(context);
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
                        "Register",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: hexColor),
                      ),
                      Text(
                        "Register now to detect insect images",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        controller: nameConrtoller,
                        type: TextInputType.name,
                        label: "name",
                        prefix: Icons.person,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "name must not be empty";
                          } else
                            return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: phoneConrtoller,
                        type: TextInputType.phone,
                        label: "phone",
                        prefix: Icons.phone,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "phone number must not be empty";
                          } else
                            return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
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
                                text: "Register",
                                textColor: Colors.orange,
                                backgound: hexColor,
                                onpressed: () {
                                  if (formkey.currentState!.validate()) {
                                    cubit.userRegister(
                                        name: nameConrtoller.text,
                                        phone: phoneConrtoller.text,
                                        email: emailConrtoller.text,
                                        password: passConrtoller.text);
                                  }
                                },
                                //  backgound: Theme.of(context).primaryColor
                              ),
                          fallback: (context) => const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.orange),
                              )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("i have have an account?",
                              style: TextStyle(color: hexColor)),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            LoginScreeen())));
                              },
                              child: const Text("Login",
                                  style: TextStyle(color: Colors.orange)))
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
