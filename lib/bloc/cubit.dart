import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:gp/bloc/states.dart';
import 'package:gp/models/insects_data_model.dart';
import 'package:gp/network/remote/DioHelper.dart';
import 'package:gp/screens/capure_screen.dart';
import 'package:gp/screens/info_screen.dart';
import 'package:gp/screens/report.dart';
import 'package:gp/screens/visulzation_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../components/components.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../sevices/notification_service.dart';

class GpCubit extends Cubit<gpStates> {
  GpCubit() : super(GpIntialState());
  File? image;
  var message;
  var numcc;
  var numBz;
  //bottom navBar
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomNavBarItems = const [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.camera_alt_rounded,
        ),
        label: "capture"),
    BottomNavigationBarItem(
        icon: Icon(Icons.document_scanner_outlined), label: "report"),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.add_chart_rounded,
        ),
        label: "visualization"),
    BottomNavigationBarItem(
        icon: Icon(Icons.perm_device_information), label: "information"),
  ];
  List<Widget> GpScreens = [
    CapureScreen(),
    ReportScreen(),
    VisualizationScreen(),
    InfoScreen()
  ];
  changeBotNavIndex(int index) {
    currentIndex = index;
    emit(GpChangeBotNavIndexState());
  }

  // _pickimage(ImageSource src) async {
  //   final _pickedimage = await ImagePicker().pickImage(
  //     source: src,
  //   );
  //   if (_pickedimage != null) _image = File(_pickedimage.path);
  // }

  // ApiRequest() {
  //   var uri = Uri.parse("http://insect-detectoin-api.azurewebsites.net/detect");
  //   final headers = {"content-type": "multipart/form-data"};
  //   // create multipart request
  //   request = http.MultipartRequest("POST", uri);

  //   // multipart that takes file
  //   var multipartFile = http.MultipartFile(
  //       'image', _image!.readAsBytes().asStream(), _image!.lengthSync(),
  //       filename: _image!.path.split('/').last);

  //   // add file to multipart
  //   request.files.add(multipartFile);
  //   request.headers.addAll(headers);
  //   emit(GpRequestState());
  // }

  // ApiRespose() async {
  //   final response = await request.send();
  //   if (response.statusCode == 200) {
  //     http.Response res = await http.Response.fromStream(response);
  //     final resjson = jsonDecode(res.body);
  //     message = resjson['message'];
  //     numcc = resjson['n_cc'];
  //     numBz = resjson['n_bz'];
  //     print(message);
  //     print(numcc);
  //     print(numBz);
  //   }
  // }

  pickimage(ImageSource src, context) async {
    await ImagePicker()
        .pickImage(
      source: src,
    )
        .then((value) {
      if (value != null) {
        image = File(value.path);
        emit(GpPickState());
      }
    }).catchError((error) {
      print(error);
      buildAlertDialog(error, context);
    });
  }

  bool isShowAftar = false;
  sendImage(BuildContext context) {
    if (image != null) {
      emit(GpLoadingState());
      var uri = Uri.parse(
          "https://mysterious-castle-43049.herokuapp.com/api/detect-image");
      final headers = {
        "content-type": "multipart/form-data",
        'Accept': 'application/json'
      };
      // create multipart request
      var request = http.MultipartRequest("POST", uri);

      // multipart that takes file
      var multipartFile = http.MultipartFile(
          'image', image!.readAsBytes().asStream(), image!.lengthSync(),
          filename: image!.path.split('/').last);

      // add file to multipart
      request.files.add(multipartFile);
      request.headers.addAll(headers);
      request.send().then((response) {
        // emit(GpRequestState());
        if (response.statusCode == 200) {
          http.Response.fromStream(response).then((value) {
            print(value.body);
            final resjson = jsonDecode(value.body);
            message = resjson['message'];
            numcc = resjson['n_cc'];
            numBz = resjson['n_bz'];
            emit(GpSuccessResposeState());
            /*   NotificationWidget.showNotification(
                title: 'upload image to cloud ', body: '${message}');*/

            buildShowToast(message: '${message}', background: Colors.green);

            if (double.parse(numBz) > BzNumDrop ||
                double.parse(numcc) > CsNumDrop) {
              NotificationWidget.showNotification(
                  id: 1,
                  title: 'Warning !! ',
                  body:
                      'Warning !! Exceeding the limit There is too much insects in image ');
              isShowAftar = true;
            }

            print(message);
            print(numcc);
            print(numBz);
          }).catchError((error) {
            print(error.toString());
            /*   NotificationWidget.showNotification(
                title: 'upload image to cloud ', body:  error.toString().contains("SocketException")
                    ? "Internet connection failed"
                    : error.toString());*/
            buildShowToast(
                message: error.toString().contains("SocketException")
                    ? "Internet connection failed"
                    : error.toString());
            // buildAlertDialog(error, context);
          });
        }
      }).catchError((error) {
        print(error.toString());
        emit(GpErrorResposeState());
        /*   NotificationWidget.showNotification(
            title: 'upload image to cloud ',
            body: error.toString().contains("SocketException")
                ? "Internet connection failed"
                : error.toString());*/
        buildShowToast(
            message: error.toString().contains("SocketException")
                ? "Internet connection failed"
                : error.toString());
        // buildAlertDialog(error, context);
      });
    }
  }

  // Theme mode state
  bool isDark = true;
  changeThemeMode({bool? fromPres}) async {
    if (fromPres != null) {
      isDark = fromPres;
      emit(GpChangeThemeMOdeState());
    } else {
      isDark = !isDark;
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool("isDark", isDark);
      emit(GpChangeThemeMOdeState());
    }
  }

  //get data
  InsectsModel? insectsModel;

  getInsectsData() {
    DioHelper.getDataV2(
      url: 'detect-image',
      //    token: "1|wtEBam4hkOe65dKbTHG4rtf9q4DbjAVVxzhq9CRC"
    ).then((value) {
      print(value.data);
      insectsModel = InsectsModel.fromjson(value.data);
      emit(GpSuccessGetInsectsData());
    }).catchError((error) {
      emit(GpErrorGetInsectsData());
      buildShowToast(
          message: error.toString().contains("SocketException")
              ? "Internet connection failed"
              : error.toString());
      print('error is $error');
    });
  }

  //get notifications
  List<InsectsDataModel> notifications = [];
  Future getNotifications() {
    notifications = [];
    emit(GpLoadindgGetNotificationsData());
    return DioHelper.getDataV2(
      url: 'detect-image',
      //    token: "1|wtEBam4hkOe65dKbTHG4rtf9q4DbjAVVxzhq9CRC"
    ).then((value) {
      print(value.data);
      insectsModel = InsectsModel.fromjson(value.data);
      insectsModel!.data.forEach(((element) {
        if (double.parse(element.data!.bzN) > BzNumDrop ||
            double.parse(element.data!.ccN) > CsNumDrop) {
          notifications.add(element);
        }
      }));
      emit(GpSuccessGetNotificationsData());
    }).catchError((error) {
      emit(GpErrorGetNotificationsData());
      buildShowToast(
          message: error.toString().contains("SocketException")
              ? "Internet connection failed"
              : error.toString());
      print('error is $error');
    });
  }

  deleteImage() {
    image = null;
    emit(GpDeleteImageState());
  }

  //settings page
  int CsNumDrop = 10;
  int BzNumDrop = 10;
  changeCcValue(dynamic val) {
    CsNumDrop = val;
    print(CsNumDrop);
    emit(GpChangeCcNumstate());
  }

  changeBzValue(dynamic val) {
    BzNumDrop = val;
    print(BzNumDrop);
    emit(GpChangeBzNumstate());
  }
}
