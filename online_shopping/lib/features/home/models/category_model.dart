import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.parentId = '',
    required this.isFeatured,
  });

  // Empty helper function
  static CategoryModel empty() =>
      CategoryModel(id: '', name: '', image: '', isFeatured: false);

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Name': name,
      'Image': image,
      'Parentid': parentId,
      'IsFeatured': isFeatured,
    };
  }

  // Map from JSON
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      name: json['Name'] ?? '',
      image: json['Image'] ?? '',
      parentId: json['Parentid'] ?? '',
      isFeatured: json['IsFeatured'] ?? false,
    );
  }

  // Map Firestore DocumentSnapshot to CategoryModel
  factory CategoryModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    if (doc.data() != null) {
      final data = doc.data()!;
      return CategoryModel(
        id: doc.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        parentId: data['Parentid'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
