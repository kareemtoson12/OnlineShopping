import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/features/home/cubit/home_cubit.dart';
import 'package:online_shopping/features/home/models/product_model.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeProductsiesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeProductsSuccess) {
          final products = state.products;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: products[index]);
            },
          );
        } else if (state is HomeProductsError) {
          return Center(
            child: Text(
              'Error: ${state.errorMessage}',
              style: TextStyle(color: Colors.red),
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
        subtitle: Text('\$${product.price}'),
        onTap: () {
          // Add navigation or actions if needed
        },
      ),
    );
  }
}
