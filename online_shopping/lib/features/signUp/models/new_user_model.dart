import 'package:online_shopping/features/cart/models/cart_model.dart';

class NewUserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String userName;
  final String email;
  final CartModel cartModel; // Added cartModel as an attribute

  NewUserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.userName,
    required this.email,
    required this.cartModel, // Added cartModel to the constructor
  });

  // Convert Firestore document data (Map) to NewUserModel instance
// Assuming the cart is a list in Firestore
  factory NewUserModel.fromJson(Map<String, dynamic> json) {
    var cartData = json['cart'] is List
        ? json['cart'].first
        : json['cart']; // Get the first item from the list if it's a list
    return NewUserModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      cartModel: CartModel.fromJson(cartData ?? {}), // Parse the cart
    );
  }

  // Convert model to Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'userName': userName,
      'email': email,
      'cart': cartModel.toMap(), // Convert CartModel to map
    };
  }

  // Copy model with updated values
  NewUserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? userName,
    String? email,
    CartModel? cartModel, // Added cartModel as an optional parameter
  }) {
    return NewUserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      cartModel: cartModel ?? this.cartModel, // Updated to use cartModel
    );
  }
}
