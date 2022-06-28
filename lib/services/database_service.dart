import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_backend/model/model.dart';
import 'package:get/get.dart';

class DatabaseService {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<Product>> getProducts() {
    return firebaseFirestore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

  Future<void> addProduct(Product product) {
    return firebaseFirestore.collection('products').add(product.toMap());
  }

  Future<void> updateField(
    Product product,
    String field,
    dynamic newValue,
  ) {
    return firebaseFirestore
        .collection('products')
        .where('id', isEqualTo: product.id)
        .get()
        .then((querySnapshot) => {
              if (querySnapshot.docs.isNotEmpty)
                {
                  querySnapshot.docs.first.reference.update({field: newValue})
                }
              else
                {debugPrint('Error: ${product.name} not found.')}
            });
  }

  Stream<List<Order>> getOrders() {
    return firebaseFirestore.collection('orders').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Order.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Order>> getPendingOrders() {
    return firebaseFirestore
        .collection('orders')
        .where('isDelivered', isEqualTo: false)
        .where('isCancelled', isEqualTo: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Order.fromSnapshot(doc)).toList();
    });
  }

  Future<void> updateOrder(Order order, String field, bool newValue) {
    return firebaseFirestore
        .collection('orders')
        .where('id', isEqualTo: order.id)
        .get()
        .then((value) => value.docs.first.reference.update({field: newValue}));
  }
}
