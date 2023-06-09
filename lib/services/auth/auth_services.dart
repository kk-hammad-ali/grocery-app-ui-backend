import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery/constants/common_functions.dart';
import 'package:grocery/constants/firebase_constant.dart';
import 'package:grocery/models/user_model.dart';
import 'package:grocery/provider/order_provider.dart';
import 'package:grocery/screens/fetch/fetch_screen.dart';
import 'package:grocery/screens/signin/signin_screen.dart';
import 'package:grocery/services/auth/auth_firestore.dart';

class AuthServices {
  Future<void> createAccountWithEmailPassword({
    required String email,
    required String password,
    required context,
    required String name,
    required String address,
  }) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      AuthFireStore.setUserData(
        firebaseAuth.currentUser!.uid,
        UserModel(
          id: firebaseAuth.currentUser!.uid,
          name: name,
          email: email,
          address: address,
          wishlist: [],
          cart: [],
        ),
      );
      Navigator.pushReplacementNamed(context, SignInScreen.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CommonFunction.errorToast(
          error: 'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        CommonFunction.errorToast(
          error: 'The account already exists for that email.',
        );
      } else if (e.code == 'operation-not-allowed') {
        CommonFunction.errorToast(
          error: 'There is a problem with auth service config.',
        );
      } else {
        CommonFunction.errorToast(
          error: '$e',
        );
      }
    }
  }

  Future<void> loginUserWithEmailPassword({
    required String email,
    required String password,
    required context,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushReplacementNamed(context, FetchScreen.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        CommonFunction.errorToast(
          error: 'The password provided is wrong.',
        );
      } else if (e.code == 'user-not-found') {
        CommonFunction.errorToast(
          error: 'No user found with this email.',
        );
      } else if (e.code == 'user-disabled') {
        CommonFunction.errorToast(
          error: 'User disabled.',
        );
      } else if (e.code == 'invalid-email') {
        CommonFunction.errorToast(
          error: 'Email address is invalid.',
        );
      } else {
        CommonFunction.errorToast(
          error: 'Login failed. Please try again.',
        );
      }
    }
  }

  Future<void> signOut({required context}) async {
    try {
      OrderProvider.orders = [];
      await firebaseAuth.signOut();
    } catch (e) {
      CommonFunction.errorToast(
        error: 'Logout failed. Please try again.',
      );
    }
  }
}
