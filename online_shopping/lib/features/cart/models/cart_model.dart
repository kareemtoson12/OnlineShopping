class CartModel {
  String title;
  int price;
  String image;
  int quantity;

  CartModel({
    required this.title,
    required this.price,
    required this.image,
    required this.quantity,
  });

  // Create an empty CartModel instance
  factory CartModel.empty() {
    return CartModel(
      title: '',
      price: 0,
      image: '',
      quantity: 0,
    );
  }

  // Convert a JSON object to a CartModel instance
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      title: json['title'] ?? '',
      price: json['price'] ?? 0,
      image: json['image'] ?? '',
      quantity: json['quantity'] ?? 0,
    );
  }

  // Convert the CartModel instance to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }
}
