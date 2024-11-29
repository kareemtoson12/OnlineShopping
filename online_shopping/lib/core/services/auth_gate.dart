import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/features/home/view.dart';
import 'package:online_shopping/features/login/view.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //if user logeed in
          if (snapshot.hasData) {
            return const Homescreen();
          }
          //if  use not logged in

          else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
