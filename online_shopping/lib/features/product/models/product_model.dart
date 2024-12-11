import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackModel {
  final String userId;
  final int rating;
  final String comment;
  final DateTime timestamp;

  FeedbackModel({
    required this.userId,
    required this.rating,
    required this.comment,
    required this.timestamp,
  });

  // Factory method to create a FeedbackModel from Firestore Map
  factory FeedbackModel.fromMap(Map<String, dynamic> data) {
    return FeedbackModel(
      userId: data['userId'] ?? '',
      rating: data['rating'] ?? 0,
      comment: data['comment'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  // Method to convert FeedbackModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'rating': rating,
      'comment': comment,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}

class ProductModel {
  final String productId;
  final String categoryId;
  final String title;
  final int price;
  final String images;
  final int stock;
  final String description;
  final List<FeedbackModel> feedback; // New field for feedback

  ProductModel({
    required this.productId,
    required this.categoryId,
    required this.title,
    required this.price,
    required this.images,
    required this.stock,
    required this.description,
    required this.feedback,
  });

  // CopyWith method
  ProductModel copyWith({
    String? productId,
    String? categoryId,
    String? title,
    int? price,
    String? images,
    int? stock,
    String? description,
    List<FeedbackModel>? feedback,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      price: price ?? this.price,
      images: images ?? this.images,
      stock: stock ?? this.stock,
      description: description ?? this.description,
      feedback: feedback ?? this.feedback,
    );
  }

  // Factory method to create a ProductModel from Firestore DocumentSnapshot
  factory ProductModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return ProductModel(
      productId: doc.id,
      categoryId: data['categoryId'] ?? '',
      title: data['title'] ?? '',
      price: int.tryParse(data['price'].toString()) ?? 0,
      images: data['images'] ?? '',
      stock: int.tryParse(data['stock'].toString()) ?? 0,
      description: data['description'] ?? '',
      feedback: (data['feedback'] as List<dynamic>?)
              ?.map((e) => FeedbackModel.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  // Method to convert ProductModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'categoryId': categoryId,
      'title': title,
      'price': price,
      'images': images,
      'stock': stock,
      'description': description,
      'feedback': feedback.map((e) => e.toJson()).toList(),
    };
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
        feedback: [],
      );
}
