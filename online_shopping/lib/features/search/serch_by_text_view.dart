import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/core/styles/styles.dart';
import 'package:online_shopping/features/product/ProductDetails.dart';
import 'package:online_shopping/features/product/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SearchResultsScreen extends StatelessWidget {
  final String searchQuery;

  const SearchResultsScreen({Key? key, required this.searchQuery})
      : super(key: key);

  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Products') // Your Firestore collection name
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      // Map Firestore documents to ProductModel
      return querySnapshot.docs
          .map((doc) => ProductModel.fromDocumentSnapshot(doc))
          .toList();
    } catch (e) {
      print('Error searching products: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 95.0,
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
          'Search Results',
          style: AppTextStyles.font30blackTitle,
        ),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: searchProducts(searchQuery),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('An error occurred.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found.'));
          }

          final products = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  color: CustomsColros.offPrimaryColor,
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: product.images.isNotEmpty
                        ? Image.network(
                            product.images,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.broken_image);
                            },
                          )
                        : const Icon(Icons.image),
                    title: Text(product.title),
                    subtitle: Text(
                      '\$${product.price}',
                      style: AppTextStyles.font25blackRegular,
                    ),
                    onTap: () {
                      User? user = FirebaseAuth.instance.currentUser;
                      String userId = user?.uid ??
                          'unknown'; // Fallback if user is not logged in
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetails(
                            data: {
                              'image': product.images,
                              'productId': product.productId,
                              'name': product.title,
                              'price': product.price,
                              'stock': product.stock,
                              'description': product.description,
                              'userId': userId,
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
