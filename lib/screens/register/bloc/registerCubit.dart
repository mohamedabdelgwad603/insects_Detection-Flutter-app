import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/screens/register/bloc/registerStates.dart';

import '../../../components/constants.dart';
import '../../../models/loginModel.dart';
import '../../../network/remote/DioHelper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterIntialState());
  ShopLoginModel registerModel = ShopLoginModel();
  void userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    emit(ShopRegisterLoadingState());
    DioHelper.postDataLogin(url: 'register', data: {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password
    }).then((value) {
      registerModel = ShopLoginModel.fromjson(value.data);
      // print(value.data.toString());

      // print(loginModel.message);
      // print(loginModel.data!.token);
      emit(ShopRegisterSuccessState(registerModel));
    }).catchError((error) {
      print("errors occured is ${error.toString()}");
      emit(ShopRegisterErrorState());
    });
  }

  //change Visibilty icon for padssword Text field
  IconData suffixicon = Icons.visibility_outlined;
  bool isObscure = true;
  changeVisibilty() {
    isObscure = !isObscure;
    suffixicon =
        isObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangVisibiltyState());
  }
}
