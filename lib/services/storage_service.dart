import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<void> uploadImage(XFile image) async {
    await firebaseStorage
        .ref('product_image/${image.name}')
        .putFile(File(image.path));
  }

  Future<String> getImageDownloadUrl(String imageName) async {
    String imageURL =
        await firebaseStorage.ref('product_image/$imageName').getDownloadURL();
    return imageURL;
  }

  Future<void> deleteImageFromFirebaseStorage(String imageUrl) async {
    if (imageUrl.isNotEmpty) {
      await FirebaseStorage.instance.refFromURL(imageUrl).delete();
    }
  }
}
