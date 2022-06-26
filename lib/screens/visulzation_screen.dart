import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../bloc/cubit.dart';
import '../bloc/states.dart';

class VisualizationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GpCubit, gpStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BlocProvider.of<GpCubit>(context);
          return Center(
              child: Container(
                  child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      // Chart title
                      title: ChartTitle(text: ' weekly insects data analysis'),
                      // Enable legend
                      legend: Legend(isVisible: true),
                      // Enable tooltip
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <LineSeries<SalesData, String>>[
                LineSeries<SalesData, String>(
                    name: 'ceratitis capitata',
                    dataSource: cubit.insectsModel != null
                        ? cubit.insectsModel!.data.map((item) {
                            return SalesData(
                                DateFormat.MMMMd().add_jms().format(
                                    DateTime.parse(item.date.toString())),
                                double.parse(item.data!.ccN));
                          }).toList()
                        : [],
                    xValueMapper: (SalesData sales, _) => sales.date,
                    yValueMapper: (SalesData sales, _) => sales.num,
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true)),
                LineSeries<SalesData, String>(
                    name: 'bactrocera zonata',
                    dataSource: cubit.insectsModel != null
                        ? cubit.insectsModel!.data.map((item) {
                            return SalesData(
                                DateFormat.MMMMd().add_jms().format(
                                    DateTime.parse(item.date.toString())),
                                double.parse(item.data!.bzN));
                          }).toList()
                        : [],
                    xValueMapper: (SalesData sales, _) => sales.date,
                    yValueMapper: (SalesData sales, _) => sales.num,
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true)),
              ])));
        });
  }
}

class SalesData {
  SalesData(this.date, this.num);
  final String date;
  final double num;
}
