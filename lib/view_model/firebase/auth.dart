import 'package:daily_quoates/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user() => firebaseAuth.currentUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  // ignore: body_might_complete_normally_nullable
  Future<UserCredential?> signInUser(
    TextEditingController emailController,
    TextEditingController passwordController,
    BuildContext context,
  ) async {
    try {
      return await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Utils.showSnackBar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Utils.showSnackBar(context, 'Wrong password provided for that user.');
      } else {
        Utils.showSnackBar(context, e.message ?? 'Authentication failed');
      }
    } catch (e) {
      Utils.showSnackBar(context, 'System Error');
    }
    return null;
  }

  // ignore: body_might_complete_normally_nullable
  Future<UserCredential?> createUser(
    TextEditingController emailController,
    TextEditingController passwordController,
    BuildContext context,
  ) async {
    try {
      return await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Utils.showSnackBar(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Utils.showSnackBar(
          context,
          'The account already exists for that email.',
        );
      } else {
        Utils.showSnackBar(context, e.message ?? 'Registration failed');
      }
    } catch (e) {
      Utils.showSnackBar(context, 'System Error');
    }
    return null;
  }

  Future<void> resetPassword(
    BuildContext context,
    TextEditingController emailController,
  ) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: emailController.text);
      Utils.showSnackBar(context, 'Password reset link sent to your email.');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Show success message even if user not found for security/privacy
        Utils.showSnackBar(context, 'Password reset link sent to your email.');
      } else {
        Utils.showSnackBar(context, e.message ?? 'Failed to send reset email');
      }
    } catch (e) {
      Utils.showSnackBar(context, 'System Error');
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await firebaseAuth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      Utils.showSnackBar(context, 'System Error');
    }
  }

  Future<UserCredential?> googleSignIn(BuildContext context) async {
    try {
      // select google account
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return null;
      }
      // get google account details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // create firebase credentials
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      if (context.mounted) {
        Utils.showSnackBar(context, 'Google Sign-In failed');
      }
      return null;
    }
  }
}
