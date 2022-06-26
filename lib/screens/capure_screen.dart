import 'package:flutter/material.dart';
import 'package:gp/bloc/cubit.dart';
import 'package:gp/screens/Result_detection.dart';
import 'package:gp/sevices/notification_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/bloc/states.dart';

import '../components/components.dart';

class CapureScreen extends StatelessWidget {
  // File? _image;
  // var message;
  // var numcc;
  // var numBz;

  // _pickimage(ImageSource src) async {
  //   final _pickedimage = await ImagePicker().pickImage(
  //     source: src,
  //   );
  //   if (_pickedimage != null)
  //     setState(() {
  //       _image = File(_pickedimage.path);
  //     });

  //   var uri = Uri.parse("http://insect-detectoin-api.azurewebsites.net/detect");
  //   final headers = {"content-type": "multipart/form-data"};
  //   // create multipart request
  //   var request = http.MultipartRequest("POST", uri);

  //   // multipart that takes file
  //   var multipartFile = http.MultipartFile(
  //       'image', _image!.readAsBytes().asStream(), _image!.lengthSync(),
  //       filename: _image!.path.split('/').last);

  //   // add file to multipart
  //   request.files.add(multipartFile);
  //   request.headers.addAll(headers);
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

  //   /* final ref = FirebaseStorage.instance.ref().child('image').child('img.jpg');
  //   await ref.putFile(_image!);*/
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GpCubit, gpStates>(
        listener: ((context, state) {}),
        builder: (context, state) {
          var cubit = BlocProvider.of<GpCubit>(context);

          return SingleChildScrollView(
            child: Column(
              children: [
                cubit.image != null
                    ? Container(
                        height: 200,
                        child: Dismissible(
                          key: Key('key'),
                          onDismissed: (direction) {
                            cubit.deleteImage();
                          },
                          child: Image.file(
                            cubit.image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        margin: EdgeInsets.all(15),
                      )
                    : Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                        ),
                        margin: EdgeInsets.symmetric(vertical: 30),
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.photo_camera_outlined,
                              size: 40,
                            ),
                            Text(
                              "pick image for detection",
                              style: Theme.of(context).textTheme.bodyText1,
                            )
                          ],
                        ),
                      ),
                pickButton(
                    'pick gallery', Icons.photo_camera_back_outlined, context,
                    () {
                  cubit.pickimage(ImageSource.gallery, context);
                }),
                const SizedBox(
                  height: 15,
                ),
                pickButton('pick camera', Icons.camera_alt_outlined, context,
                    () {
                  cubit.pickimage(ImageSource.camera, context);
                }),
                const SizedBox(
                  height: 15,
                ),
                state is! GpLoadingState
                    ? pickButton(
                        'upload image to cloud',
                        Icons.upload_outlined,
                        context,
                        () {
                          if (cubit.image != null) {
                            cubit.sendImage(context);
                          } else {
                            buildShowToast(
                                message: 'not found image to upload',
                                background: Colors.orange);
                          }

                          /*
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => BlocProvider.value(
                            value: BlocProvider.of<GpCubit>(context),
                            child: DetectionResult())));*/
                        },
                      )
                    : CircularProgressIndicator(
                        color: Colors.orange,
                      ),
              ],
            ),
          );
        });
  }
}
