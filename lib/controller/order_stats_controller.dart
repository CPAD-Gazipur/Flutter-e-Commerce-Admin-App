import 'package:flutter_e_commerce_backend/model/model.dart';
import 'package:flutter_e_commerce_backend/services/database_service.dart';
import 'package:get/get.dart';

class OrderStatsController extends GetxController {
  final DatabaseService databaseService = DatabaseService();

  var stats = Future.value(<OrderStats>[]).obs;

  @override
  void onInit() {
    stats.value = databaseService.getOrderStats();
    super.onInit();
  }
}
