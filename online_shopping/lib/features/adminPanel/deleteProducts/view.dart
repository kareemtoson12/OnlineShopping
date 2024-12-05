import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteProduct extends StatelessWidget {
  const DeleteProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () {} // _deleteProduct(context),
        );
  }

  /*  Future<void> _deleteProduct(BuildContext context, String productId) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Deleting product...'),
          duration: Duration(seconds: 1),
        ),
      );

      // Delete the product from Firestore
      await FirebaseFirestore.instance
          .collection('Products')
          .doc(productId)
          .delete();

      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Product deleted successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('Failed to delete product: $e'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  } */
}
