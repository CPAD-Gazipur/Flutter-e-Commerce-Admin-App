import 'dart:convert';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  double price;
  int quantity;
  final String category;
  final bool isRecommended;
  final bool isPopular;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.price = 0,
    this.quantity = 0,
    required this.category,
    required this.isRecommended,
    required this.isPopular,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        price,
        quantity,
        category,
        isRecommended,
        isPopular,
      ];

  Product copyWith(
      {int? id,
      String? name,
      String? description,
      String? imageUrl,
      double? price,
      int? quantity,
      String? category,
      bool? isRecommended,
      bool? isPopular}) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      isRecommended: isRecommended ?? this.isRecommended,
      isPopular: isPopular ?? this.isPopular,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
      'category': category,
      'isRecommended': isRecommended,
      'isPopular': isPopular,
    };
  }

  factory Product.toMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      price: map['price'],
      quantity: map['quantity'],
      category: map['category'],
      isRecommended: map['isRecommended'],
      isPopular: map['isPopular'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.toMap(json.decode(source));

  @override
  bool get stringify => true;

  static List<Product> products = [
    Product(
      id: 1,
      name: 'Product 1',
      description: 'Description 1',
      imageUrl: 'https://picsum.photos/id/1/200/300',
      price: 10,
      quantity: 5,
      category: 'Category 1',
      isRecommended: true,
      isPopular: true,
    ),
    Product(
      id: 2,
      name: 'Product 2',
      description: 'Description 2',
      imageUrl: 'https://picsum.photos/id/2/200/300',
      price: 20,
      quantity: 3,
      category: 'Category 2',
      isRecommended: false,
      isPopular: false,
    ),
    Product(
      id: 3,
      name: 'Product 3',
      description: 'Description 3',
      imageUrl: 'https://picsum.photos/id/3/200/300',
      price: 30,
      quantity: 9,
      category: 'Category 3',
      isRecommended: true,
      isPopular: false,
    ),
    Product(
      id: 4,
      name: 'Product 4',
      description: 'Description 4',
      imageUrl: 'https://picsum.photos/id/4/200/300',
      price: 40,
      quantity: 7,
      category: 'Category 4',
      isRecommended: false,
      isPopular: true,
    ),
  ];
}
