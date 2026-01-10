import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InputText {
  static TextFormField inputDecoration({
    required String hint,
    required TextEditingController controller,
    String? Function(String?)? validator,
    IconData? icon,
    IconData? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        prefixIconColor: Color(0xff9CA3AF),
        suffixIconColor: Color(0xff9CA3AF),
        suffixIcon: Icon(suffixIcon),
        hintText: hint,
        hintStyle:
            GoogleFonts.epilogue(fontSize: 15.sp, color: Color(0xff9CA3AF)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Color(0xffE5E7EB), width: 1.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Color(0xffE5E7EB), width: 1.w),
        ),
      ),
    );
  }

  static topText(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 25.w),
      child: Text(
        text,
        style: GoogleFonts.epilogue(fontSize: 15, color: Color(0xff374151)),
      ),
    );
  }
}
