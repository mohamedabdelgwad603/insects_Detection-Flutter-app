import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gp/screens/myHome.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'constants.dart';

Widget pickButton(
    String title, IconData icon, BuildContext context, void Function() click) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 15),
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
            minimumSize: Size.fromHeight(50)),
        onPressed: click,
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText2,
            )
          ],
        )),
  );
}

buildAlertDialog(error, context) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            elevation: 20,
            title: Text(
              "ُErorr!:",
              style: TextStyle(color: Colors.red),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  error.toString().contains("SocketException")
                      ? "Internet connection failed"
                      : error.toString(),
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(70, 40),
                        onPrimary: Colors.white,
                        primary: Colors.black),
                    child: Text("close"),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.of(context).pop(MaterialPageRoute(
                          builder: ((context) => MyHomePage())));
                    })
              ],
            ),
          ));
}

buildShowToast(
    {required String message,
    Toast toastLength = Toast.LENGTH_LONG,
    ToastGravity tGravity = ToastGravity.BOTTOM,
    int timeInSecForIosWeb = 5,
    Color? background = Colors.red,
    Color textColor = Colors.white,
    double fontSize = 16.0}) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      gravity: tGravity,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: background,
      textColor: textColor,
      fontSize: fontSize);
}

Widget defaultFormField(
    {TextEditingController? controller,
    TextInputType? type,
    String? Function(String?)? validate,
    void Function()? ontap,
    void Function(String)? onchange,
    void Function(String?)? onSaved,
    void Function(String)? onSubmitted,
    String? label,
    IconData? prefix,
    IconData? suffix,
    void Function()? onPressSuffix,
    bool obscure = false}) {
  return TextFormField(
    onFieldSubmitted: onSubmitted,
    validator: validate,
    onChanged: onchange,
    onTap: ontap,
    onSaved: onSaved,
    controller: controller,
    obscureText: obscure,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(onPressed: onPressSuffix, icon: Icon(suffix))
            : null),
  );
}

Widget defaultButton(
    {double width = double.infinity,
    Color backgound = Colors.blue,
    required String text,
    Color textColor = Colors.white,
    double radius = 0.0,
    bool isUpper = true,
    required void Function()? onpressed}) {
  return Container(
    width: width,
    decoration: BoxDecoration(
        color: backgound, borderRadius: BorderRadius.circular(radius)),
    child: MaterialButton(
      onPressed: onpressed,
      child: Text(
        isUpper ? text.toUpperCase() : text,
        style: TextStyle(color: textColor),
      ),
    ),
  );
}

push(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

DropdownButton<dynamic> buildDropDown(
    List items, int num, String hint, void Function(dynamic)? onChanged) {
  return DropdownButton<dynamic>(
      iconEnabledColor: hexColor,
      dropdownColor: hexColor,
      hint: Text(
        hint,
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
      value: num,
      items: items
          .map(
            (e) => DropdownMenuItem(
                value: e,
                child: Text("$e", style: TextStyle(color: Colors.orange))),
          )
          .toList(),
      onChanged: onChanged);
}

String formatDate(String date) {
  return DateFormat.yMMMd().add_jms().format(DateTime.parse(date));
}
