import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/core/styles/styles.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [];
  bool isLoading = true;
  StreamSubscription<DocumentSnapshot>? cartSubscription;

  @override
  void initState() {
    super.initState();
    subscribeToCartUpdates();
  }

  void subscribeToCartUpdates() {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      cartSubscription = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots()
          .listen((docSnapshot) {
        if (docSnapshot.exists && docSnapshot.data()?['cart'] != null) {
          setState(() {
            cartItems =
                List<Map<String, dynamic>>.from(docSnapshot.data()?['cart']);
            isLoading = false;
          });
        } else {
          setState(() {
            cartItems = [];
            isLoading = false;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    cartSubscription?.cancel(); // Cancel the subscription to avoid memory leaks
    super.dispose();
  }

  Future<void> deleteItemFromCart(int index) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw 'No user is logged in.';
      }

      final cartRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      final cartData = cartItems.toList();

      // Remove the item at the given index
      cartData.removeAt(index);

      // Update Firestore
      await cartRef.update({'cart': cartData});

      setState(() {
        cartItems = cartData;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item removed from cart')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to remove item: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = cartItems.fold(
      0.0,
      (sum, item) => sum + (item['price'] * item['quantity']),
    );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0.dg,
        centerTitle: true,
        backgroundColor: CustomsColros.primaryColor,
        title: Text(
          'cart',
          style: AppTextStyles.font30blackTitle,
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : cartItems.isEmpty
              ? const Center(child: Text('Your cart is empty.'))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: item['image'] != null
                                        ? Image.network(
                                            item['image'],
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Icon(
                                                  Icons.broken_image,
                                                  size: 40);
                                            },
                                          )
                                        : const Icon(Icons.image, size: 50),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 5),
                                        Text(item['name'] ?? 'Unnamed Product',
                                            style:
                                                AppTextStyles.fontForshowCart),
                                        const SizedBox(height: 10),
                                        Text(
                                            '\$${item['price']?.toStringAsFixed(2) ?? '0.00'}',
                                            style: AppTextStyles
                                                .fontForSmallLabel),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          setState(() {
                                            if (item["quantity"] > 0) {
                                              item["quantity"]--;
                                            }
                                          });
                                        },
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        item["quantity"].toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          setState(() {
                                            item["quantity"]++;
                                          });
                                        },
                                      ),
                                      const SizedBox(width: 10),
                                      IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () =>
                                            deleteItemFromCart(index),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: totalPrice > 0
                                ? () {
                                    // call checkout function
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff403392),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Checkout \$${totalPrice.toStringAsFixed(2)}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
