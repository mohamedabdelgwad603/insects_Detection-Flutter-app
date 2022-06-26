import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/bloc/cubit.dart';
import 'package:gp/bloc/states.dart';
import 'package:gp/components/constants.dart';

import '../components/components.dart';

class SettingsScreen extends StatelessWidget {
  List<int> ItemsDropDown = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GpCubit, gpStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<GpCubit>(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("settings"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                    "Choose the number of ceratitis capitata insect that after exceeding it will send you a notification : "),
                buildDropDown(ItemsDropDown, cubit.CsNumDrop, "choose number ",
                    (NewVal) {
                  cubit.changeCcValue(NewVal);
                }),
                SizedBox(
                  height: 40,
                ),
                Text(
                    "Choose the number of bactrocera zonata insect that after exceeding it will send you a notification : "),
                buildDropDown(ItemsDropDown, cubit.BzNumDrop, "choose number ",
                    (NewVal) {
                  cubit.changeBzValue(NewVal);
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
