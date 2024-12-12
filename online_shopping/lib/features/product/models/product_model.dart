import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String productId;
  final String categoryId;
  final String title;
  final int price;
  final int quantity;
  final String images;
  final int stock;
  final String description;

  // Constructor to initialize all fields
  ProductModel({
    required this.productId,
    required this.categoryId,
    required this.title,
    required this.price,
    required this.quantity,
    required this.images,
    required this.stock,
    required this.description,
  });

  // CopyWith method allows for easy modification of properties
  ProductModel copyWith({
    String? productId,
    String? categoryId,
    String? title,
    int? price,
    String? images,
    int? quantity,
    int? stock,
    String? description,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      images: images ?? this.images,
      stock: stock ?? this.stock,
      description: description ?? this.description,
    );
  }

  // Getter to return productId
  String get productIdString {
    return productId;
  }

  // Factory method to create a ProductModel from Firestore DocumentSnapshot
  factory ProductModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    if (doc.data() != null) {
      final data = doc.data()!;
      return ProductModel(
        productId: doc.id, // Firestore document ID
        categoryId: data['categoryId'] ?? '',
        title: data['title'] ?? '',
        price: int.tryParse(data['price'].toString()) ?? 0,
        quantity:
            int.tryParse(data['quantity'].toString()) ?? 0, // Handle quantity
        images: data['images'] ?? '',
        stock: int.tryParse(data['stock'].toString()) ?? 0,
        description: data['description'] ?? '',
      );
    } else {
      return ProductModel.empty();
    }
  }

  // Empty helper function to create an empty ProductModel
  static ProductModel empty() => ProductModel(
        productId: '',
        categoryId: '',
        title: '',
        price: 0,
        quantity: 0,
        images: '',
        stock: 0,
        description: '',
      );

  // Method to convert a ProductModel to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'categoryId': categoryId,
      'title': title,
      'price': price,
      'quantity': quantity, // Added quantity field to JSON
      'images': images,
      'stock': stock,
      'description': description,
    };
  }
}
