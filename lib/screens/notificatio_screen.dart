import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/bloc/cubit.dart';
import 'package:gp/bloc/states.dart';
import 'package:gp/components/components.dart';
import 'package:gp/components/constants.dart';

class NotificationsScreen extends StatelessWidget {
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GpCubit, gpStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var notifications =
            BlocProvider.of<GpCubit>(context).notifications.reversed.toList();
        return Scaffold(
          backgroundColor: hexColor,
          appBar: AppBar(
            title: Text(
              "Notification",
              style: TextStyle(color: Colors.orange),
            ),
          ),
          body: Container(
              //padding: EdgeInsets.only(left: 10),
              color: Colors.white,
              margin: EdgeInsets.all(10),
              width: double.infinity,
              height: 300,
              child: Scrollbar(
                isAlwaysShown: true,
                showTrackOnHover: true,
                thickness: 10,
                controller: _scrollController,
                child: ListView.builder(
                    padding: EdgeInsets.only(right: 10),
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: hexColor,
                          child: Row(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(70),
                              child: Image(
                                image: NetworkImage(
                                    notifications[index].img.toString()),
                                width: 80,
                                height: 80,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Warning!!',
                                      style: TextStyle(color: Colors.orange)),
                                  Text(
                                      'Num of cc ${notifications[index].data!.ccN}',
                                      style: TextStyle(color: Colors.orange)),
                                  Text(
                                      'Numb of bz ${notifications[index].data!.bzN}',
                                      style: TextStyle(color: Colors.orange)),
                                  Text(
                                    formatDate(
                                        notifications[index].date.toString()),
                                    style: TextStyle(
                                        color: Colors.grey[500], fontSize: 18),
                                  )
                                ],
                              ),
                            )
                          ]),
                        ),
                    itemCount: notifications.length),
              )),
        );
      },
    );
  }
}
