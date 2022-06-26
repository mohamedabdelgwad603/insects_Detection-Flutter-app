import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gp/components/constants.dart';

class _insectModel {
  final String img;
  final String name;

  _insectModel(this.img, this.name);
}

class InfoScreen extends StatelessWidget {
  List<_insectModel> insects = [
    _insectModel('assets/cc.jpg', "ceratitis capitata"),
    _insectModel('assets/bz.jpg', "bactrocera zonata")
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            options: CarouselOptions(
                height: 200.0, autoPlay: true, viewportFraction: 1),
            items: insects.map((item) {
              return Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Image(
                    image: AssetImage(item.img),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 50,
                    color: Colors.black.withOpacity(.6),
                    child: Text(
                      item.name,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              );
            }).toList(),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("About system:",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: hexColor)),
                const SizedBox(
                  height: 10,
                ),
                buildSection(context,
                    "Our application aims to detect two types of insects harmful to plants , using a deep learning model , that the application uploads an image to the DL model cloudy and then the model checks the images uploaded to it and then returns the number of insects in each image then makes weekly, monthly and annual statistics for insects ."),
                const SizedBox(
                  height: 10,
                ),
                buildSection(context,
                    "One of the most important features of the application is that it gives a warning to the user when the number of insects reaches a certain limit, which the user sets to know if the plant is in danger and then intervenes to protect the plant ."),
                const SizedBox(
                  height: 10,
                ),
                buildSection(context,
                    "Ceratitis capitata (The Mediterranean fruit fly) is a species of insects that belongs to the legion of fruit flies of the order Shorthorn, in the order Diptera, an insect that destroys fruits, nuts and vegetables. It attacks more than 200 types of cultivated fruits and vegetables and it is considered a serious pest in Africa, Western Australia, Hawaii, Bermuda and Jamaica"),
                const SizedBox(
                  height: 10,
                ),
                buildSection(context,
                    "Bactrocera Zonata (The Peach Fruit Fly ) is native to South and Southeast Asia, where it attacks a wide variety of soft fruits, e.g. peach, guava and mango, and is commonly known as the Peach Fruit Fly")
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row buildSection(BuildContext context, String section) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 8),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(section,
              softWrap: true, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    );
  }
}
