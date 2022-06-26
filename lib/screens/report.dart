import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/bloc/cubit.dart';
import 'package:gp/bloc/states.dart';

import 'package:intl/intl.dart';

import '../components/components.dart';

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GpCubit, gpStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<GpCubit>(context);
        return ListView(children: [
          const Center(
              child: Text(
            'insects-Chart',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          )),
          DataTable(
            dataRowHeight: 70,
            columns: [
              DataColumn(
                  label: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                    const Image(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/cc.jpg'),
                      width: 70,
                      height: 70,
                    ),
                    Container(
                      color: Colors.black.withOpacity(.6),
                      child: const Text('cc',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    )
                  ])),
              DataColumn(
                  label: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                    const Image(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/bz.jpg'),
                      width: 70,
                      height: 70,
                    ),
                    Container(
                      color: Colors.black.withOpacity(.6),
                      child: const Text('bz',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    )
                  ])),
              const DataColumn(
                  label: Text('Date',
                      style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold))),
            ],
            rows: cubit.insectsModel != null
                ? cubit.insectsModel!.data.reversed.map((item) {
                    var dateFormat = formatDate(item.date.toString());

                    /*    DateFormat.yMMMd()
                        .add_jms()
                        .format(DateTime.parse(item.date.toString()));*/

                    return DataRow(cells: [
                      DataCell(Text(item.data != null
                          ? (item.data!.ccN != null ? '${item.data!.ccN}' : '0')
                          : '0')),
                      DataCell(Text(item.data != null
                          ? (item.data!.bzN != null ? '${item.data!.bzN}' : '0')
                          : '0')),
                      DataCell(Text(
                        '${dateFormat}',
                        maxLines: 4,
                      )),
                    ]);
                  }).toList()
                : [],
          ),
        ]);
      },
    );
  }
}
