import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/bloc/cubit.dart';
import 'package:gp/bloc/states.dart';
import 'package:gp/network/remote/DioHelper.dart';
import 'package:gp/screens/login/login_screen.dart';
import 'package:gp/screens/myHome.dart';
import 'package:gp/sevices/notification_service.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/constants.dart';
import 'network/local/cashe_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  await DioHelper.init();
  NotificationWidget.init();
  // SharedPreferences prefGet = await SharedPreferences.getInstance();
  // prefGet.remove("isDark");
  // var darkBool = prefGet.getBool("isDark");
  await CashHelper.init();
  token = CashHelper.getData("token");
  print(token);
  Widget widget;

  if (token != null) {
    widget = MyHomePage();
  } else {
    widget = LoginScreeen();
  }

  runApp(MyApp(
    // darkBool: darkBool,
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final darkBool;
  final widget;

  MyApp({this.darkBool, this.widget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GpCubit()
        ..changeThemeMode(fromPres: darkBool)
        ..getInsectsData()
        ..getNotifications(),
      child: BlocConsumer<GpCubit, gpStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = BlocProvider.of<GpCubit>(context);
            return MaterialApp(
              theme: ThemeData(
                  primaryColor: Colors.white,
                  iconTheme: IconThemeData(color: Colors.black),
                  //canvasColor: Colors.white,
                  scaffoldBackgroundColor: Colors.white,
                  textTheme: const TextTheme(
                    bodyText1:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    bodyText2: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  appBarTheme: AppBarTheme(
                      backgroundColor: HexColor("##000e10"),
                      foregroundColor: Colors.orange,
                      titleTextStyle: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: Colors.white,
                          statusBarIconBrightness: Brightness.dark))),
              /* darkTheme: ThemeData(
                  primaryColor: Colors.grey[800],
                  iconTheme: IconThemeData(color: Colors.white),
                  //canvasColor: Colors.grey[800],
                  scaffoldBackgroundColor: Colors.grey[800],
                  textTheme: const TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    bodyText2: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  appBarTheme: AppBarTheme(
                      backgroundColor: Colors.grey[800],
                      foregroundColor: Colors.white,
                      titleTextStyle: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: Colors.grey[800],
                          statusBarIconBrightness: Brightness.light))),*/
              themeMode: ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: widget,
            );
          }),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
