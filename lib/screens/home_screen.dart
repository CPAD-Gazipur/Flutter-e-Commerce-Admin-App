import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_backend/controller/controller.dart';
import 'package:get/get.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import '../model/model.dart';
import 'screens.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final OrderStatsController orderStatsController =
      Get.put(OrderStatsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter e-Commerce Admin'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder(
            future: orderStatsController.stats.value,
            builder: (BuildContext context,
                AsyncSnapshot<List<OrderStats>> snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: 250,
                  padding: const EdgeInsets.all(10),
                  child: OrderStatsChart(
                    orderStats: snapshot.data!,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
            },
          ),
          const Center(
            child: Text(
              'Order Stats',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 150,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () {
                Get.to(() => ProductScreen());
              },
              child: const Card(
                child: Center(
                  child: Text('Go To Products'),
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () {
                Get.to(() => OrderScreen());
              },
              child: const Card(
                child: Center(
                  child: Text('Go To Orders'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderStatsChart extends StatelessWidget {
  final List<OrderStats> orderStats;
  const OrderStatsChart({Key? key, required this.orderStats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<OrderStats, String>> series = [
      charts.Series(
        id: 'orders',
        data: orderStats,
        domainFn: (series, _) => DateFormat('MMM dd, yyyy')
            .format(series.dateTime), //series.index.toString(),
        measureFn: (series, _) => series.orders,
        colorFn: (series, _) => series.barColor!,
      )
    ];
    return charts.BarChart(
      series,
      animate: true,
    );
  }
}
