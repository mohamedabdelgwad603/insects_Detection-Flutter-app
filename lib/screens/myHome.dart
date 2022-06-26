import 'package:flutter/material.dart';
import 'package:gp/bloc/cubit.dart';
import 'package:gp/bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/components/components.dart';
import 'package:gp/components/constants.dart';
import 'package:gp/network/local/cashe_helper.dart';
import 'package:gp/screens/login/login_screen.dart';
import 'package:gp/screens/notificatio_screen.dart';
import 'package:gp/screens/settings_screen.dart';
import 'package:gp/screens/webView_screen.dart';

class MyHomePage extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return BlocConsumer<GpCubit, gpStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<GpCubit>(context);
        return Scaffold(
            drawer: Drawer(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 200,
                    color: hexColor,
                    child: Text(
                      "insects detection",
                      style: TextStyle(color: Colors.orange, fontSize: 30),
                    ),
                  ),
                  buildDrawerButton(context, 'Settings', Icons.settings, () {
                    push(context, SettingsScreen());
                  }),
                  /*  buildDrawerButton(context, 'webView', Icons.web, () {
                    push(context, WebViewScreen());
                  }),*/
                  buildDrawerButton(context, 'LogOut', Icons.logout_sharp, () {
                    CashHelper.removeData('token').then((value) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreeen(),
                          ));
                    });
                  }),
                ],
              ),
            ),
            appBar: AppBar(
              title: Text("insects Detection "),
              actions: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    IconButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          cubit.isShowAftar = false;
                          cubit.getNotifications().then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NotificationsScreen()));
                          });
                        },
                        icon: Icon(Icons.notifications)),
                    if (cubit.isShowAftar)
                      Container(
                        margin: EdgeInsets.only(bottom: 12, right: 10),
                        child: CircleAvatar(
                          radius: 7,
                          backgroundColor: Colors.red,
                        ),
                      )
                  ],
                )

                /*    Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: /*IconButton(
                    icon: Icon(Icons.brightness_4_rounded),
                    onPressed: cubit.changeThemeMode,
                  ),*/
                      IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      CashHelper.removeData('token').then((value) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreeen(),
                            ));
                      });
                    },
                  ),
                )*/
              ],
              elevation: 0.0,
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.grey[800],
              selectedItemColor: Colors.orange,
              unselectedItemColor: Colors.grey[800],
              items: cubit.bottomNavBarItems,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBotNavIndex(index);
                if (cubit.currentIndex == 1 || cubit.currentIndex == 2) {
                  cubit.getInsectsData();
                }
              },
            ),
            extendBodyBehindAppBar: false,
            body: cubit.GpScreens[cubit.currentIndex]);
      },
    );
  }

  Padding buildDrawerButton(BuildContext context, String name, IconData icon,
      void Function()? onTap) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              icon,
              color: hexColor,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              name,
              style: TextStyle(color: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}
