import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/core/styles/styles.dart';
import 'package:online_shopping/features/home/cubit/home_cubit.dart';
import 'package:online_shopping/features/product/models/product_model.dart';
import 'package:online_shopping/features/product/ProductDetails.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeCategoriesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeCategoriesSuccess) {
          final products = state.products;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: products[index]);
            },
          );
        } else if (state is HomeCategoriesError) {
          return Center(
            child: Text(
              'Error: ${state.errorMessage}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return const Center(child: Text('Something went wrong.'));
      },
    ));
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CustomsColros.offPrimaryColor,
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: product.images.isNotEmpty
            ? Image.network(
                product.images,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
            : const Icon(Icons.image_not_supported),
        title: Text(product.title),
        subtitle: Text(
          '\$${product.price}',
          style: AppTextStyles.font25blackRegular,
        ),
        onTap: () {
          User? user = FirebaseAuth.instance.currentUser;
          String userId =
              user?.uid ?? 'unknown'; // Fallback if user is not logged in
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
                  'useid': userId,
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
