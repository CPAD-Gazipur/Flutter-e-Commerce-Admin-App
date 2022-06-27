import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_e_commerce_backend/model/model.dart';
import 'package:get/get.dart';

class DatabaseService {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<Stream<List<Product>>> getProduct() async {
    return firebaseFirestore.collection('products').snapshots().map(
        (event) => event.docs.map((e) => Product.fromSnapshot(e)).toList());
  }

  Future<void> addProduct(Product product) {
    return firebaseFirestore.collection('products').add(product.toMap());
  }
}
