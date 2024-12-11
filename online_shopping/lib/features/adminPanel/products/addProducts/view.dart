import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/core/styles/styles.dart';
import 'package:online_shopping/features/product/models/product_model.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _stockController =
      TextEditingController(); // New controller for stock
  final TextEditingController _descriptionController =
      TextEditingController(); // New controller for description

  String? _selectedCategory;
  int? _selectedCategoryId;

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
          'Add Products',
          style: AppTextStyles.font30blackTitle,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Product Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.h),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.h),
              TextField(
                controller: _stockController, // Add stock input field
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Stock',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.h),
              TextField(
                controller:
                    _descriptionController, // Add description input field
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.h),
              TextField(
                controller: _imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'Image URL',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.h),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
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
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final title = _titleController.text;
                      final price = _priceController.text;
                      final stock = _stockController.text; // Get stock value
                      final description =
                          _descriptionController.text; // Get description value
                      final imageUrl = _imageUrlController.text;
                      final categoryId = _selectedCategoryId;

                      if (title.isEmpty ||
                          price.isEmpty ||
                          stock.isEmpty || // Check if stock is empty
                          imageUrl.isEmpty ||
                          description
                              .isEmpty || // Check if description is empty
                          categoryId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please fill all fields')),
                        );
                        return;
                      }

                      try {
                        final product = ProductModel(
                          feedback: [],
                          productId: '', // Firestore will generate this
                          categoryId: categoryId.toString(),
                          title: title,
                          price: int.parse(price),
                          images: imageUrl,
                          stock: int.parse(stock), // Convert stock to int
                          description: description,
                        );

                        await addProduct(context, product);

                        _titleController.clear();
                        _priceController.clear();
                        _stockController.clear(); // Clear stock field
                        _descriptionController
                            .clear(); // Clear description field
                        _imageUrlController.clear();
                        setState(() {
                          _selectedCategory = null;
                        });
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: 120.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: CustomsColros.primaryColor,
                          borderRadius: BorderRadius.circular(55)),
                      child: Center(
                        child: Text(
                          'Submit',
                          style: AppTextStyles.font25blacSubTitle,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> addProduct(BuildContext context, ProductModel product) async {
  final scaffoldMessenger = ScaffoldMessenger.of(context);

  try {
    scaffoldMessenger.showSnackBar(
      const SnackBar(
        content: Text('Adding product...'),
        duration: Duration(seconds: 1),
      ),
    );

    // Generate a unique ID for the product
    final productWithId = product.copyWith(
      productId: _firestore.collection('Products').doc().id, // Match case
    );

    await _firestore
        .collection('Products') // Match case
        .doc(productWithId.productId)
        .set(productWithId.toJson());

    scaffoldMessenger.showSnackBar(
      const SnackBar(
        content: Text('Product added successfully!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  } catch (e) {
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text('Failed to add product: $e'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
