import 'package:cloud_firestore/cloud_firestore.dart';

// Class to represent a financial transaction
class Transaction {
  // Unique ID for the transaction
  final String transactionId;

  // User ID associated with the transaction
  final String userId;

  // Amount involved in the transaction
  final int amount;

  // Timestamp indicating when the transaction occurred
  final Timestamp timestamp;

  // Additional details about the transaction
  final String details;

  // Constructor to initialize the Transaction object
  Transaction({
    required this.transactionId, // Transaction ID is required
    required this.userId,        // User ID is required
    required this.amount,        // Amount is required
    required this.timestamp,     // Timestamp is required
    required this.details,       // Details are required
  });

  // Factory method to create a Transaction object from a Firestore document map
  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      // Map values to the corresponding fields or provide default values if keys are missing
      transactionId: map['transactionId'] ?? '',       // Default to an empty string if null
      userId: map['userId'] ?? '',                     // Default to an empty string if null
      amount: map['amount'] ?? 0,                      // Default to 0 if null
      timestamp: map['timestamp'] ?? Timestamp.now(),  // Default to current time if null
      details: map['details'] ?? '',                   // Default to an empty string if null
    );
  }

  // Method to convert a Transaction object to a Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {
      'transactionId': transactionId,  // Include transaction ID
      'userId': userId,                // Include user ID
      'amount': amount,                // Include transaction amount
      'timestamp': timestamp,          // Include timestamp
      'details': details,              // Include transaction details
    };
  }
}
