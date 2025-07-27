import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/extensions/integer_sizedbox_extension.dart';
import '../../../../routes/app_route_path.dart';
import '../widgets/patient_register_form.dart';

class PatientRegisterPage extends StatelessWidget {
  const PatientRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.goNamed(AppRoute.login.name);
            }
          },
        ),
        title: Text(
          'auth.register.title'.tr(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                32.hS,
                Text(
                  'auth.register.createAccount'.tr(),
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                8.hS,
                Text(
                  'auth.register.subtitle'.tr(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey[600],
                  ),
                ),
                48.hS,
                const PatientRegisterForm(),
                24.hS,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'auth.register.alreadyHaveAccount'.tr(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to patient login page
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.goNamed(AppRoute.login.name);
                        }
                      },
                      child: Text(
                        'auth.register.signIn'.tr(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                32.hS,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
