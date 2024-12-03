class NewUserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String userName;
  final String email;

  NewUserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.userName,
    required this.email,
  });

// Convert Firestore document data (Map) to NewUserModel instance
  factory NewUserModel.fromJson(Map<String, dynamic> json) {
    return NewUserModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
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
  }) {
    return NewUserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userName: userName ?? this.userName,
      email: email ?? this.email,
    );
  }
}
