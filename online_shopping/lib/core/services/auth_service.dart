import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_shopping/features/signUp/models/new_user_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

//get useName
  Future<String?> getUserName() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      return userDoc.data()?['userName'] as String?;
    }
    return null;
  }
}
