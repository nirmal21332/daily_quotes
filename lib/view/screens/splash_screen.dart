import 'package:animated_loading_bar/animated_loading_bar.dart';
import 'package:daily_quoates/view_model/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Wrapper()),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Gap(155.5.h),

          // Logo Daily quotes
          Image.asset(
            'assets/logo.png',
            fit: BoxFit.cover,
            height: 150.h,
            width: 150.w,
          ),
          Gap(90.h),
          Center(
            child: Text(
              'Daily Quotes',
              style: GoogleFonts.epilogue(fontSize: 34
                  .sp, letterSpacing: -1),
            ),
          ),
          // read save and inspire
          subTitle(),


          Spacer(),
          // loading bar
          ClipRRect(
            borderRadius: BorderRadius.circular(1000),
            child: Container(
              width: 110.w,
              child: AnimatedLoadingBar(
                height: 8.h,
                duration: Duration(seconds: 3),
                colors: [
                  Color(0xff4B39EF),
                  Color(0xff4B39EF),
                  Color(0xff4B39EF),
                  Color(0xff4B39EF),
                ],
              ),
            ),
          ),
          Gap(100.h),
        ],
      ),
    );
  }

  Widget subTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'READ',
          style: GoogleFonts.epilogue(
            fontSize: 10.sp,
            letterSpacing: 2.5,
            color: Color(0xff8A8A9E),
          ),
        ),
        Text(
          ' ● ',
          style: GoogleFonts.inter(
            fontSize: 7.sp,
            letterSpacing: 2.5,
            color: Color(0xff8A8A9E),
          ),
        ),
        Text(
          'SAVE',
          style: GoogleFonts.epilogue(
            fontSize: 10.sp,
            letterSpacing: 2.5,
            color: Color(0xff8A8A9E),
          ),
        ),
        Text(
          ' ● ',
          style: GoogleFonts.inter(
            fontSize: 7.sp,
            letterSpacing: 2.5,
            color: Color(0xff8A8A9E),
          ),
        ),
        Text(
          'INSPIRE',
          style: GoogleFonts.epilogue(
            fontSize: 10.sp,
            letterSpacing: 2.5,
            color: Color(0xff8A8A9E),
          ),
        ),
      ],
    );
  }
}
