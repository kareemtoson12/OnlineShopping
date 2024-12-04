import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_shopping/features/home/models/category_model.dart';
import 'package:online_shopping/features/home/models/product_model.dart';
import 'package:online_shopping/features/signUp/models/new_user_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//*****Authentication */

  // Sign in user
  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code); // Re-throw exceptions
    }
  }

  //logout user

  Future<void> logUserOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception("Error logging out: ${e.toString()}");
    }
  }

// Forget password
  Future<void> forgetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code); // Re-throw exceptions
    }
  }

  // Register user and save their data
  Future<UserCredential> registerUserWithEmailandPassword({
    required String email,
    required String password,
    required NewUserModel newUser,
  }) async {
    try {
      // Register user
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Add user ID to the model
      final updatedUser = newUser.copyWith(id: userCredential.user?.uid ?? '');

      // Save user data to Firestore
      await saveUserData(updatedUser);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code); // Re-throw exceptions
    }
  }

  // Save user data to Firestore
  Future<void> saveUserData(NewUserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toMap());
    } catch (e) {
      throw Exception('Failed to save user data: $e');
    }
  }

  //***********USER******

//get useName
  Future<String?> getUserName() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      return userDoc.data()?['userName'] as String?;
    }
    return null;
  }

// get user id
  Future<String?> getUserId() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      return user.uid;
    }
    return null;
  }

  Future<NewUserModel?> getUserById() async {
    try {
      // Fetch the current user ID asynchronously
      String? userId = await getUserId();

      if (userId == null) {
        // If no user is signed in, return null
        print('No user is signed in.');
        return null;
      }

      // Fetch user document from the Firestore `users` collection
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists && userDoc.data() != null) {
        // Convert the document data to a NewUserModel
        return NewUserModel.fromJson(userDoc.data()!);
      } else {
        // User document not found
        print('User not found in Firestore.');
        return null;
      }
    } catch (e) {
      // Log and rethrow the error for further handling
      print('Error fetching user by ID: $e');
      rethrow;
    }
  }

  Future<void> updateUserData(NewUserModel updatedUser) async {
    try {
      await _firestore
          .collection('users')
          .doc(updatedUser.id)
          .update(updatedUser.toMap());
    } catch (e) {
      throw Exception('Failed to update user data: $e');
    }
  }

  /// Update a single field in the Firestore `users` collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'An error occurred while updating field.');
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }

  //Remove a user record from Firestore
  Future<void> removeUserRecord(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'An error occurred while deleting user.');
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }

//*********CATEGORY ********/

//GET  ALL CATEGORIES
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _firestore.collection('categories').get();
      return snapshot.docs
          .map((doc) => CategoryModel.fromDocumentSnapshot(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get all categories: $e');
    }
  }

  //*********PRODUCTS********/

  /// Get all products
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await _firestore.collection('Products').get();
      return snapshot.docs
          .map((doc) => ProductModel.fromDocumentSnapshot(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get all products: $e');
    }
  }

  /// Add a new product
  Future<void> addProduct(ProductModel product) async {
    try {
      await _firestore.collection('products').add(product.toJson());
    } catch (e) {
      throw Exception('Failed to add product: $e');
    }
  }

  /// Update product details
  Future<void> updateProduct(
      String productId, ProductModel updatedProduct) async {
    try {
      await _firestore
          .collection('products')
          .doc(productId)
          .update(updatedProduct.toJson());
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }

  /// Delete a product
  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection('products').doc(productId).delete();
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }
}
