import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_backend/controller/controller.dart';
import 'package:flutter_e_commerce_backend/model/model.dart';
import 'package:flutter_e_commerce_backend/services/database_service.dart';
import 'package:flutter_e_commerce_backend/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddNewProductScreen extends StatelessWidget {
  AddNewProductScreen({Key? key}) : super(key: key);

  final ProductController productController = Get.find();

  final StorageService storageService = StorageService();
  final DatabaseService databaseService = DatabaseService();
  var imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  child: InkWell(
                    onTap: () async {
                      ImagePicker picker = ImagePicker();
                      final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery,
                      );

                      if (image == null) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('No image was selected.')));
                      }
                      if (image != null) {
                        //do upload image
                        await storageService.uploadImage(image);
                        imageUrl = await storageService
                            .getImageDownloadUrl(image.name);

                        debugPrint(imageUrl);

                        productController.newProduct.update(
                          'imageUrl',
                          (_) => imageUrl,
                          ifAbsent: () => imageUrl,
                        );
                      }
                    },
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: Colors.black,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Add Product Image',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                imageUrl.isNotEmpty
                    ? Container(
                        height: 120,
                        width: 80,
                        padding: const EdgeInsets.all(10),
                        child: Stack(
                          children: [
                            Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              height: 120,
                              width: 80,
                            ),
                            Positioned(
                                right: -2,
                                top: -2,
                                child: InkWell(
                                  onTap: () {
                                    storageService
                                        .deleteImageFromFirebaseStorage(
                                            imageUrl);

                                    imageUrl = '';

                                    productController.newProduct.update(
                                      'imageUrl',
                                      (_) => imageUrl,
                                      ifAbsent: () => imageUrl,
                                    );
                                  },
                                  child: const Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  ),
                                ))
                          ],
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(height: 10),
                const Text(
                  'Product Information',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildTextFormField(
                  'Product ID',
                  'id',
                  productController,
                ),
                _buildTextFormField(
                  'Product Name',
                  'name',
                  productController,
                ),
                _buildTextFormField(
                  'Product Description',
                  'description',
                  productController,
                ),
                _buildTextFormField(
                  'Product Category',
                  'category',
                  productController,
                ),
                const SizedBox(height: 10),
                _buildSlider(
                  'Price',
                  'price',
                  productController,
                  productController.price,
                ),
                _buildSlider(
                  'Quantity',
                  'quantity',
                  productController,
                  productController.quantity,
                ),
                const SizedBox(height: 10),
                _buildCheckBox(
                  'Recommended',
                  'isRecommended',
                  productController,
                  productController.isRecommended,
                ),
                _buildCheckBox(
                  'Popular',
                  'isPopular',
                  productController,
                  productController.isPopular,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: () {
                      debugPrint(productController.newProduct.toString());

                      if (imageUrl.isEmpty) {
                        Get.snackbar(
                            'Warning', 'Please provide one product image',
                            backgroundColor: Colors.white,
                            colorText: Colors.black);
                      } else {
                        databaseService.addProduct(Product(
                          id: productController.newProduct['id'],
                          name: productController.newProduct['name'],
                          description:
                              productController.newProduct['description'],
                          imageUrl: productController.newProduct['imageUrl'],
                          category: productController.newProduct['category'],
                          isRecommended:
                              productController.newProduct['isRecommended'],
                          isPopular: productController.newProduct['isPopular'],
                          price: productController.newProduct['price'].toInt(),
                          quantity:
                              productController.newProduct['price'].toInt(),
                        ));

                        productController.newProduct.clear();
                      }
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildCheckBox(
    String title,
    String name,
    ProductController productController,
    bool? controllerValue,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 130,
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        Checkbox(
          value: (controllerValue == null) ? false : controllerValue,
          onChanged: (value) {
            productController.newProduct.update(
              name,
              (_) => value,
              ifAbsent: () => value,
            );
          },
          checkColor: Colors.black,
          activeColor: Colors.black12,
        ),
      ],
    );
  }

  Row _buildSlider(
    String title,
    String name,
    ProductController productController,
    double? controllerValue,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Slider(
            value: (controllerValue == null) ? 0 : controllerValue,
            onChanged: (value) {
              productController.newProduct.update(
                name,
                (_) => value,
                ifAbsent: () => value,
              );
            },
            min: 0,
            max: 50,
            divisions: 10,
            activeColor: Colors.black,
            inactiveColor: Colors.black12,
          ),
        ),
      ],
    );
  }

  Widget _buildTextFormField(
    String hintText,
    String name,
    ProductController productController,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
        ),
        onChanged: (value) {
          productController.newProduct.update(
            name,
            (_) => value,
            ifAbsent: () => value,
          );
        },
      ),
    );
  }
}
