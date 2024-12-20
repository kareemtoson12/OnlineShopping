import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/features/product/ProductDetails.dart';
import 'package:online_shopping/features/product/models/product_model.dart';

// Screen to display products based on a selected category
class CategoryProductsScreen extends StatefulWidget {
  final String category;

  // Constructor to initialize the category parameter
  const CategoryProductsScreen({Key? key, required this.category})
      : super(key: key);

  @override
  _CategoryProductsScreenState createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  bool isLoading = true; // Flag to indicate if data is being loaded
  List<ProductModel> products = []; // List to store fetched products

  // Map to link category names to their respective IDs in the database
  final Map<String, String> _categoryMap = {
    'electronics': '1',
    'clothes': '2',
    'sports': '3',
    'shoes': '4',
  };

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts(); // Fetch products when the screen initializes
  }

  // Method to fetch products from Firestore for the selected category
  Future<void> fetchCategoryProducts() async {
    try {
      // Get the category ID from the map
      String? categoryId = _categoryMap[widget.category.toLowerCase()];

      if (categoryId == null) {
        throw 'Invalid category: ${widget.category}'; // Throw error if category is invalid
      }

      // Query Firestore to fetch products for the specified category ID
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('Products')
              .where('categoryId', isEqualTo: categoryId)
              .get();

      // Update the state with fetched products and stop loading
      setState(() {
        products = querySnapshot.docs
            .map((doc) => ProductModel.fromDocumentSnapshot(doc)) // Convert Firestore documents to ProductModel instances
            .toList();
        isLoading = false;
      });
    } catch (e) {
      // Handle errors during product fetching
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load products: $e')), // Show error message
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category), // Display the selected category as title
        centerTitle: true, // Center the AppBar title
        backgroundColor: Colors.deepPurple, // Set the AppBar background color
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Show a loading spinner if data is being fetched
          : products.isEmpty
              ? const Center(
                  child: Text('No products found in this category'), // Show message if no products are found
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(10), // Add padding to the ListView
                  itemCount: products.length, // Number of items in the list
                  itemBuilder: (context, index) {
                    final product = products[index]; // Get the product at the current index
                    return Card(
                      elevation: 4, // Add elevation for shadow effect
                      margin: const EdgeInsets.symmetric(vertical: 8), // Add vertical margin between cards
                      child: ListTile(
                        leading: product.images.isNotEmpty
                            ? Image.network(
                                product.images, // Display product image
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover, // Maintain aspect ratio
                              )
                            : const Icon(Icons.image), // Show placeholder icon if no image is available
                        title: Text(product.title), // Display product title
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('\$${product.price}'), // Display product price
                            Text('Stock: ${product.stock}'), // Display product stock availability
                          ],
                        ),
                        trailing: const Icon(Icons.arrow_forward), // Arrow icon to indicate navigation
                        onTap: () {
                          // Navigate to the ProductDetails screen when tapped
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                  data: {
                                    'image': product.images, // Pass product image
                                    'name': product.title, // Pass product name
                                    'price': product.price, // Pass product price
                                    'stock': product.stock, // Pass product stock
                                    'description': product.description, // Pass product description
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
