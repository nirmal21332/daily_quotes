// ignore_for_file: must_be_immutable

import 'package:daily_quoates/utils/utils.dart';
import 'package:daily_quoates/view_model/state_management/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends ConsumerWidget {
  ProfileScreen({super.key});

  User user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var auth = ref.watch(provider);
    final isDarkMode = ref.watch(themeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: RichText(
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            text: TextSpan(
              text: 'Profile ',
              style: GoogleFonts.epilogue(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff3B32FF)),
              children: [
                TextSpan(
                  text: 'Details',
                  style: GoogleFonts.epilogue(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : Colors.black),
                ),
              ],
            ),
          )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: ListView(
          children: [
            Gap(20.h),
            _buildProfileImage(),
            Gap(40.h),
            _buildProfileName(Icons.person, user.displayName!, isDark),
            Gap(20.h),
            _buildProfileName(Icons.email, user.email!, isDark),
            Gap(20.h),
            _buildProfileName(Icons.insert_drive_file, user.uid, isDark),
            Gap(30.h),

            // ── Dark Mode Toggle ──────────────────────────────────────────
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xff1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withOpacity(0.3)
                        : const Color(0xff3B32FF).withOpacity(0.07),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.05)
                      : const Color(0xff3B32FF).withOpacity(0.08),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: const Color(0xff3B32FF).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      isDarkMode
                          ? Icons.dark_mode_rounded
                          : Icons.light_mode_rounded,
                      color: const Color(0xff3B32FF),
                      size: 20.sp,
                    ),
                  ),
                  Gap(14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dark Mode',
                          style: GoogleFonts.epilogue(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        Text(
                          isDarkMode
                              ? 'Currently enabled'
                              : 'Currently disabled',
                          style: GoogleFonts.epilogue(
                            fontSize: 11.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch.adaptive(
                    value: isDarkMode,
                    activeColor: const Color(0xff3B32FF),
                    onChanged: (val) {
                      ref.read(themeProvider.notifier).state = val;
                    },
                  ),
                ],
              ),
            ),
            // ────────────────────────────────────────────────────────────

            Gap(30.h),
            Utils.customButton(
                text: 'Log out',
                onPressed: () async {
                  await auth.signOut(context);
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xff3B32FF), Color(0xff9B8BFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: CircleAvatar(
              radius: 70.r,
              foregroundColor: Colors.black,
              backgroundImage: NetworkImage(user.photoURL!),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileName(IconData icon, String label, bool isDark) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xff4B39EF),
        ),
        Gap(20.w),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.epilogue(
                color: isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16.sp),
          ),
        ),
      ],
    );
  }
}
