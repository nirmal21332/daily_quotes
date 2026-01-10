import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Utils {
  static customButton({required String text, required VoidCallback onPressed}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: Color.fromARGB(255, 169, 161, 248),
          elevation: 3,
          backgroundColor: Color(0xff4B39EF),
          minimumSize: Size(double.infinity, 45.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        onPressed: () => onPressed(),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.epilogue(fontSize: 17.sp, color: Colors.white),
          ),
        ),
      ),
    );
  }

  static customTextButton(
    String firstText,
    String secondText,
    VoidCallback onPressed,
  ) {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: firstText,
              style: GoogleFonts.epilogue(fontSize: 15.sp, color: Colors.black),
            ),
            TextSpan(
              text: secondText,
              recognizer: TapGestureRecognizer()..onTap = () => onPressed(),
              style: GoogleFonts.epilogue(
                fontSize: 15.sp,
                color: Color(0xff4B39EF),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.inter(color: Colors.white)),
        backgroundColor: const Color(0xff4B39EF),
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        margin: EdgeInsets.all(16.w),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
