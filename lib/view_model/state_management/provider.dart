import 'package:daily_quoates/repository/auth_repository.dart';
import 'package:daily_quoates/view_model/firebase/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:daily_quoates/model/quote_model.dart';
import 'package:flutter_riverpod/legacy.dart';

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

// Dark mode provider
final themeProvider = StateProvider<bool>((ref) => false);

// Deleted quotes provider (stores IDs of deleted quotes)
final deletedQuotesProvider = StateProvider<Set<int>>((ref) => {});
