import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/core/routing/app_routes.dart';
import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/core/styles/styles.dart';
import 'package:online_shopping/features/home/models/category_model.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _parentIdController = TextEditingController();
  bool _isFeatured = false;

  void _submitCategory() async {
    final id = _idController.text.trim();
    final name = _nameController.text.trim();
    final image = _imageController.text.trim();
    final parentId = _parentIdController.text.trim();
    final isFeatured = _isFeatured;

    if (id.isEmpty || name.isEmpty || image.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ID, Name, and Image URL are required!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final newCategory = CategoryModel(
      id: id, // Use the entered ID
      name: name,
      image: image,
      parentId: parentId,
      isFeatured: isFeatured,
    );

    try {
      await addCategory(newCategory);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Category added successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      _idController.clear();
      _nameController.clear();
      _imageController.clear();
      _parentIdController.clear();
      setState(() {
        _isFeatured = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 95.0.dg,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.adminfunctionality);
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
          'Add Categories',
          style: AppTextStyles.font30blackTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Category ID',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _idController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter category ID',
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Category Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter category name',
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Image URL',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _imageController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter image URL',
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Parent ID (Optional)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _parentIdController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter parent category ID',
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    'Is Featured:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Switch(
                    value: _isFeatured,
                    onChanged: (value) {
                      setState(() {
                        _isFeatured = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: _submitCategory,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomsColros.primaryColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 32.0),
                  ),
                  child: Text(
                    'Add Category',
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

Future<void> addCategory(CategoryModel category) async {
  try {
    final categoryRef = _firestore.collection('categories').doc(category.id);

    await categoryRef.set(category.toJson());
    print('Category added successfully!');
  } catch (e) {
    print('Failed to add category: $e');
  }
}
