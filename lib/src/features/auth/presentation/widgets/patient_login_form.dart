import 'package:clinic/src/routes/app_route_path.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/extensions/integer_sizedbox_extension.dart';

class PatientLoginForm extends StatefulWidget {
  const PatientLoginForm({super.key});

  @override
  State<PatientLoginForm> createState() => _PatientLoginFormState();
}

class _PatientLoginFormState extends State<PatientLoginForm> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin(BuildContext context) {
    // Simple UI feedback without business logic
    setState(() {
      _isLoading = true;
    });

    // Simulate loading
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('auth.login.loginSuccess'.tr()),
            backgroundColor: Colors.blue,
          ),
        );
      }
    });
    context.goNamed(
      AppRoute.home.name,
      pathParameters: {
        'user_id': 'dummy_user_123',
        'email': 'patient@example.com',
        'username': 'DummyPatient',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Phone Number Field
        TextFormField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'auth.login.phoneNumber'.tr(),
            hintText: 'auth.login.phoneHint'.tr(),
            prefixIcon: const Icon(Icons.phone),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
        24.hS,

        // Password Field
        TextFormField(
          controller: _passwordController,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            labelText: 'auth.login.password'.tr(),
            hintText: 'auth.login.passwordHint'.tr(),
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
        ),

        // Forgot Password
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('auth.login.forgotPasswordMessage'.tr()),
                ),
              );
            },
            child: Text(
              'auth.login.forgotPassword'.tr(),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),

        24.hS,

        // Login Button
        SizedBox(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton(
            onPressed: _isLoading ? null : () => _handleLogin(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: _isLoading
                ? SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    'auth.login.loginButton'.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
