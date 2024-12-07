import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/features/product/ProductDetails.dart';
import 'package:online_shopping/features/product/models/product_model.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String category;

  const CategoryProductsScreen({Key? key, required this.category})
      : super(key: key);

  @override
  _CategoryProductsScreenState createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  bool isLoading = true;
  List<ProductModel> products = [];

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  final Map<String, String> _categoryMap = {
    'electronics': '1',
    'clothes': '2',
    'sports': '3',
    'shoes': '4',
  };

  Future<void> fetchCategoryProducts() async {
    try {
      // Get the category ID using the map
      String? categoryId = _categoryMap[widget.category.toLowerCase()];

      if (categoryId == null) {
        throw 'Invalid category: ${widget.category}';
      }

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('Products')
              .where('categoryId', isEqualTo: categoryId)
              .get();

      setState(() {
        products = querySnapshot.docs
            .map((doc) => ProductModel.fromDocumentSnapshot(doc))
            .toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load products: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : products.isEmpty
              ? const Center(
                  child: Text('No products found in this category'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: product.images.isNotEmpty
                            ? Image.network(
                                product.images,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              )
                            : const Icon(Icons.image),
                        title: Text(product.title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('\$${product.price}'),
                            Text('Stock: ${product.stock}'),
                          ],
                        ),
                        trailing: const Icon(Icons.arrow_forward),
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                  data: {
                                    'image': product.images,
                                    'name': product.title,
                                    'price': product.price,
                                    'stock': product.stock,
                                    'description': product.description,
                                  },
                                ),
                              ));
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
