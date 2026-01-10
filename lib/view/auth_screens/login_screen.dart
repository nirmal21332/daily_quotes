import 'package:daily_quoates/resources/bottom_nav_bar.dart' as nav;
import 'package:daily_quoates/utils/input_text.dart';
import 'package:daily_quoates/utils/routes_name.dart';
import 'package:daily_quoates/utils/utils.dart';
import 'package:daily_quoates/view_model/state_management/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var auth = ref.watch(provider);
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight.h),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(10.h),
                        Center(
                          child: Image.asset(
                            'assets/logo.png',
                            fit: BoxFit.contain,
                            height: 110.h,
                            width: 110.w,
                          ),
                        ),
                        Center(
                          child: Text(
                            'Welcome Back',
                            style: GoogleFonts.epilogue(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Center(
                          child: Text(
                            'Login to continue your daily inspiration',
                            style: GoogleFonts.epilogue(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff6B7280),
                            ),
                          ),
                        ),
                        Gap(20.h),
                        // google auth
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              foregroundColor: Colors.black,
                              minimumSize: Size(double.infinity, 50.h),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r),
                                side: BorderSide(color: Color(0xffE5E7EB)),
                              ),
                            ),
                            onPressed: () async {
                              await auth.googleSignIn(context).then((value) {
                                if (value != null) {
                                  nav.index = 0;
                                }
                              });
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/google logo.png',
                                  height: 24.h,
                                ),
                                const Gap(12),
                                Text(
                                  'Sign in with Google',
                                  style: GoogleFonts.epilogue(
                                    fontSize: 15.sp,
                                    color: const Color(0xff374151),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Gap(10.h),

                        // or divider
                        orDivider(),
                        Gap(10.h),

                        InputText.topText('Email'),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: InputText.inputDecoration(
                            hint: 'name@example.com',
                            controller: _emailController,
                            icon: Icons.email_outlined,
                            validator: ValidationBuilder().email().build(),
                          ),
                        ),

                        Gap(10.h),
                        InputText.topText('Password'),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: InputText.inputDecoration(
                            hint: 'Enter your password',
                            controller: _passController,
                            icon: Icons.lock_rounded,
                            suffixIcon: Icons.remove_red_eye_outlined,
                            validator: ValidationBuilder()
                                .minLength(6)
                                .maxLength(20)
                                .build(),
                          ),
                        ),

                        Gap(10.h),

                        forgotPass(),

                        Gap(20.h),

                        // login button
                        Utils.customButton(
                          text: 'Login ➜',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                if (mounted) {
                                  await auth
                                      .signInUser(
                                    _emailController,
                                    _passController,
                                    context,
                                  )
                                      .then((value) {
                                    if (value != null) {
                                      nav.index = 0;
                                    }
                                  });
                                }
                              } catch (e) {
                                Utils.showSnackBar(
                                  context,
                                  'Something went wrong',
                                );
                              }
                            }
                          },
                        ),
                        Gap(25.h),
                        //  don't have an account
                        Utils.customTextButton(
                          'Don\'t have an account? ',
                          ' Sign up',
                          () {
                            Navigator.pushNamed(
                              context,
                              RoutesName.signUpScreen,
                            );
                          },
                        ),
                        Gap(70.h),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget orDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(child: Divider(color: Color(0xffE5E7EB), thickness: 1)),
          Text(
            '    or    ',
            style:
                GoogleFonts.epilogue(fontSize: 15.sp, color: Color(0xff9CA3AF)),
          ),
          Expanded(child: Divider(color: Color(0xffE5E7EB), thickness: 1)),
        ],
      ),
    );
  }

  Widget forgotPass() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RoutesName.forgotPasswordScreen);
            },
            child: Text(
              'Forgot Password?',
              style: GoogleFonts.epilogue(
                  fontSize: 15.sp, color: Color(0xff4B39EF)),
            ),
          ),
        ],
      ),
    );
  }
}
