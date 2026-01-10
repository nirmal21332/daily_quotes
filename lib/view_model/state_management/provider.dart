import 'package:daily_quoates/repository/auth_repository.dart';
import 'package:daily_quoates/view_model/firebase/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod/riverpod.dart';
import 'package:daily_quoates/model/quote_model.dart';

final provider = Provider((ref) {
  return Auth();
});

final authStateChange = StreamProvider<User?>((ref) {
  return ref.watch(provider).authStateChanges;
});

final authRepository = Provider((ref) {
  return AuthRepository();
});

final quoteProvider =
    FutureProvider.family<List<Quote>, BuildContext>((ref, context) {
  return ref.watch(authRepository).loginApi(context);
});
