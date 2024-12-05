import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/core/styles/styles.dart';

class DeleteProductScreen extends StatefulWidget {
  const DeleteProductScreen({super.key});

  @override
  State<DeleteProductScreen> createState() => _DeleteProductScreenState();
}

class _DeleteProductScreenState extends State<DeleteProductScreen> {
  final TextEditingController _productIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 95.0.dg,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: CustomsColros.primaryColor,
        title: Text(
          'delete Products',
          style: AppTextStyles.font30blackTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter Product ID:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _productIdController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Product ID',
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final productId = _productIdController.text;

                  if (productId.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Product ID cannot be empty'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  // Call the delete function
                  await deleteProduct(productId);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Product deleted successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );

                  // Clear the input field
                  _productIdController.clear();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: CustomsColros.primaryColor),
                child: Text(
                  'Delete Product',
                  style: AppTextStyles.font25blacSubTitle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
Future<void> deleteProduct(String productId) async {
  try {
    await FirebaseFirestore.instance
        .collection('Products')
        .doc(productId)
        .delete();
    print('Product deleted successfully!');
  } catch (e) {
    print('Failed to delete product: $e');
  }
}
