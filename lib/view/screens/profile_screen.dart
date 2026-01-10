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
    return Scaffold(
      appBar: AppBar(
          title: RichText(
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        text: TextSpan(
          text: 'Profile ',
          style: GoogleFonts.epilogue(
              fontSize: 25.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xff3B32FF)),
          children: [
            TextSpan(
              text: 'Details',
              style: GoogleFonts.epilogue(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ],
        ),
      )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(20.h),
            _buildProfileImage(),
            Gap(60.h),
            _buildProfileName(Icons.person, user.displayName!),
            Gap(20.h),
            _buildProfileName(Icons.email, user.email!),
            Gap(20.h),
            _buildProfileName(Icons.insert_drive_file, user.uid),
            Gap(40.h),
            Utils.customButton(
                text: 'Log out',
                onPressed: () async {
                  await auth.signOut(context);
                })
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Color.fromARGB(255, 171, 164, 232),
            width: 3.w,
          ),
        ),
        child: CircleAvatar(
          radius: 70.r,
          foregroundColor: Colors.black,
          backgroundImage: NetworkImage(user.photoURL!),
        ),
      ),
    );
  }

  Widget _buildProfileName(IconData icon, String label) {
    return Row(
      children: [
        Icon(
          icon,
          color: Color(0xff4B39EF),
        ),
        Gap(20.w),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.epilogue(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16.sp),
          ),
        ),
      ],
    );
  }
}
