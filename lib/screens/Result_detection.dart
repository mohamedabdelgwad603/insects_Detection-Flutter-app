import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/bloc/cubit.dart';
import 'package:gp/bloc/states.dart';

class DetectionResult extends StatelessWidget {
  const DetectionResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GpCubit, gpStates>(
      listener: ((context, state) {}),
      builder: (context, state) {
        var cubit = BlocProvider.of<GpCubit>(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text("Detection Results"),
          ),
          body: cubit.image == null
              ? Center(
                  child: Text(
                    "Not found image for detect",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                )
              : ConditionalBuilder(
                  condition: state is GpSuccessResposeState,
                  builder: (context) => Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "The numbers of Cc insect :  ${cubit.numcc}",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "The numbers of Bz fly insect :  ${cubit.numBz}",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                  fallback: (context) => Center(
                      child: CircularProgressIndicator(
                    color: Colors.grey,
                  )),
                ),
        );
      },
    );
  }
}
