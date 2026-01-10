import 'package:daily_quoates/utils/input_text.dart';
import 'package:daily_quoates/utils/utils.dart';
import 'package:daily_quoates/view_model/state_management/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPass extends ConsumerStatefulWidget {
  const ForgotPass({super.key});

  @override
  ConsumerState<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends ConsumerState<ForgotPass> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
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
                      mainAxisAlignment: MainAxisAlignment.start,
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
                            'Forgot Password',
                            style: GoogleFonts.epilogue(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Gap(5.h),
                        Center(
                          child: Text(
                            'Don\'t worry! It happens. Please enter\nthe email associated with your\naccount.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.epilogue(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff6B7280),
                            ),
                          ),
                        ),

                        Gap(60.h),

                        InputText.topText('Email Address'),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: InputText.inputDecoration(
                            hint: 'example@gmail.com',
                            controller: _emailController,
                            suffixIcon: Icons.email_rounded,
                            validator: ValidationBuilder().email().build(),
                          ),
                        ),

                        Gap(30.h),

                        // login button
                        Utils.customButton(
                          text: 'Send Reset Link',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                await auth.resetPassword(
                                  context,
                                  _emailController,
                                );
                                // The snackbar is shown inside Auth().resetPassword
                                // We can navigate back after a short delay or immediately
                                if (mounted) {
                                  Navigator.pop(context);
                                }
                              } catch (e) {
                                Utils.showSnackBar(
                                  context,
                                  'An error occurred',
                                );
                              }
                            }
                          },
                        ),

                        Gap(30.h),

                        //  don't have an account
                        Utils.customTextButton(
                          'Remember password? ',
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
}
