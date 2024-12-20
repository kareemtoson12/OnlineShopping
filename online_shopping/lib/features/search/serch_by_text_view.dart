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

  // Function to search products in Firestore based on the search query
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      // Firestore query for products where the title matches the search query
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Products') // Ensure this collection name matches your Firestore setup
          .where('title', isGreaterThanOrEqualTo: query) // Start of the search range
          .where('title', isLessThanOrEqualTo: '$query\uf8ff') // End of the search range
          .get();

      // Map Firestore documents to a list of ProductModel objects
      return querySnapshot.docs
          .map((doc) => ProductModel.fromDocumentSnapshot(doc))
          .toList();
    } catch (e) {
      // Log the error for debugging
      print('Error searching products: $e');
      return []; // Return an empty list in case of error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 95.0, // Increased toolbar height for better UI
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 30, // Larger icon for better visibility
          ),
        ),
        centerTitle: true, // Center the title in the AppBar
        backgroundColor: CustomsColros.primaryColor, // Custom primary color
        title: Text(
          'Search Results',
          style: AppTextStyles.font30blackTitle, // Custom text style
        ),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: searchProducts(searchQuery), // Fetch products based on search query
        builder: (context, snapshot) {
          // Show a loading indicator while waiting for data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Show an error message if an error occurred
          else if (snapshot.hasError) {
            return const Center(child: Text('An error occurred.'));
          }
          // Show a message if no products were found
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found.'));
          }

          final products = snapshot.data!; // List of products fetched from Firestore
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: products.length, // Number of products to display
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  color: CustomsColros.offPrimaryColor, // Custom card color
                  elevation: 4, // Card shadow for better visibility
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5), // Margins around the card
                  child: ListTile(
                    leading: product.images.isNotEmpty
                        ? Image.network(
                            product.images, // Product image URL
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover, // Maintain aspect ratio
                            errorBuilder: (context, error, stackTrace) {
                              // Fallback in case of image loading error
                              return const Icon(Icons.broken_image);
                            },
                          )
                        : const Icon(Icons.image), // Default icon if no image
                    title: Text(product.title), // Product title
                    subtitle: Text(
                      '\$${product.price}', // Product price
                      style: AppTextStyles.font25blackRegular, // Custom style
                    ),
                    onTap: () {
                      // Get the current user's ID for user-specific actions
                      User? user = FirebaseAuth.instance.currentUser;
                      String userId = user?.uid ?? 'unknown'; // Fallback for unauthenticated users

                      // Navigate to the ProductDetails screen with product data
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetails(
                            data: {
                              'image': product.images, // Product image URL
                              'productId': product.productId, // Product ID
                              'name': product.title, // Product title
                              'price': product.price, // Product price
                              'stock': product.stock, // Product stock count
                              'description': product.description, // Product description
                              'userId': userId, // Current user ID
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
