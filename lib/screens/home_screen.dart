import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
