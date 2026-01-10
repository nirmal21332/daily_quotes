import 'package:daily_quoates/resources/bottom_nav_bar.dart' as nav;
import 'package:daily_quoates/utils/input_text.dart';
import 'package:daily_quoates/utils/utils.dart';
import 'package:daily_quoates/view_model/state_management/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var auth = ref.watch(provider);
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
                            'Create Account',
                            style: GoogleFonts.epilogue(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Center(
                          child: Text(
                            'Join Daily Quotes today!',
                            style: GoogleFonts.epilogue(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff6B7280),
                            ),
                          ),
                        ),
                        Gap(25.h),
                        // google auth
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              foregroundColor: Colors.black,
                              minimumSize: Size(double.infinity, 45.h),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(color: Color(0xffE5E7EB)),
                              ),
                            ),
                            onPressed: () async {
                              await auth.googleSignIn(context).then((value) {
                                if (value != null) {
                                  nav.index = 1;
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
                                Gap(12.w),
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

                        Gap(20.h),
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
                        Gap(20.h),
                        InputText.topText('Confirm Password'),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: InputText.inputDecoration(
                            hint: 'Enter your password',
                            controller: _confirmPassController,
                            icon: Icons.lock_reset_rounded,
                            validator: (value) {
                              if (value != _passController.text) {
                                return 'Passwords does not match';
                              }
                              return null;
                            },
                          ),
                        ),

                        Gap(30.h),

                        // login button
                        Utils.customButton(
                          text: 'Sign Up',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                await auth
                                    .createUser(
                                  _emailController,
                                  _passController,
                                  context,
                                )
                                    .then(
                                  (value) {
                                    if (value != null) {
                                      nav.index = 1;
                                      Utils.showSnackBar(
                                        context,
                                        'User created successfully',
                                      );
                                    }
                                  },
                                );
                              } catch (e) {
                                Utils.showSnackBar(context, e.toString());
                              }
                            }
                          },
                        ),

                        Gap(20.h),

                        //  don't have an account
                        Utils.customTextButton(
                          'Already have an account? ',
                          ' Login',
                          () {
                            Navigator.pop(context);
                          },
                        ),
                        Gap(50.h),
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
            style: GoogleFonts.inter(fontSize: 15.sp, color: Color(0xff9CA3AF)),
          ),
          Expanded(child: Divider(color: Color(0xffE5E7EB), thickness: 1)),
        ],
      ),
    );
  }
}
