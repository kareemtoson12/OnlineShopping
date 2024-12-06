import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String productId;
  final String categoryId;
  final String title;
  final int price;
  final String images;
  final int stock; // New field for stock
  final String description; // New field for description

  // Constructor to initialize all fields
  ProductModel({
    required this.productId,
    required this.categoryId,
    required this.title,
    required this.price,
    required this.images,
    required this.stock,
    required this.description,
  });

  // CopyWith method
  ProductModel copyWith({
    String? productId,
    String? categoryId,
    String? title,
    int? price,
    String? images,
    int? stock, // Optional parameter for stock
    String? description, // Optional parameter for description
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      price: price ?? this.price,
      images: images ?? this.images,
      stock: stock ?? this.stock,
      description: description ?? this.description,
    );
  }

  // Factory method to create a ProductModel from Firestore DocumentSnapshot
  factory ProductModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    if (doc.data() != null) {
      final data = doc.data()!;
      return ProductModel(
        productId: doc.id, // Firestore document ID
        categoryId: data['categoryId'] ?? '', // Match Firestore field names
        title: data['title'] ?? '',
        price: int.tryParse(data['price'].toString()) ??
            0, // Convert to int safely
        images: data['images'] ?? '',
        stock: int.tryParse(data['stock'].toString()) ??
            0, // Convert to int safely
        description:
            data['description'] ?? '', // Set description or empty string
      );
    } else {
      // Return an empty ProductModel if data is null
      return ProductModel.empty();
    }
  }

  // Empty helper function
  static ProductModel empty() => ProductModel(
        productId: '',
        categoryId: '',
        title: '',
        price: 0,
        images: '',
        stock: 0,
        description: '',
      );

  // Method to convert a ProductModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'categoryId': categoryId,
      'title': title,
      'price': price,
      'images': images,
      'stock': stock, // Add stock to JSON
      'description': description, // Add description to JSON
    };
  }
}
