import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/core/styles/styles.dart';

class ProductDetails extends StatefulWidget {
  final Map<String, dynamic> data;

  const ProductDetails({super.key, required this.data});

  @override
  State<ProductDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ProductDetails> {
  int q = 0; // Default quantity
  double rating = 0.0;
  final TextEditingController feedbackController = TextEditingController();

  void addd() {
    setState(() {
      q++;
    });
  }

  void minusss() {
    setState(() {
      if (q > 0) q--;
    });
  }

  Future<String?> getUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  Future<void> addToCart(
      BuildContext context, Map<String, dynamic> product) async {
    try {
      final userId = await getUserId();
      if (userId == null) {
        throw 'No user is currently logged in.';
      }

      final userRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      await userRef.set({
        'cart': FieldValue.arrayUnion([product]),
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product added to cart successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add product to cart: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> submitFeedback(BuildContext context) async {
    try {
      final user = getUserId();
      final feedback = {
        'userId': widget.data['useid'],
        'rating': rating,
        'comment': feedbackController.text,
        'timestamp': Timestamp
            .now(), // Use Timestamp.now() instead of FieldValue.serverTimestamp()
      };

      final productRef = FirebaseFirestore.instance
          .collection('Products')
          .doc(widget.data['productId']);

      print(widget.data['productId'] + '********************************');
      // Add feedback to the feedback array
      await productRef.update({
        'feedback': FieldValue.arrayUnion([feedback]),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Feedback submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      feedbackController.clear();
      setState(() {
        rating = 0.0;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to submit feedback: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
//productId

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.0.dg,
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
          'Product Information',
          style: AppTextStyles.font30blackTitle,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: CustomsColros.offPrimaryColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 10,
                spreadRadius: 5,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    data['image'] ?? '',
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.broken_image, size: 250);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  data['name'] ?? 'Product Name',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  data['productId'] ?? 'Product id',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '\$${data['price']?.toString() ?? "0"}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  data['stock'] > 0 ? "Stock: In Stock" : "Out of Stock",
                  style: TextStyle(
                    color: data['stock'] > 0 ? Colors.green : Colors.red,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  data['description'] ?? 'No description available.',
                  textAlign: TextAlign.left,
                  style: AppTextStyles.font18gray,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => addToCart(context, {
                    'id': data['id'] ?? '',
                    'name': data['name'] ?? 'Unnamed Product',
                    'price': data['price'] ?? 0,
                    'quantity': q > 0 ? q : 1,
                    'image': data['image'] ?? '',
                  }),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff403392),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Add to cart",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Submit Feedback',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 10),
                RatingBar.builder(
                  initialRating: rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (newRating) {
                    setState(() {
                      rating = newRating;
                    });
                  },
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: feedbackController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Write your feedback here...',
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => submitFeedback(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
