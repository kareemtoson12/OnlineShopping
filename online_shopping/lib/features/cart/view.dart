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
      0,
      (sum, item) => sum + (item['price'] * item['quantity']),
    );

    Future<void> handleCheckout() async {
      try {
        final user = FirebaseAuth.instance.currentUser;

        if (user == null) {
          throw 'No user is logged in.';
        }

        final transactionId = FirebaseFirestore.instance
            .collection('transactions')
            .doc()
            .id; // Generate a unique transaction ID

        final transactionData = {
          'transactionId': transactionId,
          'userId': user.uid,
          'amount': totalPrice,
          'timestamp': Timestamp.now(),
          'details': cartItems.map((item) {
            return {
              'name': item['name'],
              'price': item['price'],
              'quantity': item['quantity'],
            };
          }).toList(),
        };

        // Batch to handle multiple writes
        final batch = FirebaseFirestore.instance.batch();

        // Update stock for each item in the cart
        for (var item in cartItems) {
          final productRef = FirebaseFirestore.instance
              .collection('Products')
              .doc(item['id']); // Ensure `id` is the document ID
          print('**********===');
          print(productRef);
          final productSnapshot = await productRef.get();
          if (productSnapshot.exists) {
            final currentStock = productSnapshot['stock'] ?? 0;
            final newStock = currentStock - item['quantity'];

            if (newStock < 0) {
              throw 'Insufficient stock for product: ${item['name']}';
            }

            // Add stock update to batch
            batch.update(productRef, {'stock': newStock});
          }
        }

        // Add transaction record
        final transactionRef = FirebaseFirestore.instance
            .collection('Transaction')
            .doc(transactionId);
        batch.set(transactionRef, transactionData);

        // Clear the user's cart
        final userCartRef =
            FirebaseFirestore.instance.collection('users').doc(user.uid);
        batch.update(userCartRef, {'cart': []});

        // Commit the batch
        await batch.commit();

        // Clear local cartItems
        setState(() {
          cartItems = [];
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
                'Checkout successful! Stock updated and transaction saved.'),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to complete checkout: $e')),
        );
      }
    }

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
                                            '\$${item['price']?.toString() ?? '0'}',
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
                                    handleCheckout();
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
                              "Checkout \$${totalPrice.toString()}",
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
