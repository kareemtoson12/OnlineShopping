import 'package:cloud_firestore/cloud_firestore.dart';

class Transaction {
  final String transactionId;
  final String userId;
  final int amount;
  final Timestamp timestamp;
  final String details;

  // Constructor
  Transaction({
    required this.transactionId,
    required this.userId,
    required this.amount,
    required this.timestamp,
    required this.details,
  });

  // Factory method to create a Transaction object from Firestore data
  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      transactionId: map['transactionId'] ?? '',
      userId: map['userId'] ?? '',
      amount: map['amount'] ?? 0,
      timestamp: map['timestamp'] ?? Timestamp.now(),
      details: map['details'] ?? '',
    );
  }

  // Method to convert Transaction object to a Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {
      'transactionId': transactionId,
      'userId': userId,
      'amount': amount,
      'timestamp': timestamp,
      'details': details,
    };
  }
}
