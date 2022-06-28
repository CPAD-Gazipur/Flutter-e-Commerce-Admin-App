import 'package:flutter_e_commerce_backend/services/database_service.dart';
import 'package:get/get.dart';

import '../model/model.dart';

class OrderController extends GetxController {
  final DatabaseService databaseService = DatabaseService();

  var orders = <Order>[].obs;
  var pendingOrders = <Order>[].obs;

  @override
  void onInit() {
    orders.bindStream(databaseService.getOrders());
    pendingOrders.bindStream(databaseService.getPendingOrders());
    super.onInit();
  }

  void updateOrder(Order order, String field, bool value) {
    databaseService.updateOrder(order, field, value);
  }
}
