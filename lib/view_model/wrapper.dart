import 'package:daily_quoates/resources/bottom_nav_bar.dart';
import 'package:daily_quoates/view/auth_screens/login_screen.dart';
import 'package:daily_quoates/view_model/state_management/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Wrapper extends ConsumerWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var authState = ref.watch(authStateChange);
    return Scaffold(
      body: authState.when(data: (data) {
        if (data != null) {
          return const BottomNavBar();
        } else {
          return const LoginScreen();
        }
      }, error: (error, stackTrace) {
        return const Center(child: Text("Something went wrong"));
      }, loading: () {
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
