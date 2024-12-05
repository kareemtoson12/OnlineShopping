import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/core/styles/styles.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final TextEditingController _productIdController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String? _selectedCategory;
  int? _selectedCategoryId;

  // Category Map
  final Map<String, int> _categoryMap = {
    'electronics': 1,
    'clothes': 2,
    'sports': 3,
    'shoes': 4,
  };

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
          'Edit Products',
          style: AppTextStyles.font30blackTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
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
              const Text(
                'Edit Title:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'New Title',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Edit Price:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'New Price',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Select New Category:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Category',
                ),
                items: _categoryMap.keys
                    .map((category) => DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                    _selectedCategoryId = _categoryMap[value!];
                  });
                },
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final productId = _productIdController.text;
                    final newTitle = _titleController.text;
                    final newPrice = _priceController.text;
                    final newCategoryId = _selectedCategoryId;

                    if (productId.isEmpty ||
                        newTitle.isEmpty ||
                        newPrice.isEmpty ||
                        newCategoryId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('All fields must be filled'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // Call the edit function
                    await editProduct(
                      productId: productId,
                      newTitle: newTitle,
                      newPrice: int.parse(newPrice),
                      newCategoryId: newCategoryId,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Product updated successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );

                    // Clear input fields
                    _productIdController.clear();
                    _titleController.clear();
                    _priceController.clear();
                    setState(() {
                      _selectedCategory = null;
                      _selectedCategoryId = null;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: CustomsColros.primaryColor),
                  child: Text(
                    'Update Product',
                    style: AppTextStyles.font25blod,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> editProduct({
  required String productId,
  required String newTitle,
  required int newPrice,
  required int newCategoryId,
}) async {
  try {
    await FirebaseFirestore.instance
        .collection('Products')
        .doc(productId)
        .update({
      'title': newTitle,
      'price': newPrice,
      'categoryId': newCategoryId.toString(),
    });
    print('Product updated successfully!');
  } catch (e) {
    print('Failed to update product: $e');
  }
}
