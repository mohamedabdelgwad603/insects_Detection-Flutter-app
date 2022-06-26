import '../../../models/loginModel.dart';

abstract class ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginIntialState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates {}

class ShopLoginChangVisibiltyState extends ShopLoginStates {}
